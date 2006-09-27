Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8RM3po7000603
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 18:03:51 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8RM3InG018591
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 22:03:18 GMT
Date: Wed, 27 Sep 2006 17:03:46 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Russell Coker <russell@coker.com.au>
Cc: Salvo Giuffrida <giuffsalvo@hotmail.it>, selinux@tycho.nsa.gov
Subject: Re: MLS and Biba
Message-ID: <20060927220346.GA10204@w-m-p.com>
References: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl> <200609270924.31088.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200609270924.31088.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 27, 2006 at 09:24:28AM +1000, Russell Coker wrote:
> SE Linux only supports one MLS range per object, so having Biba and 
> Bell-laPadula is not really possible.  I guess you could misuse the high and 
> low fields of the range such that one of them represents integrity and the 
> other confidentiality, but that is too horrible to seriously contemplate.

A more flexible approach would be to split up the category bits into MLS,
MCS, and MIC (integrity) sets, so that you could use all the models
within a single policy. It's not very pretty but I think not as bad
as having completely separate policies.

It would work by masking the MLS fields using bitmasks. Probably the
most useful approach is to do this for category bits only, and leave the
hierarchical levels for MLS. You could also split up the bits in the
hierarchical level if you really wanted to, for example bit 7..4 for MLS
and bit 3..0 for MIC.

Something like the following maybe (this doesn't currently work of
course):

        define_mls_mask mcs_mask c0..c511;
        define_mls_mask mic_mask c512..c1023;
        define_mls_mask mls_mask s0-s15:c1024..c2048;

        mlsconstrain file write
           (((l1 & mls_mask) eq    (l2 & mls_mask)) and
            ((l1 & mcs_mask) dom   (l2 & mcs_mask)) and
            ((l1 & mic_mask) dom   (l2 & mic_mask)));

        mlsconstrain file read
           (((l1 & mls_mask) dom   (l2 & mls_mask)) and
            ((l1 & mcs_mask) dom   (l2 & mcs_mask)) and
            ((l1 & mic_mask) domby (l2 & mic_mask)));

or alternatively (this would be a lot more readable once you add the
overrides):

        mlsconstrain-masked mls_mask file read
           (l1 dom l2);

        mlsconstrain-masked mic_mask file read
           (l1 domby l2);

To implement it, you'd mainly need to introduce a "binary and" operator
for the mlsconstrain operator. If I understand the AVC cache correctly,
this should have no noticeable performance impact since the operations 
don't happen all that often.

(The current MLS policy uses "write equal" instead of "no write down" to
preserve integrity - if you want to depend on MIC for integrity you could
change the write "eq" to "domby".)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
