CREATE TABLE `itineraries` (
  `uuid` char(36) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `students` (
  `uuid` char(36) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `activities` (
  `uuid` char(36) NOT NULL,
  `name` varchar(32) NOT NULL,
  `level` integer NOT NULL,
  `time` integer NOT NULL,
  `answers` JSON NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `activities_itineraries` (
   `uuid` char(36) NOT NULL,
  `itinerary_uuid` char(36) NOT NULL,
  `activity_uuid` char(36) NOT NULL,
  `position` integer NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY (`activity_uuid`, `position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `evaluations` (
   `uuid` char(36) NOT NULL,
  `itinerary_uuid` char(36) NOT NULL,
  `activity_uuid` char(36) NOT NULL,
  `student_uuid` char(36) NOT NULL,
  `score` integer NOT NULL,
  `inverted_time` integer NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `students_itineraries_progress` (
   `uuid` char(36) NOT NULL,
  `itinerary_uuid` char(36) NOT NULL,
  `student_uuid` char(36) NOT NULL,
  `previous_activity_uuid` char(36) DEFAULT NULL,
  `next_activity_uuid` char(36) DEFAULT NULL,
  `increased_level` boolean DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE activities_itineraries ADD CONSTRAINT itinerary_FK FOREIGN KEY (itinerary_uuid) REFERENCES itineraries(uuid);
ALTER TABLE activities_itineraries ADD CONSTRAINT activity_FK FOREIGN KEY (activity_uuid) REFERENCES activities(uuid);

ALTER TABLE evaluations ADD CONSTRAINT student_activity_itinerary_FK FOREIGN KEY (itinerary_uuid) REFERENCES itineraries(uuid);
ALTER TABLE evaluations ADD CONSTRAINT student_activity_activity_FK FOREIGN KEY (activity_uuid) REFERENCES activities(uuid);
ALTER TABLE evaluations ADD CONSTRAINT student_activity_student_FK FOREIGN KEY (student_uuid) REFERENCES students(uuid);

ALTER TABLE students_itineraries_progress ADD CONSTRAINT student_itinerary_itinerary_FK FOREIGN KEY (itinerary_uuid) REFERENCES itineraries(uuid);
ALTER TABLE students_itineraries_progress ADD CONSTRAINT student_itinerary_student_FK FOREIGN KEY (student_uuid) REFERENCES students(uuid);
ALTER TABLE students_itineraries_progress ADD CONSTRAINT previous_activity_FK FOREIGN KEY (previous_activity_uuid) REFERENCES activities(uuid);
ALTER TABLE students_itineraries_progress ADD CONSTRAINT next_activity_FK FOREIGN KEY (next_activity_uuid) REFERENCES activities(uuid);

INSERT INTO itineraries VALUES ('99f951bf-7d49-4a1a-9152-7bdee1f5ce2e');
INSERT INTO students VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba02', 'Max');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba02', 'A1', 1, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba03', 'A2', 1, 60, '{"0":-2, "1":40, "2":56}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba04', 'A3', 1, 120, '{"0":1, "1":0}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba05', 'A4', 1, 180, '{"0":1, "1":0, "2":2, "3":-5, "4":9}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba06', 'A5', 2, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba07', 'A6', 2, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba08', 'A7', 3, 120, '{"0":1, "1":-1, "2":"Si", "3":34, "4":-6}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba09', 'A8', 3, 120, '{"0":1, "1":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba10', 'A9', 4, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba11', 'A10', 5, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba12', 'A11', 6, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba13', 'A12', 7, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba14', 'A13', 8, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba15', 'A14', 9, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO activities VALUES ('70f066f6-1cb7-4c45-97e2-287f0258ba16', 'A15', 10, 120, '{"0":1, "1":0, "2":2}');
INSERT INTO students_itineraries_progress VALUES ('99f951bf-7d49-4a1a-9152-7bdee1f5ce1e', '99f951bf-7d49-4a1a-9152-7bdee1f5ce2e', '70f066f6-1cb7-4c45-97e2-287f0258ba02', null, null, null);
