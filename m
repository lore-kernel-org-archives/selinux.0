Subject: Re: bzip support in libsemanage and out of memory (userspace
 ticket 7)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, cpebenito@tresys.com,
        srivasta@golden-gryphon.com, Chad Sellers <csellers@tresys.com>
In-Reply-To: <201001251930.o0PJUuK8029078@vivaldi39.register.it>
References: <201001251930.o0PJUuK8029078@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 14:44:20 -0500
Message-Id: <1264448660.4297.240.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-25 at 20:30 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> I have tested the patch that you created for libsemanage and it now works fine even without disabling bzip with bzip-blocksize=0 in semanage.conf (as it should normally be).
> 
> Excellent !
> 
> Perhaps, the patch should be committed. I think this is the best solution, as it is independent on whether fmemopen_seek() in glibc has been fixed or not.

That seems reasonable to me, particularly given that we already have
support in libsepol for operating on memory regions and the patch is
pretty trivial.  Anyone see a reason to retain use of fmemopen()?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
