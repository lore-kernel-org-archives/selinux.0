Date: Thu, 24 Jul 2008 23:18:56 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, remove unneeded local variable
In-Reply-To: <Pine.LNX.4.64L.0807210244480.8743@ruuvi.it.helsinki.fi>
Message-ID: <Xine.LNX.4.64.0807242318320.8246@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807210244480.8743@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jul 2008, Vesa-Matti J Kari wrote:

> Hello,
> 
> Remove unneeded local variable:
> 
>     struct avtab_node *newnode
> 
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#devel

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
