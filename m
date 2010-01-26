MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: bzip support in libsemanage and out of memory (userspace ticket 7)
Date: Tue, 26 Jan 2010 09:49:58 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0199E843@exchange2.columbia.tresys.com>
In-Reply-To: <1264448660.4297.240.camel@moss-pluto.epoch.ncsc.mil>
References: <201001251930.o0PJUuK8029078@vivaldi39.register.it> <1264448660.4297.240.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Guido Trentalancia" <guido@trentalancia.com>
Cc: <selinux@tycho.nsa.gov>, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        <srivasta@golden-gryphon.com>, "Chad Sellers" <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2010-01-25 Stephen Smalley wrote:
> On Mon, 2010-01-25 at 20:30 +0100, Guido Trentalancia wrote:
>> Stephen,
>> 
>> I have tested the patch that you created for libsemanage and it now
> works fine even without disabling bzip with bzip-blocksize=0 in
> semanage.conf (as it should normally be).
>> 
>> Excellent !
>> 
>> Perhaps, the patch should be committed. I think this is the best
> solution, as it is independent on whether fmemopen_seek() in glibc has
> been fixed or not.
> 
> That seems reasonable to me, particularly given that we already have
> support in libsepol for operating on memory regions and the patch is
> pretty trivial.  Anyone see a reason to retain use of fmemopen()?
>

I don't see a reason to retain it, especially if it is buggy.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
