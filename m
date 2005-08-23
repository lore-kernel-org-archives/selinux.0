Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NH4OOb000094
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 13:04:25 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430A33E5.1030100@redhat.com>
References: <430A33E5.1030100@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 12:52:02 -0400
Message-Id: <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
> libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 

When I read through the patch, it looked sane.  But a quick trial of ls
-Z / showed a definite issue with no libsetrans in place.  It generates
garbage as soon as it hits a directory that doesn't support extended
attributes.

This appears to reflect both a problem in the patch and a problem in ls.
As far as the patch goes, when there is no libsetrans, the wrapper
functions (e.g. getfilecon) are always setting *context to rcontext even
if the raw function returned an error.  I think we need to qualify the
else clauses in the wrapper functions with if (ret > 0) as well so that
we do not set *context to garbage when an error is encountered by the
raw function.  I can make that change.

As far as ls goes, it is presently not checking the return value of
getfilecon/lgetfilecon; it just initializes the f->scontext pointers to
NULL a priori and then passes them to getfilecon/lgetfilecon, assuming
that they won't disturb them (or at least will reset them to NULL) upon
any errors.  It then checks for NULL at display time.  That worked prior
to the patch because the original function wouldn't set *context at all
upon errors, but was broken by the patch when there was no libsetrans.
It would be more robust to have ls check the return value and reset
f->scontext to NULL upon any errors.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
