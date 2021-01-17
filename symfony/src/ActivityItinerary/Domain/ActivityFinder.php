<?php

declare(strict_types=1);

namespace Academy\ActivityItinerary\Domain;

use Academy\Activity\Domain\Activity;
use Academy\Itinerary\Domain\IItineraryGuard;
use Academy\Itinerary\Domain\ItineraryUuid;
use Psr\Log\LoggerInterface;

final class ActivityFinder
{
    private IItineraryGuard $itineraryGuard;
    private ActivityItineraryRepository $activityItineraryRepository;
    private LoggerInterface $logger;

    public function __construct(
        IItineraryGuard $itineraryGuard,
        ActivityItineraryRepository $activityItineraryRepository,
        LoggerInterface $logger
    )
    {
        $this->itineraryGuard = $itineraryGuard;
        $this->activityItineraryRepository = $activityItineraryRepository;
        $this->logger = $logger;
    }

    public function __invoke(
        ItineraryUuid $itineraryUuid
    ): ?array
    {
        $this->itineraryGuard->guard($itineraryUuid);

        $this->logger->info("Activity list found for itinerary uuid: {$itineraryUuid->value()}");

        return [
            'itinerary_uuid' => $itineraryUuid->value(),
            'activities' => $this->_toArray(
                $this->activityItineraryRepository->searchActivitiesByItineraryUuid($itineraryUuid)
            )
        ];
    }

    private function _toArray(array $activityList): array
    {
        $response = [];

        foreach ($activityList as $activity) {
            $response[] = [
                'activity_name' => $activity['name.value'],
                'order' => $activity['position.value'],
                'level' => $activity['level.value'],
                'time' => $activity['time.value'],
                'solution' => $this->jsonSolutionsToString($activity['answers.value'])
            ];
        }

        return $response;
    }

    private function jsonSolutionsToString(string $solutions): string
    {
        return implode(
            Activity::SEPARATOR_FOR_SOLUTIONS,
            json_decode($solutions, true, 512, JSON_THROW_ON_ERROR) ?? []
        );
    }
}