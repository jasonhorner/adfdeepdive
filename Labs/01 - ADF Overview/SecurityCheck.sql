-- Role Memberships
SELECT 'Database Role' AS Type, Role.name AS RoleName, 
Member.name AS MemberName 
FROM sys.database_role_members AS DRM
JOIN sys.database_principals AS Member
    ON DRM.member_principal_id = Member.principal_ID
RIGHT OUTER JOIN sys.database_principals AS Role
    ON DRM.role_principal_id = Role.principal_id
WHERE Role.type_desc = 'DATABASE_ROLE'
ORDER BY RoleName, MemberName;

-- Permissions
SELECT Prin.name, state_desc, permission_name, class_desc, major_id
FROM sys.database_principals AS Prin
JOIN sys.database_permissions AS Perm
    ON Prin.principal_id = Perm.grantee_principal_id
WHERE prin.name <> 'Public'
ORDER BY name;