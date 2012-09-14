Message-ID: <1347641987.11029.65.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: policycoreutils build failure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pat McClory <pmcclory@tresys.com>
Cc: eparis@redhat.com, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 14 Sep 2012 12:59:47 -0400
In-Reply-To: <50535A56.2010209@tresys.com>
References: <50535A56.2010209@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 12:24 -0400, Pat McClory wrote:
> Hi Eric,
> 
> I tried to build your latest upstream push, and I'm having trouble 
> building policycoreutils:
> 
> make[1]: Entering directory `/home/pmcclory/selinux/policycoreutils/po'
> make[1]: *** No rule to make target `../gui/selinux.tbl', needed by 
> `policycoreutils.pot'.  Stop.
> make[1]: Leaving directory `/home/pmcclory/selinux/policycoreutils/po'
> make: *** [all] Error 1
> 
> it looks like policycoreutils/gui/selinux.tbl is added in commit 
> f237aac4506e398367575319e7c0e7741ff7bce0 in the queue branch, but isn't 
> in master.

Did you clean your tree first?  Try a git clean -fdx and then building.
Works for me.

cd selinux
git clean -fdx
make DESTDIR=~/obj install

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
