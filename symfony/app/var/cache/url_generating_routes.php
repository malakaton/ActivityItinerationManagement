<?php

// This file has been auto-generated by the Symfony Routing Component.

return [
    '_preview_error' => [['code', '_format'], ['_controller' => 'error_controller::preview', '_format' => 'html'], ['code' => '\\d+'], [['variable', '.', '[^/]++', '_format'], ['variable', '/', '\\d+', 'code'], ['text', '/_error']], [], []],
    'itinerary_get_by_id' => [['id'], ['auth' => false, '_controller' => 'Academy\\ActivityItinerary\\EntryPoint\\Http\\Controller\\GetBookByIdController'], [], [['variable', '/', '[^/]++', 'id'], ['text', '/itineraries']], [], []],
    'itinerary_store_activity' => [['id'], ['auth' => false, '_controller' => 'Academy\\ActivityItinerary\\EntryPoint\\Http\\Controller\\AddActivityItineraryController'], [], [['text', '/activity'], ['variable', '/', '[^/]++', 'id'], ['text', '/itineraries']], [], []],
    'index' => [[], ['_controller' => 'Itinerary\\App\\Controller\\IndexController'], [], [['text', '/']], [], []],
];
