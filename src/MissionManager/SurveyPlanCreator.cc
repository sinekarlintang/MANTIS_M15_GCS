/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#include "SurveyPlanCreator.h"
#include "PlanMasterController.h"
#include "MissionSettingsItem.h"
#include "SurveyComplexItem.h"

SurveyPlanCreator::SurveyPlanCreator(PlanMasterController* planMasterController, QObject* parent)
    : PlanCreator(planMasterController, SurveyComplexItem::name, QStringLiteral("/qmlimages/PlanCreator/SurveyPlanCreator.png"), parent)
{

}

void SurveyPlanCreator::createPlan(const QGeoCoordinate& mapCenterCoord)
{
    _planMasterController->removeAll();
    _missionController->insertVtolTakeoffItem(mapCenterCoord, -1);
    _missionController->insertComplexMissionItem(SurveyComplexItem::name, mapCenterCoord, 1);
    // _missionController->insertVtolTransitionItem(mapCenterCoord, 4, 1);
    _missionController->insertVtolLandItem(mapCenterCoord, -1);
    _missionController->setCurrentPlanViewSeqNum(3, true);
}
