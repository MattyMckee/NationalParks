import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    var addedItem: IndexPath?
    var deletesItems: [IndexPath]?
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result = [UICollectionViewLayoutAttributes]()
        if let attributes = super.layoutAttributesForElements(in: rect){
            for item in attributes {
                let cellAttributes = item.copy() as! UICollectionViewLayoutAttributes
                if item.representedElementKind == nil {
                    let frame = cellAttributes.frame
                    cellAttributes.frame = frame.insetBy(dx: 2.0, dy: 2.0)
                }
                result.append(cellAttributes)
            }
        }
        return result
    }
    
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath),
            let added = addedItem,
            added == itemIndexPath else {
                return nil
        }
        //set new attributes
        attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath),
        let deleted = deletesItems,
        deleted.contains(itemIndexPath) else{
            return nil
        }
        //set attributes 
        attributes.alpha = 1
        attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        attributes.zIndex = -1
        
        return attributes
    }
}
