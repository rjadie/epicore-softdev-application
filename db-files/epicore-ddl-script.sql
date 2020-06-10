-- Drop Table Statements:

DROP TABLE [PatientAssessment];
go

DROP TABLE [EthnicityType];
go

DROP TABLE [PatientIdentificationType];
go

DROP TABLE [MedicationCategory];
go

DROP TABLE [CVDRiskEngineType];
go

DROP TABLE [AssessmentInterval];
go

DROP TABLE [Pharmacist];
go

DROP TABLE [PatientCVDRiskFactor];
go

DROP TABLE [TreatmentSite];
go

DROP TABLE [PatientStatus];
go

DROP TABLE [CVDRiskFactorType];
go

DROP TABLE [AssessmentMedication];
go

DROP TABLE [PatientIdentification];
go

DROP TABLE [CVDRiskFactorMetric];
go

DROP TABLE [PatientStatusType];
go

DROP TABLE [Patient];
go

--Create Table Statements:

CREATE TABLE [Patient] (
  [PatientID] int NOT NULL Identity(1,1),
  [PharmacistID] int,
  [EthnicityTypeID] int,
  [FirstName] varchar(25),
  [LastName] varchar(25),
  [Age] int,
  [Gender] varchar(10),
  [PhysicianIsInformed] bit,
  PRIMARY KEY ([PatientID])
);

CREATE INDEX [FK] ON  [Patient] ([PharmacistID], [EthnicityTypeID]);

CREATE TABLE [PatientStatusType] (
  [PatientStatusTypeID] int NOT NULL Identity(1,1),
  [StatusTypeDescription] varchar(50),
  PRIMARY KEY ([PatientStatusTypeID])
);

CREATE TABLE [CVDRiskFactorMetric] (
  [CVDRiskFactorMetricID] int NOT NULL Identity(1,1),
  [CVDRiskFactorTypeID] int,
  [RiskFactorDescription] varchar(200),
  PRIMARY KEY ([CVDRiskFactorMetricID])
);

CREATE INDEX [FK] ON  [CVDRiskFactorMetric] ([CVDRiskFactorTypeID]);

CREATE TABLE [PatientIdentification] (
  [PatientIdentificationID] int NOT NULL Identity(1,1),
  [PatientIdentificationTypeID] int,
  [PatientID] int,
  [IdentificationNotes] varchar(50),
  PRIMARY KEY ([PatientIdentificationID])
);

CREATE INDEX [FK] ON  [PatientIdentification] ([PatientIdentificationTypeID], [PatientID]);

CREATE TABLE [AssessmentMedication] (
  [AssessmentMedicationID] int NOT NULL Identity(1,1),
  [PatientAssessmentID] int,
  [MedicationCategoryID] int,
  [MedicationName] varchar(25),
  [MedicationDosage] varchar(25),
  PRIMARY KEY ([AssessmentMedicationID])
);

CREATE INDEX [FK] ON  [AssessmentMedication] ([PatientAssessmentID], [MedicationCategoryID]);

CREATE TABLE [CVDRiskFactorType] (
  [CVDRiskFactorTypeID] int NOT NULL Identity(1,1),
  [RiskFactorTypeDescription] varchar(50),
  PRIMARY KEY ([CVDRiskFactorTypeID])
);

CREATE TABLE [PatientStatus] (
  [PatientStatusID] int NOT NULL Identity(1,1),
  [PatientStatusTypeID] int,
  [PatientID] int,
  [IsActiveStatus] bit,
  [StatusNotes] varchar(50),
  PRIMARY KEY ([PatientStatusID])
);

CREATE INDEX [FK] ON  [PatientStatus] ([PatientStatusTypeID], [PatientID]);

CREATE TABLE [TreatmentSite] (
  [TreatmentSiteID] int NOT NULL Identity(1,1),
  [SiteName] varchar(25),
  [Address] varchar(25),
  [City] varchar(25),
  [PostalCode] char(6),
  PRIMARY KEY ([TreatmentSiteID])
);

CREATE TABLE [PatientCVDRiskFactor] (
  [PatientCVDRiskFactorID] int NOT NULL Identity(1,1),
  [PatientID] int,
  [CVDRiskFactorMetricID] int,
  [AdditionalDetails] varchar(50),
  [YearsWithRiskFactor] int,
  PRIMARY KEY ([PatientCVDRiskFactorID])
);

CREATE INDEX [FK] ON  [PatientCVDRiskFactor] ([PatientID], [CVDRiskFactorMetricID]);

CREATE TABLE [Pharmacist] (
  [PharmacistID] int NOT NULL Identity(1,1),
  [TreatmentSiteID] int,
  [FirstName] varchar(25),
  [LastName] varchar(25),
  PRIMARY KEY ([PharmacistID])
);

CREATE INDEX [FK] ON  [Pharmacist] ([TreatmentSiteID]);

CREATE TABLE [AssessmentInterval] (
  [AssessmentIntervalID] int NOT NULL Identity(1,1),
  [IntervalName] varchar(10),
  PRIMARY KEY ([AssessmentIntervalID])
);

CREATE TABLE [CVDRiskEngineType] (
  [CVDRiskEngineTypeID] int NOT NULL Identity(1,1),
  [EngineName] varchar(100),
  [EngineDescription] varchar(100),
  PRIMARY KEY ([CVDRiskEngineTypeID])
);

CREATE TABLE [MedicationCategory] (
  [MedicationCategoryID] int NOT NULL Identity(1,1),
  [CategoryName] varchar(25),
  PRIMARY KEY ([MedicationCategoryID])
);

CREATE TABLE [PatientIdentificationType] (
  [PatientIdentificationTypeID] int NOT NULL Identity(1,1),
  [PatientIdentificationType] varchar(75),
  PRIMARY KEY ([PatientIdentificationTypeID])
);

CREATE TABLE [EthnicityType] (
  [EthnicityTypeID] int NOT NULL Identity(1,1),
  [EthnicityTypeDescription] varchar(75),
  PRIMARY KEY ([EthnicityTypeID])
);

CREATE TABLE [PatientAssessment] (
  [PatientAssessmentID] int NOT NULL Identity(1,1),
  [PatientID] int,
  [AssessmentIntervalID] int,
  [CVDRiskEngineTypeID] int,
  [CVDRiskPercent] decimal(18, 2),
  [IsCarriedForward] bit,
  [AssessmentDateTime] datetime2,
  [SystolicBloodPressure] int,
  [DiastolicBloodPressure] int,
  [WaistCircumference] int,
  [Weight] decimal(18, 2),
  [Height] decimal(18, 2),
  [HbA1C] decimal(18, 2),
  [IsCurrentSmoker] bit,
  [HasSedentaryLifestyle] bit,
  [LDLC] decimal(18, 2),
  [HDL] decimal(18, 2),
  [Triglycerides] decimal(18, 2),
  [TotalCholesterol] decimal(18, 2),
  [EstimatedGlomerularFiltrationRate] decimal(18, 2),
  [AlbuminToCreatinineRatio] decimal(18, 2),
  PRIMARY KEY ([PatientAssessmentID])
);

CREATE INDEX [FK] ON  [PatientAssessment] ([PatientID], [AssessmentIntervalID], [CVDRiskEngineTypeID]);

INSERT INTO TreatmentSite(SiteName, Address, City, PostalCode)
VALUES('Pharmacy 1', '12345 67 St', 'Edmonton', 'T5T5T5')

INSERT INTO Pharmacist(TreatmentSiteID, FirstName, LastName)
VALUES(1, 'Pharmacist', 'One')

INSERT INTO EthnicityType(EthnicityTypeDescription)
VALUES('Caucasian/Other'),
	  ('African/Caribbean'),
	  ('Asian (oriental)/South Asian (Indian, Pakistani, Sri Lankan, Bangladesh')

INSERT INTO Patient(PharmacistID, EthnicityTypeID, FirstName, LastName, Age, Gender, PhysicianIsInformed)
VALUES(1, 1, 'Joe', 'Patient', 65, 'Male', 1),
	  (1, 1, 'Bob', 'Patient', 65, 'Male', 1),
	  (1, 1, 'Frank', 'Patient', 65, 'Male', 1),
	  (1, 1, 'Jack', 'Patient', 65, 'Male', 1),
	  (1, 1, 'Liz', 'Patient', 65, 'Female', 1),
	  (1, 1, 'Fran', 'Patient', 65, 'Female', 1),
	  (1, 1, 'Gerty', 'Patient', 65, 'Female', 1),
	  (1, 1, 'Barb', 'Patient', 65, 'Female', 1)

INSERT INTO PatientIdentificationType(PatientIdentificationType)
VALUES('Receiving metformin (marker for type 2 diabetes)'), 
	  ('Receiving clopidogrel or acetylsalicylic acid (for coronary artery disease)'),
	  ('Receiving antihypertensive agents'),
	  ('Receiving statins (dyslipidemic patients)'),
	  ('Known smoker'),
	  ('Newspaper'),
	  ('Other advertising'),
	  ('Pharmacy heart health clinic')

INSERT INTO PatientIdentification(PatientIdentificationTypeID, PatientID)
VALUES(1, 1),
	  (2, 2),
	  (3, 3),
	  (4, 4),
	  (5, 5),
	  (6, 6),
	  (7, 7),
	  (8, 8)

INSERT INTO PatientStatusType(StatusTypeDescription)
VALUES('Did not meet inclusion criteria'),
	  ('Declined to participate'),
	  ('Other'),
	  ('Unconsenting'),
	  ('Unable to follow up'),
	  ('Pregnant'),
	  ('Accepted'),
	  ('Usual Care'),
	  ('Intervention'),
	  ('Lost to follow up'),
	  ('Withdrew consent'),
	  ('Moved away') 

INSERT INTO PatientStatus(PatientStatusTypeID, PatientID, IsActiveStatus)
VALUES(7, 1, 1),
	  (7, 2, 1),
	  (7, 3, 1),
	  (7, 4, 1),
	  (7, 5, 1),
	  (7, 6, 1),
	  (7, 7, 1),
	  (7, 8, 1)

INSERT INTO CVDRiskFactorType(RiskFactorTypeDescription)
VALUES('Diabetes'),
	  ('Chronic Kidney Disease'),
	  ('Atherosclerotic Vascular Disease'),
	  ('Multiple Factors Present'),
	  ('Uncontrolled Risk Factor')

INSERT INTO CVDRiskFactorMetric(CVDRiskFactorTypeID, RiskFactorDescription)
VALUES(1, 'Type 1 Diabetes'),
	  (1, 'Type 2 Diabetes'),
	  (2, 'Estimated glomerular filtration rate of <60 ml/min/1.73 m2 on 2 consecutive measurements within a 3-month period'),
	  (2, 'Albumin-to-creatinine ratio >= 30 in a single measurement or between 3 and 29 on 2 consecutive measurements within a 3-month period'),
	  (3, 'Cerebrovascular Disease - prior stroke or transient ischemic attack'),
	  (3, 'CoronaryArteryDisease - myocardial infarction, acute coronary syndrome, stable angina, or revascularization'),
	  (3, 'Peripheral Arterial Disease - symptomatic and/or ankle brachial index < 0.9'),
	  (4, 'Framingham Score - primary prevention patient with multiple risk factors and Framingham risk score > 20%'),
	  (5, 'Blood pressure > 140/90 or > 130/80 mm Hg if diabetic'),
	  (5, 'Low-density lipoprotein cholesterol (LDL-C) >2.0 mmol/l'),
	  (5, 'HbA1c > 7.0%'),
	  (5, 'Current smoker'),
	  (5, 'Currently leads a sedentary lifestyle')

INSERT INTO PatientCVDRiskFactor(PatientID, CVDRiskFactorMetricID, YearsWithRiskFactor)
VALUES(1, 2, 1),
	  (2, 3, 2),
	  (3, 4, 3),
	  (4, 5, 4),
	  (5, 7, 5),
	  (6, 9, 6),
	  (7, 10, 7),
	  (8, 8, 8)

INSERT INTO AssessmentInterval(IntervalName)
VALUES('Baseline'),
	  ('1 month'),
	  ('2 months'),
	  ('3 months')

INSERT INTO CVDRiskEngineType(EngineName, EngineDescription)
VALUES('The United Kingdom Prospective Diabetes Study', 'For diabetics'),
	  ('The International model for prediction of recurrent CVD', 'For those with previous vascular disease'),
	  ('The Framingham Risk Score', 'For patients with CKD or primary prevention patients at high risk for cardiovascular events')

INSERT INTO PatientAssessment(PatientID, AssessmentIntervalID, CVDRiskEngineTypeID, CVDRiskPercent, IsCarriedForward, AssessmentDateTime, SystolicBloodPressure, DiastolicBloodPressure, WaistCircumference, Weight, Height, HbA1C, IsCurrentSmoker, HasSedentaryLifestyle, LDLC, HDL, Triglycerides, TotalCholesterol, EstimatedGlomerularFiltrationRate, AlbuminToCreatinineRatio)
VALUES(1, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (2, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (3, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (4, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (5, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (6, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (7, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100),
	  (8, 1, 3, 20.5, 0, '2020-06-10 01:45', 140, 100, 50, 250, 150, 50, 1, 1, 50, 50, 100, 100, 100, 100)

INSERT INTO MedicationCategory(CategoryName)
VALUES('Hypoglycemic Medication'),
	  ('Hypertension Medication'),
	  ('Dyslipidemia Medication')

INSERT INTO AssessmentMedication(PatientAssessmentID, MedicationCategoryID, MedicationName, MedicationDosage)
VALUES(1, 1, 'Ibuprofen', '1 extra strength'),
	  (2, 2, 'Ibuprofen', '1 extra strength'),
	  (3, 3, 'Ibuprofen', '1 extra strength'),
	  (4, 1, 'Ibuprofen', '1 extra strength'),
	  (5, 2, 'Ibuprofen', '1 extra strength'),
	  (6, 3, 'Ibuprofen', '1 extra strength'),
	  (7, 1, 'Ibuprofen', '1 extra strength'),
	  (8, 2, 'Ibuprofen', '1 extra strength')