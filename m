Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LJgdqV020620
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 15:42:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LJgctV003720
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 19:42:38 GMT
Subject: Re: [patch] Tuning avtab to reduce memory usage
From: "J. Tang" <jtang@tresys.com>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 15:43:20 -0400
Message-Id: <1187725400.15264.73.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 13:29 +0900, Yuichi Nakamura wrote:
> I compared 3 hash functions, default, jhash, hash_long.
> default is default AVTAB_HASH.
> jhash is function defined in linux/jhash.h.
> hash_long is defined in linux/hash.h, I used it like following.
> 	(int)(hash_long(((unsigned long)keyp->target_class)+
>     (((unsigned long)keyp->target_type)<<2)+
>     (((unsigned long)keyp->source_type)<<9)  , bits))

A number of months ago, the SETools team also recognized the limitations
of the current avtab hash function.  Beginning with SETools 3.3 release,
we use a different hashing routine that is better suited for refpolicy
analysis.  The following analysis may be of interest to those adjusting
the kernel avtab.

0. Background

The existing AV table in the kernel uses a 15-bit hash key, constructed
as:[0]

  #define AVTAB_HASH(keyp) \
  ((keyp->target_class + \
   (keyp->target_type << 2) + \
   (keyp->source_type << 9)) & \
   AVTAB_HASH_MASK)

We identified these problems with this hashing function:

  a. The majority of rules in refpolicy involve the object classes
process (value 2), file (6), and dir (7).  Thus at least three bits are
needed to best express the target class.

  b. Refpolicy has roughly 2000 distinct types and attributes.  Only 7
bits are preserved for source_type.

To our surprise, we discovered that for a particular policy with several
hundred thousand rules, some buckets were empty, while others were
nearly 200.[1]  We measured the effectiveness of the hash table by way
of calculating the standard deviation in bucket lengths; it was 65.8227.

1. Change in avtab size

Our first optimization was to increase the hash table size to 16 bits.
As expected, this roughly halved the access time and bucket lengths.
With this change, we discovered that some buckets were still unused; the
longest chain, however, was still excessively long at 101.  The standard
deviation halved to 33.0038.

2. Alternative Hashing Function

In combination with the increase in hash table size, we devised this
hashing function:[2]

  #define AVTAB_HASH(keyp) \
  ((((keyp->source_type & 0xff) << 8) | (keyp->target_type & 0xff)) ^ \
   (keyp->target_class & 0xf) ^ \
   AVTAB_HASH_MASK)

This routine keeps the lower eight bits of the source and target types,
as well as the lower four bits of the target class.  The algorithm
itself is very fast due to bitwise logic.[3]

2. Evaluation

With this new hashing function, our calculated standard deviation
dropped significantly, to 10.6086.  With the aforementioned policy, the
shortest chain was now 8, the longest slightly more at 112.  This
implies that the algorithm has better distribution than the original
avtab algorithm.  As expected, runtime was cut considerably, without
further increasing the memory footprint of the avtab.

3. Applicability to Current Discussion

The SETools hashing algorithm is designed for a 16-bit hash.  It could
be applied to other bucket sizes by modding it against an appopriate
prime number.

When choosing the hashing algorithm for the avtab, we recommend that the
types of data be also considered.  If it is known that policies will
have thousands of types, the hashing function should reflect that
information.  Likewise, if most rules are clustered around a few object
classes, those class values need to become better discriminators.[4]
The hashing algorithm changes are independent of changes to the bitmap
and can be implemented regardless of other patches.


[0] From Linux kernel 2.6.22.1 source, security/selinux/ss/avtab.c,
lines 25-29.
[1] The precise policy used can be provided, if requiested.
[2] We actually hash conditional rules into the same avtab as
unconditional rules; for brevity conditionals are not shown.
[3] On the x86 architecture, bitwise operations take a single cycle to
complete.
[4] Another improvement would be to have an avalanche effect in the
algorithm.

-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
