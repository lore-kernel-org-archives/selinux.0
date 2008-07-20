Date: Mon, 21 Jul 2008 01:00:27 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch]: ss/services.c null character style fix
In-Reply-To: <7e0fb38c0807200620m649d5cf8w8d57c9a3092450de@mail.gmail.com>
Message-ID: <Xine.LNX.4.64.0807210058290.15955@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807201434040.31208@ruuvi.it.helsinki.fi>
 <7e0fb38c0807200620m649d5cf8w8d57c9a3092450de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Jul 2008, Eric Paris wrote:

> This patch should be rebased against either the current Linus git tree
> or James's SELinux tree.

I'm currently working in the security-testing tree:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#devel

The new preferred upstream approach is to supply patches against 
linux-next, although the above won't be added to that until after the 
current merge window closes.

Patches against either should be fine.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
