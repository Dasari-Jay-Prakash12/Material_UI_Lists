/*
 * Copyright (c) 2022 Application Library Engineering Group.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { SingleLineListModel } from './listModels/listmodels';
import { SingleLineListItems } from './listUtilities/listClasses';
import { ripple } from './animation/Ripple'
import { CommonGroupModel } from './listModels/commonGroupModel'

@Entry
@Component
export struct SingleLineListGroup {
  @State models: CommonGroupModel.Model = undefined
  @State private options: SingleLineListItems [] = []

  aboutToAppear() {
    if (this.options == undefined) {
      this.options = []
    }
  }

  build() {
    Column() {
      List() {
        ForEach(
          this.options,
          (item) => {
            ListItem() {
              SingleLineList_item({
                model2: $models,
                model: new SingleLineListModel(item.leadingContent, item.mainData, item.trailingContent, item.callback),
              })
            }
          },
        )
      }
      .divider({
        strokeWidth: (this.models.getDivider() == true) ? this.models.getDividerStrokeWidth() : 0,
        color: (this.models.getDivider() == true) ? this.models.getDividerColor() : this.models.getBackGroundColor()
      })
    }
  }
}

@Component
export struct SingleLineList_item {
  @State model: SingleLineListModel = undefined
  @Link model2: CommonGroupModel.Model
  @State private clickCoordinates: Position = { x: 0, y: 0 }
  @State  showRipple: boolean = false
  @State  rippleColor: string = '#808080'
  @State containerSize: SizeOptions = { height: '90vp', width: '350vp' }
  onClick: (event?: ClickEvent) => void

  build() {
    if (this.model != undefined && this.model.buildUI()) {
      Column() {
        Row() {
          if (this.model.getIsLeadingContentImage() == true && this.model.getIsTrailingContentImage() == true) {
            Flex({ alignItems: ItemAlign.Center }) {
              Flex({ alignItems: ItemAlign.Center }) {
                Image(this.model.getListLeadingContent())
                  .objectFit(ImageFit.Cover)
                  .size(this.model2.getListLeadingContentImageSize())
                  .borderRadius(this.model2.getLeadingImageBorderRadius())
                  .padding({ left: this.model2.getSpaceOnLeft() })
              }
              .size(this.model2.getListLeadingContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Column() {
                  Text(this.model.getListLabel())
                    .fontStyle(this.model2.getMainDataFontStyle())
                    .fontColor(this.model2.getListMainDataFontColor())
                    .fontSize(this.model2.getListMainDataSize())
                    .fontWeight(this.model2.getListMainDataFontWeight())
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                }
              }.size(this.model2.getListDataContainerSize()).padding({ right: this.model2.getListDataRightSpace() });
              Flex({ alignItems: ItemAlign.Center }) {
                Image(this.model.getListTrailingContent())
                  .objectFit(ImageFit.Cover)
                  .size(this.model2.getListTrailingContentImageSize())
                  .borderRadius(this.model2.getTrailingImageBorderRadius())
                  .padding({ right: this.model2.getSpaceOnRight() });
              }.size(this.model2.getListTrailingContainerSize());
              ripple({
                rippleStartPosition: $clickCoordinates,
                size: $containerSize,
                showRipple: $showRipple,
                animationColor: $rippleColor
              })
            }.size(this.model2.getListContainerSize());
          }
          else if (this.model.getIsLeadingContentImage() == true && this.model.getIsTrailingContentImage() == false) {
            Flex({ alignItems: ItemAlign.Center }) {
              Flex({ alignItems: ItemAlign.Center }) {
                Image(this.model.getListLeadingContent())
                  .objectFit(ImageFit.Cover)
                  .size(this.model2.getListLeadingContentImageSize())
                  .borderRadius(this.model2.getLeadingImageBorderRadius())
                  .padding({ left: this.model2.getSpaceOnLeft() });
              }
              .size(this.model2.getListLeadingContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Column() {
                  Text(this.model.getListLabel())
                    .fontStyle(this.model2.getMainDataFontStyle())
                    .fontSize(this.model2.getListMainDataSize())
                    .fontWeight(this.model2.getListMainDataFontWeight())
                    .fontColor(this.model2.getListMainDataFontColor())
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                }.padding({ right: this.model2.getListDataRightSpace() })
              }.size(this.model2.getListDataContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Text(this.model.getListTrailingContent())
                  .fontSize(this.model2.getListTrailingContentTextSize())
                  .padding({ right: this.model2.getSpaceOnRight() });
              }.size(this.model2.getListTrailingContainerSize());
              ripple({
                rippleStartPosition: $clickCoordinates,
                size: $containerSize,
                showRipple: $showRipple,
                animationColor: $rippleColor
              })
            }.size(this.model2.getListContainerSize());
          }
          else if (this.model.getIsLeadingContentImage() === false && this.model.getIsTrailingContentImage() === true) {
            Flex({ alignItems: ItemAlign.Center }) {
              Flex({ alignItems: ItemAlign.Center }) {
                Text(this.model.getListLeadingContent())
                  .fontSize(this.model2.getListLeadingContentTextSize())
                  .padding({ left: this.model2.getSpaceOnLeft() });
              }
              .size(this.model2.getListLeadingContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Column() {
                  Text(this.model.getListLabel())
                    .fontStyle(this.model2.getMainDataFontStyle())
                    .fontSize(this.model2.getListMainDataSize())
                    .fontWeight(this.model2.getListMainDataFontWeight())
                    .fontColor(this.model2.getListMainDataFontColor())
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                }.padding({ right: this.model2.getListDataRightSpace() })
              }.size(this.model2.getListDataContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Image(this.model.getListTrailingContent())
                  .objectFit(ImageFit.Cover)
                  .size(this.model2.getListTrailingContentImageSize())
                  .borderRadius(this.model2.getTrailingImageBorderRadius())
                  .padding({ right: this.model2.getSpaceOnRight() });
              }.size(this.model2.getListTrailingContainerSize());
              ripple({
                rippleStartPosition: $clickCoordinates,
                size: $containerSize,
                showRipple: $showRipple,
                animationColor: $rippleColor
              })
            }.size(this.model2.getListContainerSize());
          }
          else if (this.model.getIsLeadingContentImage() == false && this.model.getIsTrailingContentImage() == false) {
            Flex({ alignItems: ItemAlign.Center }) {
              Flex({ alignItems: ItemAlign.Center }) {
                Text(this.model.getListLeadingContent())
                  .fontSize(this.model2.getListLeadingContentTextSize())
                  .padding({ left: this.model2.getSpaceOnLeft() });
              }
              .size(this.model2.getListLeadingContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Column() {
                  Text(this.model.getListLabel())
                    .fontStyle(this.model2.getMainDataFontStyle())
                    .fontSize(this.model2.getListMainDataSize())
                    .fontWeight(this.model2.getListMainDataFontWeight())
                    .fontColor(this.model2.getListMainDataFontColor())
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                }.padding({ right: this.model2.getListDataRightSpace() })
              }.size(this.model2.getListDataContainerSize());
              Flex({ alignItems: ItemAlign.Center }) {
                Text(this.model.getListTrailingContent())
                  .fontSize(this.model2.getListTrailingContentTextSize())
                  .padding({ right: this.model2.getSpaceOnRight() });
              }.size(this.model2.getListTrailingContainerSize());
              ripple({
                rippleStartPosition: $clickCoordinates,
                size: $containerSize,
                showRipple: $showRipple,
                animationColor: $rippleColor
              })
            }.size(this.model2.getListContainerSize());
          }
        }
      }.backgroundColor(this.model2.getBackGroundColor())
      .onClick((event) => {
        this.clickCoordinates = {
          x: event.x,
          y: event.y
        }
        this.showRipple = this.model2.getRippleAnimation()
        this.containerSize = this.model2.getListContainerSize()
        this.rippleColor = this.model2.getRippleColor()
        setTimeout(() => {
          this.onClick(event)
        }, 300)
        var listItemFunction = this.model.getListFunction()
        if (listItemFunction != null)
           listItemFunction()
      }
      )
    }
  }
}

export { SingleLineListModel } from './listModels/listmodels';
export { SingleLineListItems } from './listUtilities/listClasses';