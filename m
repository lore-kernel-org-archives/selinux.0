Date: Mon, 21 Jul 2008 11:08:04 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Paul Moore <paul.moore@hp.com>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
In-Reply-To: <200807202125.36525.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64L.0807211104300.15292@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
 <200807202125.36525.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Sun, 20 Jul 2008, Paul Moore wrote:

> Normally I like janitorial fixes such as whitespace cleanups, spelling
> corrections, etc.  However, these three patches seem a bit silly to me
> simply changing a variable name from "idx" to "i" and not adding any
> real value to the code.  If it were up to me alone, I would say "NO",
> but if everyone else agrees they are worthwhile I won't to stand in the
> way.

I understand, but my preference is that all code should always look as
similar as possible style-wise. To my eyes, it is quite annoying to see,
e.g. "iter" and "idx" used mixed in the same source file, and it distracts
my code reading.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
