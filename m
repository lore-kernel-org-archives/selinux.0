Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i818pxrT019316
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 04:51:59 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i818pAY2015379
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 08:51:10 GMT
Date: Wed, 1 Sep 2004 10:03:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: automount policy
Message-ID: <20040901090307.GB5882@lkcl.net>
References: <200409011238.15293.russell@coker.com.au> <4135433D.1090506@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4135433D.1090506@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 11:34:21PM -0400, Joshua Brindle wrote:
> Russell Coker wrote:
> 
> >The attached patch is needed for the latest rawhide automount.
> >
> > 
> >
> >------------------------------------------------------------------------
> >
> >--- /usr/src/se/policy/domains/program/unused/automount.te	2004-08-28 
> >12:05:01.000000000 +1000
> >+++ domains/program/unused/automount.te	2004-09-01 
> >12:36:44.000000000 +1000
> >@@ -66,4 +66,4 @@
> >allow automount_t home_root_t:dir { getattr };
> >allow automount_t mnt_t:dir { getattr search };
> >
> >-allow initrc_t automount_etc_t:file getattr;
> >+allow initrc_t automount_etc_t:file { getattr read };
> > 
> >
> Why add this allow for everyone if it's just for rawhide?
 
 hey, i recognise that patch.  sort-of.

 it's not just rawhide.

 i recently added automount to my debian system, and decided
 it would be best (for me) to add a type autmount_etc_t for
 /etc/auto.[usb,misc,net].

 it looks like rawhide's picked it up.

 i only sent the patch adding automount_etc_t on last week!

 btw i seem to have missed /etc/auto.master from my patch
 [making it automount_etc_t], which might, if added, mean that
 allow automount_t etc_t:file { getattr read } can be _removed_.
 worth a try.

 
 also btw guys i thoroughly recommend the approach of doing
 modifications to usb-mount which put stuff into /etc/auto.usb
 instead of having this utterly ridiculous requirement of
 "warning warning please run unmount before removing the usb
  disk you might lose data otherwise" _no_ sane non-technical
  user is ever going to bother with "unmount" it makes them
  think of wild beasts which is going to put them off.

 modified usb-mount at http://hands.com/~lkcl/usb-mount in
 case you're interested [it's a bit hacked up so i could
 use some help with the use of sed and awk]

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
