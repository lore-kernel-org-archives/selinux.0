Date: Sun, 2 Dec 2001 14:14:35 +1100 (EST)
From: Grant Bayley <gbayley@ausmac.net>
To: <0x@bk.ru>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: have you seen spfx2.c?
In-Reply-To: <E16ALyE-000BX7-00@f6.mail.ru>
Message-ID: <Pine.BSO.4.33.0112021406500.3173-100000@ausmac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


What I don't understand with Linux users is the endless desire to
prevent broken things by patching around them in the kernel.

Why not concentrate on cleaning up the userland apps in Linux in such a
way that they're not overflowable in the first place?

No broken [suid | sgid | priviliged uid daemon ] userland apps means you
have a substantially better chance of keeping a system secure without all
the sleight of hand that lkms typically pull to prevent something bad from
happening.

Think about this logic for a second, then check out:

	http://www.openwall.com/Owl/

Grant

On Sun, 2 Dec 2001 0x@bk.ru wrote:

>
> have you seen the security module
> http://packetstorm.decepticons.org/linux/security/spfx2.c ?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
