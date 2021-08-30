  //  // and it's actual size is reduced with [itemSpacing / gridCount].
  //       final double dividedSpacing = itemSpacing / gridCount;
  //       final double topPadding = context.topPadding + kToolbarHeight;

  //       Widget _sliverGrid(BuildContext ctx, List<AssetEntity> assets) {
  //         return SliverGrid(
  //           delegate: SliverChildBuilderDelegate(
  //             (_, int index) => Builder(
  //               builder: (BuildContext c) {
  //                 if (isAppleOS) {
  //                   if (index < placeholderCount) {
  //                     return const SizedBox.shrink();
  //                   }
  //                   index -= placeholderCount;
  //                 }
  //                 return Directionality(
  //                   textDirection: Directionality.of(context),
  //                   child: assetGridItemBuilder(c, index, assets),
  //                 );
  //               },
  //             ),
  //             childCount: assetsGridItemCount(
  //               context: ctx,
  //               assets: assets,
  //               placeholderCount: placeholderCount,
  //             ),
  //             findChildIndexCallback: (Key? key) {
  //               if (key is ValueKey<String>) {
  //                 return findChildIndexBuilder(
  //                   id: key.value,
  //                   assets: assets,
  //                   placeholderCount: placeholderCount,
  //                 );
  //               }
  //               return null;
  //             },
  //           ),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: gridCount,
  //             mainAxisSpacing: itemSpacing,
  //             crossAxisSpacing: itemSpacing,
  //           ),
  //         );
  //       }

  //       return LayoutBuilder(
  //         builder: (BuildContext c, BoxConstraints constraints) {
  //           final double itemSize = constraints.maxWidth / gridCount;
  //           // Check whether all rows can be placed at the same time.
  //           final bool onlyOneScreen = row * itemSize <=
  //               constraints.maxHeight -
  //                   context.bottomPadding -
  //                   topPadding -
  //                   permissionLimitedBarHeight;
  //           final double height;
  //           if (onlyOneScreen) {
  //             height = constraints.maxHeight;
  //           } else {
  //             // Reduce [permissionLimitedBarHeight] for the final height.
  //             height = constraints.maxHeight - permissionLimitedBarHeight;
  //           }
  //           // Use [ScrollView.anchor] to determine where is the first place of
  //           // the [SliverGrid]. Each row needs [dividedSpacing] to calculate,
  //           // then minus one times of [itemSpacing] because spacing's count in the
  //           // cross axis is always less than the rows.
  //           final double anchor = math.min(
  //             (row * (itemSize + dividedSpacing) + topPadding - itemSpacing) /
  //                 height,
  //             1,
  //           );

  //           return Directionality(
  //             textDirection: effectiveGridDirection(context),
  //             child: ColoredBox(
  //               color: theme.canvasColor,
  //               child: Selector<DefaultAssetPickerProvider, List<AssetEntity>>(
  //                 selector: (_, DefaultAssetPickerProvider provider) =>
  //                     provider.currentAssets,
  //                 builder: (_, List<AssetEntity> assets, __) =>
  //                     CustomScrollView(
  //                   physics: const AlwaysScrollableScrollPhysics(),
  //                   controller: gridScrollController,
  //                   anchor: isAppleOS ? anchor : 0,
  //                   center: isAppleOS ? gridRevertKey : null,
  //                   slivers: <Widget>[
  //                     if (isAppleOS)
  //                       SliverGap.v(context.topPadding + kToolbarHeight),
  //                     _sliverGrid(_, assets),
  //                     // Ignore the gap when the [anchor] is not equal to 1.
  //                     if (isAppleOS && anchor == 1)
  //                       SliverGap.v(
  //                           context.bottomPadding + bottomSectionHeight),
  //                     if (isAppleOS)
  //                       SliverToBoxAdapter(
  //                         key: gridRevertKey,
  //                         child: const SizedBox.shrink(),
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //             ),
         








