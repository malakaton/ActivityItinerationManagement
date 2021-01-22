<?php

declare(strict_types=1);

namespace Academy\Tests\Mocks\Itinerary;

use Academy\Itinerary\Domain\ItineraryRepository;
use Academy\Itinerary\Domain\ItineraryUuid;
use Academy\Tests\Itinerary\Domain\ItineraryUuidMother;
use Academy\Tests\Shared\Infrastructure\PhpUnit\UnitTestCase;
use Mockery\MockInterface;

abstract class ItineraryRepositoryMockUnitTestCase extends UnitTestCase
{
    /**
     * @var $repository ItineraryRepository|MockInterface
     */
    private $repository;

    protected ItineraryUuid $existingItineraryUuid;

    protected function setUp(): void
    {
        $this->existingItineraryUuid = $this->getExistingItineraryUuid();
    }

    protected function getExistingItineraryUuid(): ItineraryUuid
    {
        return new ItineraryUuid(ItineraryUuidMother::stub_uuid);
    }

    protected function shouldSearchItinerary(ItineraryUuid $uuid): void
    {
        $this->MockRepository()
            ->shouldReceive('search')
            ->with(\Mockery::on(function($argument) use ($uuid) {
                $this->assertInstanceOf(ItineraryUuid::class, $argument);
                $this->assertSame($this->existingItineraryUuid->value(), $argument->value());
                $this->assertEquals($argument->uuid(), $uuid->value());

                return true;
            }))
            ->once()
            ->andReturn(true);
    }

//    protected function shouldSave(Book $book): void
//    {
//        $this->MockRepository()
//            ->shouldReceive('save')
//            ->with(\Mockery::on(function($argument) use ($book) {
//                $this->assertInstanceOf(Book::class, $argument);
//                $this->assertInstanceOf(BookUuid::class, $argument->uuid());
//                $this->assertInstanceOf(AuthorUuid::class, $argument->authorUuid());
//                $this->assertInstanceOf(BookTitle::class, $argument->title());
//                $this->assertInstanceOf(BookDescription::class, $argument->description());
//                $this->assertInstanceOf(BookContent::class, $argument->content());
//
//                $this->assertEquals($argument->authorUuid(), $book->authorUuid());
//                $this->assertEquals($argument->title(), $book->title());
//                $this->assertEquals($argument->description(), $book->description());
//                $this->assertEquals($argument->content(), $book->content());
//
//                return true;
//            }))
//            ->once()
//            ->andReturnNull();
//    }

    protected function shouldGetLastEvaluation(
        StudentUuid $studentUuid,
        ItineraryUuid $itineraryUuid,
        Evaluation $evaluation
    ): void {
        $this->MockRepository()
            ->shouldReceive('getEvaluationByStudentItineraryUuid')
            ->with(\Mockery::on(function($argument) use ($studentUuid, $itineraryUuid) {
                $this->assertInstanceOf(StudentUuid::class, $argument);
                $this->assertSame($this->randomEvaluationUuid->value(), $argument->value());
                $this->assertEquals($argument->value(), $studentUuid->value());

                return true;
            }))
            ->once()
            ->andReturn($evaluation);
    }

    /** @return ItineraryRepository|MockInterface */
    protected function MockRepository(): MockInterface
    {
        return $this->repository = $this->repository ?: $this->mock(ItineraryRepository::class);
    }
}