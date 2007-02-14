Subject: Re: SELinux and LFS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171474739.27788.17.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 18:08:22 +0000
Message-Id: <1171476502.20576.35.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 18:38 +0100, Vincenzo Ciaglia wrote:
> Hi, after some weeks i decided to come back at work on SELinux. 
> I'm still writing you about SELinux support problem on an LFS-based
> distribution.

I think your problem is here:

> 4) I still haven't patched packages like coreutils and sons.

You need a patched init to load the policy.  If no policy is loaded,
SELinux is disabled:

> # sestatus 
> SELinux status:                 disabled

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
