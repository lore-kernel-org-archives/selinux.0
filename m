Subject: Re: Patching SRPM utilities produces rejects on RH9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A35@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A35@s3cin>
Content-Type: text/plain
Message-Id: <1063305403.16884.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Sep 2003 14:36:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-09-11 at 14:27, Kratzer, James R. wrote:
> I'm running Red Hat 9 and I am using the SELinux userland archive
> selinux-usr-2003081307.tgz which had been updated for Red Hat 9.
> 
> I am applying the patches to the SRPMs.  Both the patches and the SRPMs are
> provided with the userland archive downloaded from the SELinux site.  When
> applying the patches, I am getting some rejections, where the patch utility
> can't find the code to patch.  Most of the hunks succeed but some are
> rejected.  The hunks that fail are failing because the code to patch cannot
> be found in the source file.  I would like to know if this is normal when
> patching the SRPMs with the SELinux patches.  Could it be that the patches
> were correct for an earlier version of Red Hat but have not been updated for
> RH9?  After patching, the SRPMs build fine even with the rejections.  

The SRPMS include the patches already.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
