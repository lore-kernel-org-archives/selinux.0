Subject: Re: bzip support in libsemanage and out of memory (userspace
 ticket 7)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <201001242029.o0OKTSbY001470@vivaldi39.register.it>
References: <201001242029.o0OKTSbY001470@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 10:32:59 -0500
Message-Id: <1264433579.4297.156.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-01-24 at 21:29 +0100, Guido Trentalancia wrote:
> Hi !
> 
> Has anybody had any time to look at this ticket:
> http://userspace.selinuxproject.org/trac/ticket/7 ?
> 
> I have experienced the same issue and verified that the problem is actually triggered by the bzip support (as pointed out by Stephen Smalley back in August). In fact, if I use bzip-blocksize=0 in semanage.conf then the problem disappears...
> 
> Otherwise with a default semanage.conf and bzip enabled, I get:
> 
> libsepol.module_package_read_offsets: offset greater than file size (at 4, offset 200478 -> 8192 (No such file or directory).
> libsemanage.semanage_load_module: Error while reading from module file /etc/selinux/refpolicy/modules/tmp/base.pp. (No such file or directory).
> semodule:  Failed!
> 
> I am using libsepol-2.0.41 and libsemanage-2.0.42.

I'm not sure how I feel about these tickets on
userspace.selinuxproject.org.  People should still post issues to the
list, even if they file a ticket for tracking purposes.

Regardless, to debug this sort of problem, we need a copy of the
particular policy that triggered it, preferably both the sources and
the .pp file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
