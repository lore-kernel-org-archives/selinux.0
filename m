From: Paul Moore <paul.moore@hp.com>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
Date: Mon, 21 Jul 2008 08:24:39 -0400
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi> <200807202125.36525.paul.moore@hp.com> <Pine.LNX.4.64L.0807211104300.15292@ruuvi.it.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64L.0807211104300.15292@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807210824.40003.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 21 July 2008 4:08:04 am Vesa-Matti J Kari wrote:
> Hello,
>
> On Sun, 20 Jul 2008, Paul Moore wrote:
> > Normally I like janitorial fixes such as whitespace cleanups,
> > spelling corrections, etc.  However, these three patches seem a bit
> > silly to me simply changing a variable name from "idx" to "i" and
> > not adding any real value to the code.  If it were up to me alone,
> > I would say "NO", but if everyone else agrees they are worthwhile I
> > won't to stand in the way.
>
> I understand, but my preference is that all code should always look
> as similar as possible style-wise. To my eyes, it is quite annoying
> to see, e.g. "iter" and "idx" used mixed in the same source file, and
> it distracts my code reading.

The kernel is a very large piece of code, which is developed and 
maintained by literally thousands of people.  While there are rules and 
guidelines to help maintain consistency there will _always_ be 
inconsistent style in the Linux Kernel.  Further, due to the extremely 
high rate of change in the kernel it is doubtful that you will be able 
to stylistically "fix" the entire kernel and maintain it (patch 
acceptance is another issue entirely).

I know it can be frustrating at times, but I would suggest that adapting 
yourself to read the Linux Kernel sources will be much more rewarding 
(both to yourself and to the community) than trying to adapt the kernel 
sources to you.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
