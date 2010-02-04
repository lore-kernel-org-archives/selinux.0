Subject: Re: MLS and network
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100204174901.GL1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Thu, 04 Feb 2010 13:09:40 -0500
Message-Id: <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-02-04 at 18:49 +0100, Michal Svoboda wrote:
> Hello,
> 
> I've struck an interesting issue on stock fedora12. When you install the
> MLS policy and then newrole yourself to s1 (or anything higher than s0),
> you can still connect to the 'net (for example, ftp somewhere). I've
> checked that the kernel is in enforcing mode.
> 
> This clearly violates the intent of MLS, as you could easily leak
> confidential files this way. The question is which part is buggy? I've
> looked briefly into the sources of the reference policy and it seems
> that the necessary infrastructure is there: ports are labeled as s0, mls
> constraints are in place and the domains of user processes do not have
> mls exempts. That leaves things in a couple of options:
> 
> 1) there is a bug in selinux or this feature is unsupported
> 2) fedora applies some patches to the policy which defeat the proper
>    functioning
> 3) i have missed something
> 
> Any ideas?

If you want network enforcement, you need to configure labeled
networking - that isn't enabled by default.

http://marc.info/?t=126299792600001&r=1&w=2
http://marc.info/?t=126347828800001&r=1&w=2
http://paulmoore.livejournal.com/5536.html
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
