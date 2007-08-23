Subject: Re: [patch] libsepol:  eliminate unaligned accesses (Was: Re:
	wrong magic number (using old sources))
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
	 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20070816080523.135750@gmx.net>
	 <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1187715923.1451.164.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 11:08:41 -0400
Message-Id: <1187881721.1451.505.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 13:05 -0400, Stephen Smalley wrote:
> Full patch follows, replaces the prior short term one.
> 
> Rewrite libsepol next_entry function and all callers to copy entry data
> from the binary policy into properly aligned buffers, eliminating
> unaligned accesses, just as I did for the kernel back in 2004,
> http://marc.info/?l=selinux&m=110252376515271&w=2
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

I merged the updated version of this patch to trunk and stable (the
latter since it is a bug fix).

Note that this would ultimately have to get merged to policyrep as well,
although it no doubt conflicts with your patches removing the module
support from libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
