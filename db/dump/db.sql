CREATE TABLE [Film] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [title] TEXT,
  [episode_id] int,
  [opening_crawl] TEXT,
  [director] TEXT,
  [producer] TEXT,
  [release_date] timestamp
)
GO

CREATE TABLE [People] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [name] TEXT,
  [birth_year] TEXT,
  [eye_color] TEXT,
  [gender] TEXT,
  [hair_color] TEXT,
  [height] TEXT,
  [mass] TEXT,
  [skin_color] TEXT
)
GO

CREATE TABLE [Planet] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT,
  [name] TEXT,
  [diameter] TEXT,
  [rotation_period] TEXT,
  [orbital_period] TEXT,
  [gravity] TEXT,
  [population] TEXT,
  [climate] TEXT,
  [terrain] TEXT,
  [surface_water] TEXT
)
GO

CREATE TABLE [Film_People] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT
)
GO

CREATE TABLE [Film_Planet] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT
)
GO

ALTER TABLE [People] ADD COLUMN [planet_id] REFERENCES [Planets] ([id])
GO

ALTER TABLE [Film_People] ADD COLUMN [film_id] REFERENCES [Film] ([id])
GO

ALTER TABLE [Film_People] ADD COLUMN [people_id] REFERENCES [People] ([id])
GO

ALTER TABLE [Film_Planet] ADD COLUMN [film_id] REFERENCES [Film] ([id])
GO

ALTER TABLE [Film_Planet] ADD COLUMN [planet_id] REFERENCES [Planets] ([id])
GO
