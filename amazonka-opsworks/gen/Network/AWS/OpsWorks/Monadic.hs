{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.OpsWorks.Monadic
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | This module is provided for convenience. It offers an alternative to the
-- common idiom of supplying required fields to an operations's smart constructor,
-- using the operation's lenses to modify additional fields, and then sending
-- or paginating the request.
--
-- As an example: using "Network.AWS.OpsWorks" with the smart constructor and
-- basic lens syntax, before explicitly calling 'send':
--
-- @
-- import Control.Monad.Trans.AWS
-- import Network.AWS.OpsWorks
--
-- send $ (mkOperationName w x)
--      & onLensField1 .~ y
--      & onLensField2 .~ z
-- @
--
-- Versus using "Network.AWS.OpsWorks.Monadic" with the 'State' operator variants from
-- "Control.Lens.Setter" such as '.=' to modify any additional request
-- parameters before sending:
--
-- @
-- import Control.Applicative
-- import Network.AWS.OpsWorks.Monadic
--
-- operationName w x $ do
--     onLensField1 .= y
--     onLensField2 .= z
--
-- -- Or to void any additional parameters outside of those required using 'Control.Applicative.empty':
-- operationName w x empty
-- @
--
module Network.AWS.OpsWorks.Monadic
    (
    -- * AssignVolume
    -- $AssignVolume
      assignVolume
    , assignVolumeCatch

    -- * AssociateElasticIp
    -- $AssociateElasticIp
    , associateElasticIp
    , associateElasticIpCatch

    -- * AttachElasticLoadBalancer
    -- $AttachElasticLoadBalancer
    , attachElasticLoadBalancer
    , attachElasticLoadBalancerCatch

    -- * CloneStack
    -- $CloneStack
    , cloneStack
    , cloneStackCatch

    -- * CreateApp
    -- $CreateApp
    , createApp
    , createAppCatch

    -- * CreateDeployment
    -- $CreateDeployment
    , createDeployment
    , createDeploymentCatch

    -- * CreateInstance
    -- $CreateInstance
    , createInstance
    , createInstanceCatch

    -- * CreateLayer
    -- $CreateLayer
    , createLayer
    , createLayerCatch

    -- * CreateStack
    -- $CreateStack
    , createStack
    , createStackCatch

    -- * CreateUserProfile
    -- $CreateUserProfile
    , createUserProfile
    , createUserProfileCatch

    -- * DeleteApp
    -- $DeleteApp
    , deleteApp
    , deleteAppCatch

    -- * DeleteInstance
    -- $DeleteInstance
    , deleteInstance
    , deleteInstanceCatch

    -- * DeleteLayer
    -- $DeleteLayer
    , deleteLayer
    , deleteLayerCatch

    -- * DeleteStack
    -- $DeleteStack
    , deleteStack
    , deleteStackCatch

    -- * DeleteUserProfile
    -- $DeleteUserProfile
    , deleteUserProfile
    , deleteUserProfileCatch

    -- * DeregisterElasticIp
    -- $DeregisterElasticIp
    , deregisterElasticIp
    , deregisterElasticIpCatch

    -- * DeregisterRdsDbInstance
    -- $DeregisterRdsDbInstance
    , deregisterRdsDbInstance
    , deregisterRdsDbInstanceCatch

    -- * DeregisterVolume
    -- $DeregisterVolume
    , deregisterVolume
    , deregisterVolumeCatch

    -- * DescribeApps
    -- $DescribeApps
    , describeApps
    , describeAppsCatch

    -- * DescribeCommands
    -- $DescribeCommands
    , describeCommands
    , describeCommandsCatch

    -- * DescribeDeployments
    -- $DescribeDeployments
    , describeDeployments
    , describeDeploymentsCatch

    -- * DescribeElasticIps
    -- $DescribeElasticIps
    , describeElasticIps
    , describeElasticIpsCatch

    -- * DescribeElasticLoadBalancers
    -- $DescribeElasticLoadBalancers
    , describeElasticLoadBalancers
    , describeElasticLoadBalancersCatch

    -- * DescribeInstances
    -- $DescribeInstances
    , describeInstances
    , describeInstancesCatch

    -- * DescribeLayers
    -- $DescribeLayers
    , describeLayers
    , describeLayersCatch

    -- * DescribeLoadBasedAutoScaling
    -- $DescribeLoadBasedAutoScaling
    , describeLoadBasedAutoScaling
    , describeLoadBasedAutoScalingCatch

    -- * DescribeMyUserProfile
    -- $DescribeMyUserProfile
    , describeMyUserProfile
    , describeMyUserProfileCatch

    -- * DescribePermissions
    -- $DescribePermissions
    , describePermissions
    , describePermissionsCatch

    -- * DescribeRaidArrays
    -- $DescribeRaidArrays
    , describeRaidArrays
    , describeRaidArraysCatch

    -- * DescribeRdsDbInstances
    -- $DescribeRdsDbInstances
    , describeRdsDbInstances
    , describeRdsDbInstancesCatch

    -- * DescribeServiceErrors
    -- $DescribeServiceErrors
    , describeServiceErrors
    , describeServiceErrorsCatch

    -- * DescribeStackSummary
    -- $DescribeStackSummary
    , describeStackSummary
    , describeStackSummaryCatch

    -- * DescribeStacks
    -- $DescribeStacks
    , describeStacks
    , describeStacksCatch

    -- * DescribeTimeBasedAutoScaling
    -- $DescribeTimeBasedAutoScaling
    , describeTimeBasedAutoScaling
    , describeTimeBasedAutoScalingCatch

    -- * DescribeUserProfiles
    -- $DescribeUserProfiles
    , describeUserProfiles
    , describeUserProfilesCatch

    -- * DescribeVolumes
    -- $DescribeVolumes
    , describeVolumes
    , describeVolumesCatch

    -- * DetachElasticLoadBalancer
    -- $DetachElasticLoadBalancer
    , detachElasticLoadBalancer
    , detachElasticLoadBalancerCatch

    -- * DisassociateElasticIp
    -- $DisassociateElasticIp
    , disassociateElasticIp
    , disassociateElasticIpCatch

    -- * GetHostnameSuggestion
    -- $GetHostnameSuggestion
    , getHostnameSuggestion
    , getHostnameSuggestionCatch

    -- * RebootInstance
    -- $RebootInstance
    , rebootInstance
    , rebootInstanceCatch

    -- * RegisterElasticIp
    -- $RegisterElasticIp
    , registerElasticIp
    , registerElasticIpCatch

    -- * RegisterRdsDbInstance
    -- $RegisterRdsDbInstance
    , registerRdsDbInstance
    , registerRdsDbInstanceCatch

    -- * RegisterVolume
    -- $RegisterVolume
    , registerVolume
    , registerVolumeCatch

    -- * SetLoadBasedAutoScaling
    -- $SetLoadBasedAutoScaling
    , setLoadBasedAutoScaling
    , setLoadBasedAutoScalingCatch

    -- * SetPermission
    -- $SetPermission
    , setPermission
    , setPermissionCatch

    -- * SetTimeBasedAutoScaling
    -- $SetTimeBasedAutoScaling
    , setTimeBasedAutoScaling
    , setTimeBasedAutoScalingCatch

    -- * StartInstance
    -- $StartInstance
    , startInstance
    , startInstanceCatch

    -- * StartStack
    -- $StartStack
    , startStack
    , startStackCatch

    -- * StopInstance
    -- $StopInstance
    , stopInstance
    , stopInstanceCatch

    -- * StopStack
    -- $StopStack
    , stopStack
    , stopStackCatch

    -- * UnassignVolume
    -- $UnassignVolume
    , unassignVolume
    , unassignVolumeCatch

    -- * UpdateApp
    -- $UpdateApp
    , updateApp
    , updateAppCatch

    -- * UpdateElasticIp
    -- $UpdateElasticIp
    , updateElasticIp
    , updateElasticIpCatch

    -- * UpdateInstance
    -- $UpdateInstance
    , updateInstance
    , updateInstanceCatch

    -- * UpdateLayer
    -- $UpdateLayer
    , updateLayer
    , updateLayerCatch

    -- * UpdateMyUserProfile
    -- $UpdateMyUserProfile
    , updateMyUserProfile
    , updateMyUserProfileCatch

    -- * UpdateRdsDbInstance
    -- $UpdateRdsDbInstance
    , updateRdsDbInstance
    , updateRdsDbInstanceCatch

    -- * UpdateStack
    -- $UpdateStack
    , updateStack
    , updateStackCatch

    -- * UpdateUserProfile
    -- $UpdateUserProfile
    , updateUserProfile
    , updateUserProfileCatch

    -- * UpdateVolume
    -- $UpdateVolume
    , updateVolume
    , updateVolumeCatch

    -- * Re-exported
    , module Network.AWS.OpsWorks

    , (.=)
    , (?=)
    , (<>=)
    , (%=)
    ) where

import Control.Monad.Trans.AWS as AWS
import Network.AWS.Prelude
import Network.AWS.OpsWorks

type ServiceEr = Er OpsWorks

-- $AssignVolume
-- Assigns one of the stack's registered Amazon EBS volumes to a specified
-- instance. The volume must first be registered with the stack by calling
-- RegisterVolume. For more information, see Resource Management. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.AssignVolume'

assignVolume :: ( MonadCatch m
                , MonadResource m
                , MonadError AWS.Error m
                , MonadReader Env m
                )
    => Text -- ^ 'avVolumeId'
    -> m AssignVolumeResponse
assignVolume p1 s =
    send $ (mkAssignVolume p1) &~ s

assignVolumeCatch :: ( MonadCatch m
                     , MonadResource m
                     , MonadReader Env m
                     )
    => Text -- ^ 'avVolumeId'
    -> m (Either ServiceEr AssignVolumeResponse)
assignVolumeCatch p1 s =
    sendCatch $ (mkAssignVolume p1) &~ s

-- $AssociateElasticIp
-- Associates one of the stack's registered Elastic IP addresses with a
-- specified instance. The address must first be registered with the stack by
-- calling RegisterElasticIp. For more information, see Resource Management.
-- Required Permissions: To use this action, an IAM user must have a Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.AssociateElasticIp'

associateElasticIp :: ( MonadCatch m
                      , MonadResource m
                      , MonadError AWS.Error m
                      , MonadReader Env m
                      )
    => Text -- ^ 'aeiElasticIp'
    -> m AssociateElasticIpResponse
associateElasticIp p1 s =
    send $ (mkAssociateElasticIp p1) &~ s

associateElasticIpCatch :: ( MonadCatch m
                           , MonadResource m
                           , MonadReader Env m
                           )
    => Text -- ^ 'aeiElasticIp'
    -> m (Either ServiceEr AssociateElasticIpResponse)
associateElasticIpCatch p1 s =
    sendCatch $ (mkAssociateElasticIp p1) &~ s

-- $AttachElasticLoadBalancer
-- Attaches an Elastic Load Balancing load balancer to a specified layer. For
-- more information, see Elastic Load Balancing. You must create the Elastic
-- Load Balancing instance separately, by using the Elastic Load Balancing
-- console, API, or CLI. For more information, see Elastic Load Balancing
-- Developer Guide. Required Permissions: To use this action, an IAM user must
-- have a Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.AttachElasticLoadBalancer'

attachElasticLoadBalancer :: ( MonadCatch m
                             , MonadResource m
                             , MonadError AWS.Error m
                             , MonadReader Env m
                             )
    => Text -- ^ 'aelbElasticLoadBalancerName'
    -> Text -- ^ 'aelbLayerId'
    -> m AttachElasticLoadBalancerResponse
attachElasticLoadBalancer p1 p2 s =
    send $ (mkAttachElasticLoadBalancer p1 p2) &~ s

attachElasticLoadBalancerCatch :: ( MonadCatch m
                                  , MonadResource m
                                  , MonadReader Env m
                                  )
    => Text -- ^ 'aelbElasticLoadBalancerName'
    -> Text -- ^ 'aelbLayerId'
    -> m (Either ServiceEr AttachElasticLoadBalancerResponse)
attachElasticLoadBalancerCatch p1 p2 s =
    sendCatch $ (mkAttachElasticLoadBalancer p1 p2) &~ s

-- $CloneStack
-- Creates a clone of a specified stack. For more information, see Clone a
-- Stack. Required Permissions: To use this action, an IAM user must have an
-- attached policy that explicitly grants permissions. For more information on
-- user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CloneStack'

cloneStack :: ( MonadCatch m
              , MonadResource m
              , MonadError AWS.Error m
              , MonadReader Env m
              )
    => Text -- ^ 'csSourceStackId'
    -> Text -- ^ 'csServiceRoleArn'
    -> m CloneStackResponse
cloneStack p1 p6 s =
    send $ (mkCloneStack p1 p6) &~ s

cloneStackCatch :: ( MonadCatch m
                   , MonadResource m
                   , MonadReader Env m
                   )
    => Text -- ^ 'csSourceStackId'
    -> Text -- ^ 'csServiceRoleArn'
    -> m (Either ServiceEr CloneStackResponse)
cloneStackCatch p1 p6 s =
    sendCatch $ (mkCloneStack p1 p6) &~ s

-- $CreateApp
-- Creates an app for a specified stack. For more information, see Creating
-- Apps. Required Permissions: To use this action, an IAM user must have a
-- Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateApp'

createApp :: ( MonadCatch m
             , MonadResource m
             , MonadError AWS.Error m
             , MonadReader Env m
             )
    => Text -- ^ 'caStackId'
    -> Text -- ^ 'caName'
    -> AppType -- ^ 'caType'
    -> m CreateAppResponse
createApp p1 p3 p6 s =
    send $ (mkCreateApp p1 p3 p6) &~ s

createAppCatch :: ( MonadCatch m
                  , MonadResource m
                  , MonadReader Env m
                  )
    => Text -- ^ 'caStackId'
    -> Text -- ^ 'caName'
    -> AppType -- ^ 'caType'
    -> m (Either ServiceEr CreateAppResponse)
createAppCatch p1 p3 p6 s =
    sendCatch $ (mkCreateApp p1 p3 p6) &~ s

-- $CreateDeployment
-- Deploys a stack or app. App deployment generates a deploy event, which runs
-- the associated recipes and passes them a JSON stack configuration object
-- that includes information about the app. Stack deployment runs the deploy
-- recipes but does not raise an event. For more information, see Deploying
-- Apps and Run Stack Commands. Required Permissions: To use this action, an
-- IAM user must have a Deploy or Manage permissions level for the stack, or
-- an attached policy that explicitly grants permissions. For more information
-- on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateDeployment'

createDeployment :: ( MonadCatch m
                    , MonadResource m
                    , MonadError AWS.Error m
                    , MonadReader Env m
                    )
    => Text -- ^ 'cdStackId'
    -> DeploymentCommand -- ^ 'cdCommand'
    -> m CreateDeploymentResponse
createDeployment p1 p4 s =
    send $ (mkCreateDeployment p1 p4) &~ s

createDeploymentCatch :: ( MonadCatch m
                         , MonadResource m
                         , MonadReader Env m
                         )
    => Text -- ^ 'cdStackId'
    -> DeploymentCommand -- ^ 'cdCommand'
    -> m (Either ServiceEr CreateDeploymentResponse)
createDeploymentCatch p1 p4 s =
    sendCatch $ (mkCreateDeployment p1 p4) &~ s

-- $CreateInstance
-- Creates an instance in a specified stack. For more information, see Adding
-- an Instance to a Layer. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateInstance'

createInstance :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'ciStackId'
    -> [Text] -- ^ 'ciLayerIds'
    -> Text -- ^ 'ciInstanceType'
    -> m CreateInstanceResponse
createInstance p1 p2 p3 s =
    send $ (mkCreateInstance p1 p2 p3) &~ s

createInstanceCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'ciStackId'
    -> [Text] -- ^ 'ciLayerIds'
    -> Text -- ^ 'ciInstanceType'
    -> m (Either ServiceEr CreateInstanceResponse)
createInstanceCatch p1 p2 p3 s =
    sendCatch $ (mkCreateInstance p1 p2 p3) &~ s

-- $CreateLayer
-- Creates a layer. For more information, see How to Create a Layer. You
-- should use CreateLayer for noncustom layer types such as PHP App Server
-- only if the stack does not have an existing layer of that type. A stack can
-- have at most one instance of each noncustom layer; if you attempt to create
-- a second instance, CreateLayer fails. A stack can have an arbitrary number
-- of custom layers, so you can call CreateLayer as many times as you like for
-- that layer type. Required Permissions: To use this action, an IAM user must
-- have a Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateLayer'

createLayer :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'clStackId'
    -> LayerType -- ^ 'clType'
    -> Text -- ^ 'clName'
    -> Text -- ^ 'clShortname'
    -> m CreateLayerResponse
createLayer p1 p2 p3 p4 s =
    send $ (mkCreateLayer p1 p2 p3 p4) &~ s

createLayerCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'clStackId'
    -> LayerType -- ^ 'clType'
    -> Text -- ^ 'clName'
    -> Text -- ^ 'clShortname'
    -> m (Either ServiceEr CreateLayerResponse)
createLayerCatch p1 p2 p3 p4 s =
    sendCatch $ (mkCreateLayer p1 p2 p3 p4) &~ s

-- $CreateStack
-- Creates a new stack. For more information, see Create a New Stack. Required
-- Permissions: To use this action, an IAM user must have an attached policy
-- that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateStack'

createStack :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'cs1Name'
    -> Text -- ^ 'cs1Region'
    -> Text -- ^ 'cs1ServiceRoleArn'
    -> Text -- ^ 'cs1DefaultInstanceProfileArn'
    -> m CreateStackResponse
createStack p1 p2 p5 p6 s =
    send $ (mkCreateStack p1 p2 p5 p6) &~ s

createStackCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'cs1Name'
    -> Text -- ^ 'cs1Region'
    -> Text -- ^ 'cs1ServiceRoleArn'
    -> Text -- ^ 'cs1DefaultInstanceProfileArn'
    -> m (Either ServiceEr CreateStackResponse)
createStackCatch p1 p2 p5 p6 s =
    sendCatch $ (mkCreateStack p1 p2 p5 p6) &~ s

-- $CreateUserProfile
-- Creates a new user profile. Required Permissions: To use this action, an
-- IAM user must have an attached policy that explicitly grants permissions.
-- For more information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.CreateUserProfile'

createUserProfile :: ( MonadCatch m
                     , MonadResource m
                     , MonadError AWS.Error m
                     , MonadReader Env m
                     )
    => Text -- ^ 'cupIamUserArn'
    -> m CreateUserProfileResponse
createUserProfile p1 s =
    send $ (mkCreateUserProfile p1) &~ s

createUserProfileCatch :: ( MonadCatch m
                          , MonadResource m
                          , MonadReader Env m
                          )
    => Text -- ^ 'cupIamUserArn'
    -> m (Either ServiceEr CreateUserProfileResponse)
createUserProfileCatch p1 s =
    sendCatch $ (mkCreateUserProfile p1) &~ s

-- $DeleteApp
-- Deletes a specified app. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeleteApp'

deleteApp :: ( MonadCatch m
             , MonadResource m
             , MonadError AWS.Error m
             , MonadReader Env m
             )
    => Text -- ^ 'daAppId'
    -> m DeleteAppResponse
deleteApp p1 s =
    send $ (mkDeleteApp p1) &~ s

deleteAppCatch :: ( MonadCatch m
                  , MonadResource m
                  , MonadReader Env m
                  )
    => Text -- ^ 'daAppId'
    -> m (Either ServiceEr DeleteAppResponse)
deleteAppCatch p1 s =
    sendCatch $ (mkDeleteApp p1) &~ s

-- $DeleteInstance
-- Deletes a specified instance. You must stop an instance before you can
-- delete it. For more information, see Deleting Instances. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeleteInstance'

deleteInstance :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'diInstanceId'
    -> m DeleteInstanceResponse
deleteInstance p1 s =
    send $ (mkDeleteInstance p1) &~ s

deleteInstanceCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'diInstanceId'
    -> m (Either ServiceEr DeleteInstanceResponse)
deleteInstanceCatch p1 s =
    sendCatch $ (mkDeleteInstance p1) &~ s

-- $DeleteLayer
-- Deletes a specified layer. You must first stop and then delete all
-- associated instances. For more information, see How to Delete a Layer.
-- Required Permissions: To use this action, an IAM user must have a Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeleteLayer'

deleteLayer :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'dlLayerId'
    -> m DeleteLayerResponse
deleteLayer p1 s =
    send $ (mkDeleteLayer p1) &~ s

deleteLayerCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'dlLayerId'
    -> m (Either ServiceEr DeleteLayerResponse)
deleteLayerCatch p1 s =
    sendCatch $ (mkDeleteLayer p1) &~ s

-- $DeleteStack
-- Deletes a specified stack. You must first delete all instances, layers, and
-- apps. For more information, see Shut Down a Stack. Required Permissions: To
-- use this action, an IAM user must have a Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeleteStack'

deleteStack :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'ds1StackId'
    -> m DeleteStackResponse
deleteStack p1 s =
    send $ (mkDeleteStack p1) &~ s

deleteStackCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'ds1StackId'
    -> m (Either ServiceEr DeleteStackResponse)
deleteStackCatch p1 s =
    sendCatch $ (mkDeleteStack p1) &~ s

-- $DeleteUserProfile
-- Deletes a user profile. Required Permissions: To use this action, an IAM
-- user must have an attached policy that explicitly grants permissions. For
-- more information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeleteUserProfile'

deleteUserProfile :: ( MonadCatch m
                     , MonadResource m
                     , MonadError AWS.Error m
                     , MonadReader Env m
                     )
    => Text -- ^ 'dupIamUserArn'
    -> m DeleteUserProfileResponse
deleteUserProfile p1 s =
    send $ (mkDeleteUserProfile p1) &~ s

deleteUserProfileCatch :: ( MonadCatch m
                          , MonadResource m
                          , MonadReader Env m
                          )
    => Text -- ^ 'dupIamUserArn'
    -> m (Either ServiceEr DeleteUserProfileResponse)
deleteUserProfileCatch p1 s =
    sendCatch $ (mkDeleteUserProfile p1) &~ s

-- $DeregisterElasticIp
-- Deregisters a specified Elastic IP address. The address can then be
-- registered by another stack. For more information, see Resource Management.
-- Required Permissions: To use this action, an IAM user must have a Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeregisterElasticIp'

deregisterElasticIp :: ( MonadCatch m
                       , MonadResource m
                       , MonadError AWS.Error m
                       , MonadReader Env m
                       )
    => Text -- ^ 'deiElasticIp'
    -> m DeregisterElasticIpResponse
deregisterElasticIp p1 s =
    send $ (mkDeregisterElasticIp p1) &~ s

deregisterElasticIpCatch :: ( MonadCatch m
                            , MonadResource m
                            , MonadReader Env m
                            )
    => Text -- ^ 'deiElasticIp'
    -> m (Either ServiceEr DeregisterElasticIpResponse)
deregisterElasticIpCatch p1 s =
    sendCatch $ (mkDeregisterElasticIp p1) &~ s

-- $DeregisterRdsDbInstance
-- Deregisters an Amazon RDS instance.
--
-- See: 'Network.AWS.OpsWorks.DeregisterRdsDbInstance'

deregisterRdsDbInstance :: ( MonadCatch m
                           , MonadResource m
                           , MonadError AWS.Error m
                           , MonadReader Env m
                           )
    => Text -- ^ 'drdiRdsDbInstanceArn'
    -> m DeregisterRdsDbInstanceResponse
deregisterRdsDbInstance p1 s =
    send $ (mkDeregisterRdsDbInstance p1) &~ s

deregisterRdsDbInstanceCatch :: ( MonadCatch m
                                , MonadResource m
                                , MonadReader Env m
                                )
    => Text -- ^ 'drdiRdsDbInstanceArn'
    -> m (Either ServiceEr DeregisterRdsDbInstanceResponse)
deregisterRdsDbInstanceCatch p1 s =
    sendCatch $ (mkDeregisterRdsDbInstance p1) &~ s

-- $DeregisterVolume
-- Deregisters an Amazon EBS volume. The volume can then be registered by
-- another stack. For more information, see Resource Management. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.DeregisterVolume'

deregisterVolume :: ( MonadCatch m
                    , MonadResource m
                    , MonadError AWS.Error m
                    , MonadReader Env m
                    )
    => Text -- ^ 'dvVolumeId'
    -> m DeregisterVolumeResponse
deregisterVolume p1 s =
    send $ (mkDeregisterVolume p1) &~ s

deregisterVolumeCatch :: ( MonadCatch m
                         , MonadResource m
                         , MonadReader Env m
                         )
    => Text -- ^ 'dvVolumeId'
    -> m (Either ServiceEr DeregisterVolumeResponse)
deregisterVolumeCatch p1 s =
    sendCatch $ (mkDeregisterVolume p1) &~ s

-- $DescribeApps
-- Requests a description of a specified set of apps. You must specify at
-- least one of the parameters. Required Permissions: To use this action, an
-- IAM user must have a Show, Deploy, or Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeApps'

describeApps :: ( MonadCatch m
                , MonadResource m
                , MonadError AWS.Error m
                , MonadReader Env m
                )
    => State DescribeApps a
    -> m DescribeAppsResponse
describeApps s =
    send (mkDescribeApps &~ s)

describeAppsCatch :: ( MonadCatch m
                     , MonadResource m
                     , MonadReader Env m
                     )
    => State DescribeApps a
    -> m (Either ServiceEr DescribeAppsResponse)
describeAppsCatch s =
    sendCatch (mkDescribeApps &~ s)

-- $DescribeCommands
-- Describes the results of specified commands. You must specify at least one
-- of the parameters. Required Permissions: To use this action, an IAM user
-- must have a Show, Deploy, or Manage permissions level for the stack, or an
-- attached policy that explicitly grants permissions. For more information on
-- user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeCommands'

describeCommands :: ( MonadCatch m
                    , MonadResource m
                    , MonadError AWS.Error m
                    , MonadReader Env m
                    )
    => State DescribeCommands a
    -> m DescribeCommandsResponse
describeCommands s =
    send (mkDescribeCommands &~ s)

describeCommandsCatch :: ( MonadCatch m
                         , MonadResource m
                         , MonadReader Env m
                         )
    => State DescribeCommands a
    -> m (Either ServiceEr DescribeCommandsResponse)
describeCommandsCatch s =
    sendCatch (mkDescribeCommands &~ s)

-- $DescribeDeployments
-- Requests a description of a specified set of deployments. You must specify
-- at least one of the parameters. Required Permissions: To use this action,
-- an IAM user must have a Show, Deploy, or Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeDeployments'

describeDeployments :: ( MonadCatch m
                       , MonadResource m
                       , MonadError AWS.Error m
                       , MonadReader Env m
                       )
    => State DescribeDeployments a
    -> m DescribeDeploymentsResponse
describeDeployments s =
    send (mkDescribeDeployments &~ s)

describeDeploymentsCatch :: ( MonadCatch m
                            , MonadResource m
                            , MonadReader Env m
                            )
    => State DescribeDeployments a
    -> m (Either ServiceEr DescribeDeploymentsResponse)
describeDeploymentsCatch s =
    sendCatch (mkDescribeDeployments &~ s)

-- $DescribeElasticIps
-- Describes Elastic IP addresses. You must specify at least one of the
-- parameters. Required Permissions: To use this action, an IAM user must have
-- a Show, Deploy, or Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeElasticIps'

describeElasticIps :: ( MonadCatch m
                      , MonadResource m
                      , MonadError AWS.Error m
                      , MonadReader Env m
                      )
    => State DescribeElasticIps a
    -> m DescribeElasticIpsResponse
describeElasticIps s =
    send (mkDescribeElasticIps &~ s)

describeElasticIpsCatch :: ( MonadCatch m
                           , MonadResource m
                           , MonadReader Env m
                           )
    => State DescribeElasticIps a
    -> m (Either ServiceEr DescribeElasticIpsResponse)
describeElasticIpsCatch s =
    sendCatch (mkDescribeElasticIps &~ s)

-- $DescribeElasticLoadBalancers
-- Describes a stack's Elastic Load Balancing instances. You must specify at
-- least one of the parameters. Required Permissions: To use this action, an
-- IAM user must have a Show, Deploy, or Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeElasticLoadBalancers'

describeElasticLoadBalancers :: ( MonadCatch m
                                , MonadResource m
                                , MonadError AWS.Error m
                                , MonadReader Env m
                                )
    => State DescribeElasticLoadBalancers a
    -> m DescribeElasticLoadBalancersResponse
describeElasticLoadBalancers s =
    send (mkDescribeElasticLoadBalancers &~ s)

describeElasticLoadBalancersCatch :: ( MonadCatch m
                                     , MonadResource m
                                     , MonadReader Env m
                                     )
    => State DescribeElasticLoadBalancers a
    -> m (Either ServiceEr DescribeElasticLoadBalancersResponse)
describeElasticLoadBalancersCatch s =
    sendCatch (mkDescribeElasticLoadBalancers &~ s)

-- $DescribeInstances
-- Requests a description of a set of instances. You must specify at least one
-- of the parameters. Required Permissions: To use this action, an IAM user
-- must have a Show, Deploy, or Manage permissions level for the stack, or an
-- attached policy that explicitly grants permissions. For more information on
-- user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeInstances'

describeInstances :: ( MonadCatch m
                     , MonadResource m
                     , MonadError AWS.Error m
                     , MonadReader Env m
                     )
    => State DescribeInstances a
    -> m DescribeInstancesResponse
describeInstances s =
    send (mkDescribeInstances &~ s)

describeInstancesCatch :: ( MonadCatch m
                          , MonadResource m
                          , MonadReader Env m
                          )
    => State DescribeInstances a
    -> m (Either ServiceEr DescribeInstancesResponse)
describeInstancesCatch s =
    sendCatch (mkDescribeInstances &~ s)

-- $DescribeLayers
-- Requests a description of one or more layers in a specified stack. You must
-- specify at least one of the parameters. Required Permissions: To use this
-- action, an IAM user must have a Show, Deploy, or Manage permissions level
-- for the stack, or an attached policy that explicitly grants permissions.
-- For more information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeLayers'

describeLayers :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => State DescribeLayers a
    -> m DescribeLayersResponse
describeLayers s =
    send (mkDescribeLayers &~ s)

describeLayersCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => State DescribeLayers a
    -> m (Either ServiceEr DescribeLayersResponse)
describeLayersCatch s =
    sendCatch (mkDescribeLayers &~ s)

-- $DescribeLoadBasedAutoScaling
-- Describes load-based auto scaling configurations for specified layers. You
-- must specify at least one of the parameters. Required Permissions: To use
-- this action, an IAM user must have a Show, Deploy, or Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeLoadBasedAutoScaling'

describeLoadBasedAutoScaling :: ( MonadCatch m
                                , MonadResource m
                                , MonadError AWS.Error m
                                , MonadReader Env m
                                )
    => [Text] -- ^ 'dlbasLayerIds'
    -> m DescribeLoadBasedAutoScalingResponse
describeLoadBasedAutoScaling p1 s =
    send $ (mkDescribeLoadBasedAutoScaling p1) &~ s

describeLoadBasedAutoScalingCatch :: ( MonadCatch m
                                     , MonadResource m
                                     , MonadReader Env m
                                     )
    => [Text] -- ^ 'dlbasLayerIds'
    -> m (Either ServiceEr DescribeLoadBasedAutoScalingResponse)
describeLoadBasedAutoScalingCatch p1 s =
    sendCatch $ (mkDescribeLoadBasedAutoScaling p1) &~ s

-- $DescribeMyUserProfile
-- Describes a user's SSH information. Required Permissions: To use this
-- action, an IAM user must have self-management enabled or an attached policy
-- that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeMyUserProfile'

describeMyUserProfile :: ( MonadCatch m
                         , MonadResource m
                         , MonadError AWS.Error m
                         , MonadReader Env m
                         )
    => State DescribeMyUserProfile a
    -> m DescribeMyUserProfileResponse
describeMyUserProfile s =
    send (mkDescribeMyUserProfile &~ s)

describeMyUserProfileCatch :: ( MonadCatch m
                              , MonadResource m
                              , MonadReader Env m
                              )
    => State DescribeMyUserProfile a
    -> m (Either ServiceEr DescribeMyUserProfileResponse)
describeMyUserProfileCatch s =
    sendCatch (mkDescribeMyUserProfile &~ s)

-- $DescribePermissions
-- Describes the permissions for a specified stack. Required Permissions: To
-- use this action, an IAM user must have a Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribePermissions'

describePermissions :: ( MonadCatch m
                       , MonadResource m
                       , MonadError AWS.Error m
                       , MonadReader Env m
                       )
    => State DescribePermissions a
    -> m DescribePermissionsResponse
describePermissions s =
    send (mkDescribePermissions &~ s)

describePermissionsCatch :: ( MonadCatch m
                            , MonadResource m
                            , MonadReader Env m
                            )
    => State DescribePermissions a
    -> m (Either ServiceEr DescribePermissionsResponse)
describePermissionsCatch s =
    sendCatch (mkDescribePermissions &~ s)

-- $DescribeRaidArrays
-- Describe an instance's RAID arrays. You must specify at least one of the
-- parameters. Required Permissions: To use this action, an IAM user must have
-- a Show, Deploy, or Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeRaidArrays'

describeRaidArrays :: ( MonadCatch m
                      , MonadResource m
                      , MonadError AWS.Error m
                      , MonadReader Env m
                      )
    => State DescribeRaidArrays a
    -> m DescribeRaidArraysResponse
describeRaidArrays s =
    send (mkDescribeRaidArrays &~ s)

describeRaidArraysCatch :: ( MonadCatch m
                           , MonadResource m
                           , MonadReader Env m
                           )
    => State DescribeRaidArrays a
    -> m (Either ServiceEr DescribeRaidArraysResponse)
describeRaidArraysCatch s =
    sendCatch (mkDescribeRaidArrays &~ s)

-- $DescribeRdsDbInstances
-- Describes Amazon RDS instances.
--
-- See: 'Network.AWS.OpsWorks.DescribeRdsDbInstances'

describeRdsDbInstances :: ( MonadCatch m
                          , MonadResource m
                          , MonadError AWS.Error m
                          , MonadReader Env m
                          )
    => Text -- ^ 'drdi1StackId'
    -> m DescribeRdsDbInstancesResponse
describeRdsDbInstances p1 s =
    send $ (mkDescribeRdsDbInstances p1) &~ s

describeRdsDbInstancesCatch :: ( MonadCatch m
                               , MonadResource m
                               , MonadReader Env m
                               )
    => Text -- ^ 'drdi1StackId'
    -> m (Either ServiceEr DescribeRdsDbInstancesResponse)
describeRdsDbInstancesCatch p1 s =
    sendCatch $ (mkDescribeRdsDbInstances p1) &~ s

-- $DescribeServiceErrors
-- Describes AWS OpsWorks service errors. Required Permissions: To use this
-- action, an IAM user must have a Show, Deploy, or Manage permissions level
-- for the stack, or an attached policy that explicitly grants permissions.
-- For more information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeServiceErrors'

describeServiceErrors :: ( MonadCatch m
                         , MonadResource m
                         , MonadError AWS.Error m
                         , MonadReader Env m
                         )
    => State DescribeServiceErrors a
    -> m DescribeServiceErrorsResponse
describeServiceErrors s =
    send (mkDescribeServiceErrors &~ s)

describeServiceErrorsCatch :: ( MonadCatch m
                              , MonadResource m
                              , MonadReader Env m
                              )
    => State DescribeServiceErrors a
    -> m (Either ServiceEr DescribeServiceErrorsResponse)
describeServiceErrorsCatch s =
    sendCatch (mkDescribeServiceErrors &~ s)

-- $DescribeStackSummary
-- Describes the number of layers and apps in a specified stack, and the
-- number of instances in each state, such as running_setup or online.
-- Required Permissions: To use this action, an IAM user must have a Show,
-- Deploy, or Manage permissions level for the stack, or an attached policy
-- that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeStackSummary'

describeStackSummary :: ( MonadCatch m
                        , MonadResource m
                        , MonadError AWS.Error m
                        , MonadReader Env m
                        )
    => Text -- ^ 'dssStackId'
    -> m DescribeStackSummaryResponse
describeStackSummary p1 s =
    send $ (mkDescribeStackSummary p1) &~ s

describeStackSummaryCatch :: ( MonadCatch m
                             , MonadResource m
                             , MonadReader Env m
                             )
    => Text -- ^ 'dssStackId'
    -> m (Either ServiceEr DescribeStackSummaryResponse)
describeStackSummaryCatch p1 s =
    sendCatch $ (mkDescribeStackSummary p1) &~ s

-- $DescribeStacks
-- Requests a description of one or more stacks. Required Permissions: To use
-- this action, an IAM user must have a Show, Deploy, or Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeStacks'

describeStacks :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => State DescribeStacks a
    -> m DescribeStacksResponse
describeStacks s =
    send (mkDescribeStacks &~ s)

describeStacksCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => State DescribeStacks a
    -> m (Either ServiceEr DescribeStacksResponse)
describeStacksCatch s =
    sendCatch (mkDescribeStacks &~ s)

-- $DescribeTimeBasedAutoScaling
-- Describes time-based auto scaling configurations for specified instances.
-- You must specify at least one of the parameters. Required Permissions: To
-- use this action, an IAM user must have a Show, Deploy, or Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeTimeBasedAutoScaling'

describeTimeBasedAutoScaling :: ( MonadCatch m
                                , MonadResource m
                                , MonadError AWS.Error m
                                , MonadReader Env m
                                )
    => [Text] -- ^ 'dtbasInstanceIds'
    -> m DescribeTimeBasedAutoScalingResponse
describeTimeBasedAutoScaling p1 s =
    send $ (mkDescribeTimeBasedAutoScaling p1) &~ s

describeTimeBasedAutoScalingCatch :: ( MonadCatch m
                                     , MonadResource m
                                     , MonadReader Env m
                                     )
    => [Text] -- ^ 'dtbasInstanceIds'
    -> m (Either ServiceEr DescribeTimeBasedAutoScalingResponse)
describeTimeBasedAutoScalingCatch p1 s =
    sendCatch $ (mkDescribeTimeBasedAutoScaling p1) &~ s

-- $DescribeUserProfiles
-- Describe specified users. Required Permissions: To use this action, an IAM
-- user must have an attached policy that explicitly grants permissions. For
-- more information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeUserProfiles'

describeUserProfiles :: ( MonadCatch m
                        , MonadResource m
                        , MonadError AWS.Error m
                        , MonadReader Env m
                        )
    => State DescribeUserProfiles a
    -> m DescribeUserProfilesResponse
describeUserProfiles s =
    send (mkDescribeUserProfiles &~ s)

describeUserProfilesCatch :: ( MonadCatch m
                             , MonadResource m
                             , MonadReader Env m
                             )
    => State DescribeUserProfiles a
    -> m (Either ServiceEr DescribeUserProfilesResponse)
describeUserProfilesCatch s =
    sendCatch (mkDescribeUserProfiles &~ s)

-- $DescribeVolumes
-- Describes an instance's Amazon EBS volumes. You must specify at least one
-- of the parameters. Required Permissions: To use this action, an IAM user
-- must have a Show, Deploy, or Manage permissions level for the stack, or an
-- attached policy that explicitly grants permissions. For more information on
-- user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DescribeVolumes'

describeVolumes :: ( MonadCatch m
                   , MonadResource m
                   , MonadError AWS.Error m
                   , MonadReader Env m
                   )
    => State DescribeVolumes a
    -> m DescribeVolumesResponse
describeVolumes s =
    send (mkDescribeVolumes &~ s)

describeVolumesCatch :: ( MonadCatch m
                        , MonadResource m
                        , MonadReader Env m
                        )
    => State DescribeVolumes a
    -> m (Either ServiceEr DescribeVolumesResponse)
describeVolumesCatch s =
    sendCatch (mkDescribeVolumes &~ s)

-- $DetachElasticLoadBalancer
-- Detaches a specified Elastic Load Balancing instance from its layer.
-- Required Permissions: To use this action, an IAM user must have a Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DetachElasticLoadBalancer'

detachElasticLoadBalancer :: ( MonadCatch m
                             , MonadResource m
                             , MonadError AWS.Error m
                             , MonadReader Env m
                             )
    => Text -- ^ 'delb1ElasticLoadBalancerName'
    -> Text -- ^ 'delb1LayerId'
    -> m DetachElasticLoadBalancerResponse
detachElasticLoadBalancer p1 p2 s =
    send $ (mkDetachElasticLoadBalancer p1 p2) &~ s

detachElasticLoadBalancerCatch :: ( MonadCatch m
                                  , MonadResource m
                                  , MonadReader Env m
                                  )
    => Text -- ^ 'delb1ElasticLoadBalancerName'
    -> Text -- ^ 'delb1LayerId'
    -> m (Either ServiceEr DetachElasticLoadBalancerResponse)
detachElasticLoadBalancerCatch p1 p2 s =
    sendCatch $ (mkDetachElasticLoadBalancer p1 p2) &~ s

-- $DisassociateElasticIp
-- Disassociates an Elastic IP address from its instance. The address remains
-- registered with the stack. For more information, see Resource Management.
-- Required Permissions: To use this action, an IAM user must have a Manage
-- permissions level for the stack, or an attached policy that explicitly
-- grants permissions. For more information on user permissions, see Managing
-- User Permissions.
--
-- See: 'Network.AWS.OpsWorks.DisassociateElasticIp'

disassociateElasticIp :: ( MonadCatch m
                         , MonadResource m
                         , MonadError AWS.Error m
                         , MonadReader Env m
                         )
    => Text -- ^ 'dei2ElasticIp'
    -> m DisassociateElasticIpResponse
disassociateElasticIp p1 s =
    send $ (mkDisassociateElasticIp p1) &~ s

disassociateElasticIpCatch :: ( MonadCatch m
                              , MonadResource m
                              , MonadReader Env m
                              )
    => Text -- ^ 'dei2ElasticIp'
    -> m (Either ServiceEr DisassociateElasticIpResponse)
disassociateElasticIpCatch p1 s =
    sendCatch $ (mkDisassociateElasticIp p1) &~ s

-- $GetHostnameSuggestion
-- Gets a generated host name for the specified layer, based on the current
-- host name theme. Required Permissions: To use this action, an IAM user must
-- have a Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.GetHostnameSuggestion'

getHostnameSuggestion :: ( MonadCatch m
                         , MonadResource m
                         , MonadError AWS.Error m
                         , MonadReader Env m
                         )
    => Text -- ^ 'ghsLayerId'
    -> m GetHostnameSuggestionResponse
getHostnameSuggestion p1 s =
    send $ (mkGetHostnameSuggestion p1) &~ s

getHostnameSuggestionCatch :: ( MonadCatch m
                              , MonadResource m
                              , MonadReader Env m
                              )
    => Text -- ^ 'ghsLayerId'
    -> m (Either ServiceEr GetHostnameSuggestionResponse)
getHostnameSuggestionCatch p1 s =
    sendCatch $ (mkGetHostnameSuggestion p1) &~ s

-- $RebootInstance
-- Reboots a specified instance. For more information, see Starting, Stopping,
-- and Rebooting Instances. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.RebootInstance'

rebootInstance :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'riInstanceId'
    -> m RebootInstanceResponse
rebootInstance p1 s =
    send $ (mkRebootInstance p1) &~ s

rebootInstanceCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'riInstanceId'
    -> m (Either ServiceEr RebootInstanceResponse)
rebootInstanceCatch p1 s =
    sendCatch $ (mkRebootInstance p1) &~ s

-- $RegisterElasticIp
-- Registers an Elastic IP address with a specified stack. An address can be
-- registered with only one stack at a time. If the address is already
-- registered, you must first deregister it by calling DeregisterElasticIp.
-- For more information, see Resource Management. Required Permissions: To use
-- this action, an IAM user must have a Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.RegisterElasticIp'

registerElasticIp :: ( MonadCatch m
                     , MonadResource m
                     , MonadError AWS.Error m
                     , MonadReader Env m
                     )
    => Text -- ^ 'reiElasticIp'
    -> Text -- ^ 'reiStackId'
    -> m RegisterElasticIpResponse
registerElasticIp p1 p2 s =
    send $ (mkRegisterElasticIp p1 p2) &~ s

registerElasticIpCatch :: ( MonadCatch m
                          , MonadResource m
                          , MonadReader Env m
                          )
    => Text -- ^ 'reiElasticIp'
    -> Text -- ^ 'reiStackId'
    -> m (Either ServiceEr RegisterElasticIpResponse)
registerElasticIpCatch p1 p2 s =
    sendCatch $ (mkRegisterElasticIp p1 p2) &~ s

-- $RegisterRdsDbInstance
-- Registers an Amazon RDS instance with a stack.
--
-- See: 'Network.AWS.OpsWorks.RegisterRdsDbInstance'

registerRdsDbInstance :: ( MonadCatch m
                         , MonadResource m
                         , MonadError AWS.Error m
                         , MonadReader Env m
                         )
    => Text -- ^ 'rrdiStackId'
    -> Text -- ^ 'rrdiRdsDbInstanceArn'
    -> Text -- ^ 'rrdiDbUser'
    -> Text -- ^ 'rrdiDbPassword'
    -> m RegisterRdsDbInstanceResponse
registerRdsDbInstance p1 p2 p3 p4 s =
    send $ (mkRegisterRdsDbInstance p1 p2 p3 p4) &~ s

registerRdsDbInstanceCatch :: ( MonadCatch m
                              , MonadResource m
                              , MonadReader Env m
                              )
    => Text -- ^ 'rrdiStackId'
    -> Text -- ^ 'rrdiRdsDbInstanceArn'
    -> Text -- ^ 'rrdiDbUser'
    -> Text -- ^ 'rrdiDbPassword'
    -> m (Either ServiceEr RegisterRdsDbInstanceResponse)
registerRdsDbInstanceCatch p1 p2 p3 p4 s =
    sendCatch $ (mkRegisterRdsDbInstance p1 p2 p3 p4) &~ s

-- $RegisterVolume
-- Registers an Amazon EBS volume with a specified stack. A volume can be
-- registered with only one stack at a time. If the volume is already
-- registered, you must first deregister it by calling DeregisterVolume. For
-- more information, see Resource Management. Required Permissions: To use
-- this action, an IAM user must have a Manage permissions level for the
-- stack, or an attached policy that explicitly grants permissions. For more
-- information on user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.RegisterVolume'

registerVolume :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'rvStackId'
    -> m RegisterVolumeResponse
registerVolume p2 s =
    send $ (mkRegisterVolume p2) &~ s

registerVolumeCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'rvStackId'
    -> m (Either ServiceEr RegisterVolumeResponse)
registerVolumeCatch p2 s =
    sendCatch $ (mkRegisterVolume p2) &~ s

-- $SetLoadBasedAutoScaling
-- Specify the load-based auto scaling configuration for a specified layer.
-- For more information, see Managing Load with Time-based and Load-based
-- Instances. To use load-based auto scaling, you must create a set of
-- load-based auto scaling instances. Load-based auto scaling operates only on
-- the instances from that set, so you must ensure that you have created
-- enough instances to handle the maximum anticipated load. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.SetLoadBasedAutoScaling'

setLoadBasedAutoScaling :: ( MonadCatch m
                           , MonadResource m
                           , MonadError AWS.Error m
                           , MonadReader Env m
                           )
    => Text -- ^ 'slbasLayerId'
    -> m SetLoadBasedAutoScalingResponse
setLoadBasedAutoScaling p1 s =
    send $ (mkSetLoadBasedAutoScaling p1) &~ s

setLoadBasedAutoScalingCatch :: ( MonadCatch m
                                , MonadResource m
                                , MonadReader Env m
                                )
    => Text -- ^ 'slbasLayerId'
    -> m (Either ServiceEr SetLoadBasedAutoScalingResponse)
setLoadBasedAutoScalingCatch p1 s =
    sendCatch $ (mkSetLoadBasedAutoScaling p1) &~ s

-- $SetPermission
-- Specifies a user's permissions. For more information, see Security and
-- Permissions. Required Permissions: To use this action, an IAM user must
-- have a Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.SetPermission'

setPermission :: ( MonadCatch m
                 , MonadResource m
                 , MonadError AWS.Error m
                 , MonadReader Env m
                 )
    => Text -- ^ 'spStackId'
    -> Text -- ^ 'spIamUserArn'
    -> m SetPermissionResponse
setPermission p1 p2 s =
    send $ (mkSetPermission p1 p2) &~ s

setPermissionCatch :: ( MonadCatch m
                      , MonadResource m
                      , MonadReader Env m
                      )
    => Text -- ^ 'spStackId'
    -> Text -- ^ 'spIamUserArn'
    -> m (Either ServiceEr SetPermissionResponse)
setPermissionCatch p1 p2 s =
    sendCatch $ (mkSetPermission p1 p2) &~ s

-- $SetTimeBasedAutoScaling
-- Specify the time-based auto scaling configuration for a specified instance.
-- For more information, see Managing Load with Time-based and Load-based
-- Instances. Required Permissions: To use this action, an IAM user must have
-- a Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.SetTimeBasedAutoScaling'

setTimeBasedAutoScaling :: ( MonadCatch m
                           , MonadResource m
                           , MonadError AWS.Error m
                           , MonadReader Env m
                           )
    => Text -- ^ 'stbasInstanceId'
    -> m SetTimeBasedAutoScalingResponse
setTimeBasedAutoScaling p1 s =
    send $ (mkSetTimeBasedAutoScaling p1) &~ s

setTimeBasedAutoScalingCatch :: ( MonadCatch m
                                , MonadResource m
                                , MonadReader Env m
                                )
    => Text -- ^ 'stbasInstanceId'
    -> m (Either ServiceEr SetTimeBasedAutoScalingResponse)
setTimeBasedAutoScalingCatch p1 s =
    sendCatch $ (mkSetTimeBasedAutoScaling p1) &~ s

-- $StartInstance
-- Starts a specified instance. For more information, see Starting, Stopping,
-- and Rebooting Instances. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.StartInstance'

startInstance :: ( MonadCatch m
                 , MonadResource m
                 , MonadError AWS.Error m
                 , MonadReader Env m
                 )
    => Text -- ^ 'siInstanceId'
    -> m StartInstanceResponse
startInstance p1 s =
    send $ (mkStartInstance p1) &~ s

startInstanceCatch :: ( MonadCatch m
                      , MonadResource m
                      , MonadReader Env m
                      )
    => Text -- ^ 'siInstanceId'
    -> m (Either ServiceEr StartInstanceResponse)
startInstanceCatch p1 s =
    sendCatch $ (mkStartInstance p1) &~ s

-- $StartStack
-- Starts a stack's instances. Required Permissions: To use this action, an
-- IAM user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.StartStack'

startStack :: ( MonadCatch m
              , MonadResource m
              , MonadError AWS.Error m
              , MonadReader Env m
              )
    => Text -- ^ 'ss1StackId'
    -> m StartStackResponse
startStack p1 s =
    send $ (mkStartStack p1) &~ s

startStackCatch :: ( MonadCatch m
                   , MonadResource m
                   , MonadReader Env m
                   )
    => Text -- ^ 'ss1StackId'
    -> m (Either ServiceEr StartStackResponse)
startStackCatch p1 s =
    sendCatch $ (mkStartStack p1) &~ s

-- $StopInstance
-- Stops a specified instance. When you stop a standard instance, the data
-- disappears and must be reinstalled when you restart the instance. You can
-- stop an Amazon EBS-backed instance without losing data. For more
-- information, see Starting, Stopping, and Rebooting Instances. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.StopInstance'

stopInstance :: ( MonadCatch m
                , MonadResource m
                , MonadError AWS.Error m
                , MonadReader Env m
                )
    => Text -- ^ 'si1InstanceId'
    -> m StopInstanceResponse
stopInstance p1 s =
    send $ (mkStopInstance p1) &~ s

stopInstanceCatch :: ( MonadCatch m
                     , MonadResource m
                     , MonadReader Env m
                     )
    => Text -- ^ 'si1InstanceId'
    -> m (Either ServiceEr StopInstanceResponse)
stopInstanceCatch p1 s =
    sendCatch $ (mkStopInstance p1) &~ s

-- $StopStack
-- Stops a specified stack. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.StopStack'

stopStack :: ( MonadCatch m
             , MonadResource m
             , MonadError AWS.Error m
             , MonadReader Env m
             )
    => Text -- ^ 'ss2StackId'
    -> m StopStackResponse
stopStack p1 s =
    send $ (mkStopStack p1) &~ s

stopStackCatch :: ( MonadCatch m
                  , MonadResource m
                  , MonadReader Env m
                  )
    => Text -- ^ 'ss2StackId'
    -> m (Either ServiceEr StopStackResponse)
stopStackCatch p1 s =
    sendCatch $ (mkStopStack p1) &~ s

-- $UnassignVolume
-- Unassigns an assigned Amazon EBS volume. The volume remains registered with
-- the stack. For more information, see Resource Management. Required
-- Permissions: To use this action, an IAM user must have a Manage permissions
-- level for the stack, or an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.UnassignVolume'

unassignVolume :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'uvVolumeId'
    -> m UnassignVolumeResponse
unassignVolume p1 s =
    send $ (mkUnassignVolume p1) &~ s

unassignVolumeCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'uvVolumeId'
    -> m (Either ServiceEr UnassignVolumeResponse)
unassignVolumeCatch p1 s =
    sendCatch $ (mkUnassignVolume p1) &~ s

-- $UpdateApp
-- Updates a specified app. Required Permissions: To use this action, an IAM
-- user must have a Deploy or Manage permissions level for the stack, or an
-- attached policy that explicitly grants permissions. For more information on
-- user permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateApp'

updateApp :: ( MonadCatch m
             , MonadResource m
             , MonadError AWS.Error m
             , MonadReader Env m
             )
    => Text -- ^ 'uaAppId'
    -> m UpdateAppResponse
updateApp p1 s =
    send $ (mkUpdateApp p1) &~ s

updateAppCatch :: ( MonadCatch m
                  , MonadResource m
                  , MonadReader Env m
                  )
    => Text -- ^ 'uaAppId'
    -> m (Either ServiceEr UpdateAppResponse)
updateAppCatch p1 s =
    sendCatch $ (mkUpdateApp p1) &~ s

-- $UpdateElasticIp
-- Updates a registered Elastic IP address's name. For more information, see
-- Resource Management. Required Permissions: To use this action, an IAM user
-- must have a Manage permissions level for the stack, or an attached policy
-- that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateElasticIp'

updateElasticIp :: ( MonadCatch m
                   , MonadResource m
                   , MonadError AWS.Error m
                   , MonadReader Env m
                   )
    => Text -- ^ 'ueiElasticIp'
    -> m UpdateElasticIpResponse
updateElasticIp p1 s =
    send $ (mkUpdateElasticIp p1) &~ s

updateElasticIpCatch :: ( MonadCatch m
                        , MonadResource m
                        , MonadReader Env m
                        )
    => Text -- ^ 'ueiElasticIp'
    -> m (Either ServiceEr UpdateElasticIpResponse)
updateElasticIpCatch p1 s =
    sendCatch $ (mkUpdateElasticIp p1) &~ s

-- $UpdateInstance
-- Updates a specified instance. Required Permissions: To use this action, an
-- IAM user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateInstance'

updateInstance :: ( MonadCatch m
                  , MonadResource m
                  , MonadError AWS.Error m
                  , MonadReader Env m
                  )
    => Text -- ^ 'uiInstanceId'
    -> m UpdateInstanceResponse
updateInstance p1 s =
    send $ (mkUpdateInstance p1) &~ s

updateInstanceCatch :: ( MonadCatch m
                       , MonadResource m
                       , MonadReader Env m
                       )
    => Text -- ^ 'uiInstanceId'
    -> m (Either ServiceEr UpdateInstanceResponse)
updateInstanceCatch p1 s =
    sendCatch $ (mkUpdateInstance p1) &~ s

-- $UpdateLayer
-- Updates a specified layer. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateLayer'

updateLayer :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'ulLayerId'
    -> m UpdateLayerResponse
updateLayer p1 s =
    send $ (mkUpdateLayer p1) &~ s

updateLayerCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'ulLayerId'
    -> m (Either ServiceEr UpdateLayerResponse)
updateLayerCatch p1 s =
    sendCatch $ (mkUpdateLayer p1) &~ s

-- $UpdateMyUserProfile
-- Updates a user's SSH public key. Required Permissions: To use this action,
-- an IAM user must have self-management enabled or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateMyUserProfile'

updateMyUserProfile :: ( MonadCatch m
                       , MonadResource m
                       , MonadError AWS.Error m
                       , MonadReader Env m
                       )
    => State UpdateMyUserProfile a
    -> m UpdateMyUserProfileResponse
updateMyUserProfile s =
    send (mkUpdateMyUserProfile &~ s)

updateMyUserProfileCatch :: ( MonadCatch m
                            , MonadResource m
                            , MonadReader Env m
                            )
    => State UpdateMyUserProfile a
    -> m (Either ServiceEr UpdateMyUserProfileResponse)
updateMyUserProfileCatch s =
    sendCatch (mkUpdateMyUserProfile &~ s)

-- $UpdateRdsDbInstance
-- Updates an Amazon RDS instance.
--
-- See: 'Network.AWS.OpsWorks.UpdateRdsDbInstance'

updateRdsDbInstance :: ( MonadCatch m
                       , MonadResource m
                       , MonadError AWS.Error m
                       , MonadReader Env m
                       )
    => Text -- ^ 'urdiRdsDbInstanceArn'
    -> m UpdateRdsDbInstanceResponse
updateRdsDbInstance p1 s =
    send $ (mkUpdateRdsDbInstance p1) &~ s

updateRdsDbInstanceCatch :: ( MonadCatch m
                            , MonadResource m
                            , MonadReader Env m
                            )
    => Text -- ^ 'urdiRdsDbInstanceArn'
    -> m (Either ServiceEr UpdateRdsDbInstanceResponse)
updateRdsDbInstanceCatch p1 s =
    sendCatch $ (mkUpdateRdsDbInstance p1) &~ s

-- $UpdateStack
-- Updates a specified stack. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateStack'

updateStack :: ( MonadCatch m
               , MonadResource m
               , MonadError AWS.Error m
               , MonadReader Env m
               )
    => Text -- ^ 'usStackId'
    -> m UpdateStackResponse
updateStack p1 s =
    send $ (mkUpdateStack p1) &~ s

updateStackCatch :: ( MonadCatch m
                    , MonadResource m
                    , MonadReader Env m
                    )
    => Text -- ^ 'usStackId'
    -> m (Either ServiceEr UpdateStackResponse)
updateStackCatch p1 s =
    sendCatch $ (mkUpdateStack p1) &~ s

-- $UpdateUserProfile
-- Updates a specified user profile. Required Permissions: To use this action,
-- an IAM user must have an attached policy that explicitly grants
-- permissions. For more information on user permissions, see Managing User
-- Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateUserProfile'

updateUserProfile :: ( MonadCatch m
                     , MonadResource m
                     , MonadError AWS.Error m
                     , MonadReader Env m
                     )
    => Text -- ^ 'uupIamUserArn'
    -> m UpdateUserProfileResponse
updateUserProfile p1 s =
    send $ (mkUpdateUserProfile p1) &~ s

updateUserProfileCatch :: ( MonadCatch m
                          , MonadResource m
                          , MonadReader Env m
                          )
    => Text -- ^ 'uupIamUserArn'
    -> m (Either ServiceEr UpdateUserProfileResponse)
updateUserProfileCatch p1 s =
    sendCatch $ (mkUpdateUserProfile p1) &~ s

-- $UpdateVolume
-- Updates an Amazon EBS volume's name or mount point. For more information,
-- see Resource Management. Required Permissions: To use this action, an IAM
-- user must have a Manage permissions level for the stack, or an attached
-- policy that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
--
-- See: 'Network.AWS.OpsWorks.UpdateVolume'

updateVolume :: ( MonadCatch m
                , MonadResource m
                , MonadError AWS.Error m
                , MonadReader Env m
                )
    => Text -- ^ 'uv1VolumeId'
    -> m UpdateVolumeResponse
updateVolume p1 s =
    send $ (mkUpdateVolume p1) &~ s

updateVolumeCatch :: ( MonadCatch m
                     , MonadResource m
                     , MonadReader Env m
                     )
    => Text -- ^ 'uv1VolumeId'
    -> m (Either ServiceEr UpdateVolumeResponse)
updateVolumeCatch p1 s =
    sendCatch $ (mkUpdateVolume p1) &~ s
