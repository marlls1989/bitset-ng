{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}

#include <bitset.h>

-----------------------------------------------------------------------------
-- |
-- Module      :  Data.BitSet.Dynamic
-- Copyright   :  (c) Sergei Lebedev, Aleksey Kladov, Fedor Gogolev 2013
--                Based on Data.BitSet (c) Denis Bueno 2008-2009
-- License     :  MIT
-- Maintainer  :  superbobry@gmail.com
-- Stability   :  experimental
-- Portability :  GHC
--
-- A space-efficient implementation of set data structure for enumerated
-- data types.
--
-- /Note/: Read below the synopsis for important notes on the use of
-- this module.
--
-- This module is intended to be imported @qualified@, to avoid name
-- clashes with "Prelude" functions, e.g.
--
-- > import Data.BitSet.Dynamic (BitSet)
-- > import qualified Data.BitSet.Dynamic as BS
--
-- The implementation uses 'Integer' as underlying container, thus it
-- grows automatically when more elements are inserted into the bit set.

module Data.BitSet.Dynamic
  (
    -- * Bit set type
    BitSet

    -- * Operators
  , (\\)

    -- * Construction
  , empty
  , full
  , singleton
  , insert
  , delete

    -- * Query
  , null
  , complete
  , size
  , member
  , notMember
  , isSubsetOf
  , isProperSubsetOf

  -- * Combine
  , union
  , difference
  , intersection

  -- * Transformations
  , map

  -- * Folds
  , foldl'
  , foldr

  -- * Filter
  , filter

  -- * Lists
  , toList
  , fromList ) where

import Prelude hiding (null, map, filter, foldr)

import qualified Data.BitSet.Generic as GS

type BitSet = GS.BitSet Integer

-- | /O(1)/. Is the bit set empty?
null :: BitSet a -> Bool
null = GS.null
{-# INLINE null #-}

-- | /O(1)/. Is the bit set full?
complete :: (Bounded a, Enum a) => BitSet a -> Bool
complete = GS.complete
{-# INLINE complete #-}

-- | The full bit set.
full :: (Bounded a, Enum a) => BitSet a
full = GS.full
{-# INLINE full #-}

-- | /O(1)/. The number of elements in the bit set.
size :: BitSet a -> Int
size = GS.size
{-# INLINE size #-}

-- | /O(1)/. Ask whether the item is in the bit set.
member :: Enum a => a -> BitSet a -> Bool
member = GS.member
{-# INLINE member #-}

-- | /O(1)/. Ask whether the item is in the bit set.
notMember :: Enum a => a -> BitSet a -> Bool
notMember = GS.notMember
{-# INLINE notMember #-}

-- | /O(max(n, m))/. Is this a subset? (@s1 isSubsetOf s2@) tells whether
-- @s1@ is a subset of @s2@.
isSubsetOf :: BitSet a -> BitSet a -> Bool
isSubsetOf = GS.isSubsetOf
{-# INLINE isSubsetOf #-}

-- | /O(max(n, m)/. Is this a proper subset? (ie. a subset but not equal).
isProperSubsetOf :: BitSet a -> BitSet a -> Bool
isProperSubsetOf = GS.isProperSubsetOf
{-# INLINE isProperSubsetOf #-}

-- | The empty bit set.
empty :: Enum a => BitSet a
empty = GS.empty
{-# INLINE empty #-}

-- | O(1). Create a singleton set.
singleton :: Enum a => a -> BitSet a
singleton = GS.singleton
{-# INLINE singleton #-}

-- | /O(1)/. Insert an item into the bit set.
insert :: Enum a => a -> BitSet a -> BitSet a
insert = GS.insert
{-# INLINE insert #-}

-- | /O(1)/. Delete an item from the bit set.
delete :: Enum a => a -> BitSet a -> BitSet a
delete = GS.delete
{-# INLINE delete #-}

-- | /O(max(m, n))/. The union of two bit sets.
union :: BitSet a -> BitSet a -> BitSet a
union = GS.union
{-# INLINE union #-}

-- | /O(1)/. Difference of two bit sets.
difference :: BitSet a -> BitSet a -> BitSet a
difference = GS.difference
{-# INLINE difference #-}

-- | /O(1)/. See `difference'.
(\\) :: BitSet a -> BitSet a -> BitSet a
(\\) = difference

-- | /O(1)/. The intersection of two bit sets.
intersection :: BitSet a -> BitSet a -> BitSet a
intersection = GS.intersection
{-# INLINE intersection #-}

-- | /O(n)/ Transform this bit set by applying a function to every value.
-- Resulting bit set may be smaller then the original.
map :: (Enum a, Enum b) => (a -> b) -> BitSet a -> BitSet b
map = GS.map
{-# INLINE map #-}

-- | /O(n)/ Reduce this bit set by applying a binary function to all
-- elements, using the given starting value.  Each application of the
-- operator is evaluated before before using the result in the next
-- application.  This function is strict in the starting value.
foldl' :: Enum a => (b -> a -> b) -> b -> BitSet a -> b
foldl' = GS.foldl'
{-# INLINE foldl' #-}

-- | /O(n)/ Reduce this bit set by applying a binary function to all
-- elements, using the given starting value.
foldr :: Enum a => (a -> b -> b) -> b -> BitSet a -> b
foldr = GS.foldr
{-# INLINE foldr #-}

-- | /O(n)/ Filter this bit set by retaining only elements satisfying a
-- predicate.
filter :: Enum a => (a -> Bool) -> BitSet a -> BitSet a
filter = GS.filter
{-# INLINE filter #-}

-- | /O(n)/. Convert the bit set set to a list of elements.
toList :: Enum a => BitSet a -> [a]
toList = GS.toList
{-# INLINE toList #-}

-- | /O(n)/. Make a bit set from a list of elements.
fromList :: Enum a => [a] -> BitSet a
fromList = GS.fromList
{-# INLINE fromList #-}
