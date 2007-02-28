Subject: Re: refpolicy modules
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1172671222.11157.52.camel@sgc>
References: <1172654815.7570.7.camel@localhost>
	 <1172667937.19041.458.camel@moss-spartans.epoch.ncsc.mil>
	 <1172669862.5757.10.camel@localhost>  <1172671222.11157.52.camel@sgc>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 15:05:10 +0100
Message-Id: <1172671510.7238.3.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On mer, 2007-02-28 at 09:00 -0500, Christopher J. PeBenito wrote:

> It looks like you deleted the avahi module source files rather than just
> turning it off in modules.conf.  The source files are still required to
> compile the modules that depend on avahi (optionally or otherwise).

Oh, now i understand. 

Thank you, i'm going to try. 

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
