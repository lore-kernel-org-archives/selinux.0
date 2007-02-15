Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171476502.20576.35.camel@sgc.columbia.tresys.com>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 18:16:59 +0100
Message-Id: <1171559819.5634.3.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno mer, 14/02/2007 alle 18.08 +0000, Christopher J. PeBenito ha
scritto:

> You need a patched init to load the policy.  If no policy is loaded,
> SELinux is disabled:

In addition here the pre-compiled tar.gz derived from the latest debian
selinux-patched sysvinit.

http://www.netwosix.org/selinux/sysvinit-2.86-5-selinux.tar.gz

But again:

# sestatus 
SELinux status:                 disabled
#

So i'm thinking that the problem isn't init anymore.

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
