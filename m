Subject: Re: [PATCH v2] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1246480778.2771.0.camel@Ares>
References: <1246480778.2771.0.camel@Ares>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:27:07 -0400
Message-Id: <1246537627.13464.258.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 16:39 -0400, Thomas Liu wrote:
> Here is an updated version of the fts setfiles patch.
> 
<snip>
> We're looking into skipping folders that are mounted under file systems
> that do not have the seclabel flag for the next patch.

You'll have to make that logic kernel version dependent, as that flag
was only introduced in Linux 2.6.30, ala:

#include <sys/utsname.h>

struct utsname uts;

if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") >= 0)
	use_seclabel = 1;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
