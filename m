Subject: RE: A question about selinux userspace tools
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <COL109-W364E77A3A4C0B0811DD604AB0A0@phx.gbl>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
	 <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
	 <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
	 <COL109-W364E77A3A4C0B0811DD604AB0A0@phx.gbl>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 08:10:16 -0400
Message-Id: <1249560616.5213.25.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-08-06 at 01:33 +0000, TaurusHarry wrote:
> Hey Smalley,
> 
> On my laptop. both RAM and swap are about 4G bytes, and the
> overcomit_memory is 0 while the overcommit_ration is 50.
> 
> Is it possible to tune these vm settings in some way so that
> bzip-blocksize=4 or 9 would succeed in building a policy store?

That's curious, as I've tested on a much smaller memory configuration (a
VM with 512M RAM, 1G swap) without any problems using the same
overcommit settings.

Is your arch i686 or x86_64?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
