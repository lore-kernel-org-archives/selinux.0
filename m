From: Paul Moore <paul.moore@hp.com>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
Date: Sun, 20 Jul 2008 21:25:36 -0400
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807202125.36525.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 20 July 2008 5:46:52 pm Vesa-Matti J Kari wrote:
> Hello,
>
> Renamed iterators "idx" and "iter" to "i", to be in harmony
> with the old unwritten C convention, and with the rest of the code.
>
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

Normally I like janitorial fixes such as whitespace cleanups, spelling 
corrections, etc.  However, these three patches seem a bit silly to me 
simply changing a variable name from "idx" to "i" and not adding any 
real value to the code.  If it were up to me alone, I would say "NO", 
but if everyone else agrees they are worthwhile I won't to stand in the 
way.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
