Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A36@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: RE: Patching SRPM utilities produces rejects on RH9
Date: Thu, 11 Sep 2003 15:32:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I don't believe that the SRPMS are already patched and here is why.  Of the
9 hunks in the patch, 8 are successful and 1 fails.  Comparing the original
source file (login.c.orig) to the patched source file (login.c) I can see
that applying the patch has added "#ifdef WITH_SELINUX" blocks to the
original source file.  If the original soruce files (those SRPMS included
with the userland archive) are already patched, where are the "#ifdef
WITH_SELINUX" blocks in the original file? What am I missing here?

**** login.c (patch applied)****

# define PAM_END { \
	pam_setcred(pamh, PAM_DELETE_CRED); \
	retcode = pam_close_session(pamh, 0); \
	pam_end(pamh,retcode);\
}
#endif
#ifdef WITH_SELINUX
	security_context_t user_context=NULL;
	security_context_t ttyn_context=NULL;
	int selinux_enabled=0;
#ifdef CHOWNCVS
	security_context_t vcsn_context=NULL;
	security_context_t vcsan_context=NULL;	
#endif
#endif
#ifndef __linux__
# include <tzfile.h>
#endif
#include <lastlog.h>

**** login.c.orig (patch not applied)****

# define PAM_END { \
	pam_setcred(pamh, PAM_DELETE_CRED); \
	retcode = pam_close_session(pamh, 0); \
	pam_end(pamh,retcode);\
}
#endif
#ifndef __linux__
# include <tzfile.h>
#endif
#include <lastlog.h>

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Thursday, September 11, 2003 2:37 PM
To: Kratzer, James R.
Cc: 'SELinux@tycho.nsa.gov'
Subject: Re: Patching SRPM utilities produces rejects on RH9


On Thu, 2003-09-11 at 14:27, Kratzer, James R. wrote:
> I'm running Red Hat 9 and I am using the SELinux userland archive
> selinux-usr-2003081307.tgz which had been updated for Red Hat 9.
> 
> I am applying the patches to the SRPMs.  Both the patches and the SRPMs
are
> provided with the userland archive downloaded from the SELinux site.  When
> applying the patches, I am getting some rejections, where the patch
utility
> can't find the code to patch.  Most of the hunks succeed but some are
> rejected.  The hunks that fail are failing because the code to patch
cannot
> be found in the source file.  I would like to know if this is normal when
> patching the SRPMs with the SELinux patches.  Could it be that the patches
> were correct for an earlier version of Red Hat but have not been updated
for
> RH9?  After patching, the SRPMs build fine even with the rejections.  

The SRPMS include the patches already.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
