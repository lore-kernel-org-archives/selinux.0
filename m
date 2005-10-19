Subject: Re: [PATCH] makefile prefix fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129744255.15338.11.camel@twoface.columbia.tresys.com>
References: <1129744255.15338.11.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:38:07 -0400
Message-Id: <1129750687.2375.298.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:50 -0400, Joshua Brindle wrote:
> This patch fixes prefix in recently changed Makefiles so that make
> DESTDIR=somedir will work.

Merged for now, but I find it troubling that we have to link with
-lsepol for all users of libselinux just because one of its functions is
using sepol.  Something isn't right there, likely a problem in
libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
