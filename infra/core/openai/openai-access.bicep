param principalID string
param roleDefinitionID string
param openaiName string

resource openai 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' existing = {
  name: openaiName
}

// Allow access to OpenAI using a managed identity
resource openaiRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(openai.id, principalID, roleDefinitionID)
  scope: openai
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionID)
    principalId: principalID
    principalType: 'ServicePrincipal'
  }
}

output ROLE_ASSIGNMENT_NAME string = openaiRoleAssignment.name
