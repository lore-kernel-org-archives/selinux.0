Subject: Re: [PATCH] makefile prefix fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129744255.15338.11.camel@twoface.columbia.tresys.com>
References: <1129744255.15338.11.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:00:04 -0400
Message-Id: <1129744804.2375.262.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:50 -0400, Joshua Brindle wrote:
> This patch fixes prefix in recently changed Makefiles so that make
> DESTDIR=somedir will work.

I noticed this issue as well, but I'm not sure about the right fix.
Adding -lsepol after every occurrence of -lselinux in the utility
Makefiles seems wrong when the actual dependency on libsepol only exists
for load_policy.o in libselinux and none of those utilities require the
functions in that object.  Do we need to do something different in the
libselinux build to isolate the dependency

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
