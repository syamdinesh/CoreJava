--3.Create an endpoint on the witness server instance 
CREATE ENDPOINT Endpoint_Mirroring
    STATE=STARTED 
    AS TCP (LISTENER_PORT=7023) 
    FOR DATABASE_MIRRORING (ROLE=WITNESS)
GO
-----------------------------------------------------