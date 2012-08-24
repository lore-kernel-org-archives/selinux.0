Message-ID: <1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: sepol help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua
	Brindle <jbrindle@tresys.com>
Date: Fri, 24 Aug 2012 08:10:36 -0400
In-Reply-To: <CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
References: 
	<CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	 <5036E824.7030007@manicmethod.com>
	 <CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
	 <CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 21:41 -0700, William Roberts wrote:
> You got me with the cannot link as shared object....I was looking at
> the text section going why wont it link, and then I tried static and
> it worked. I should have paid more attention to that detail in your
> email. So for all those make sure you link sepol statically.
> Otherwise, thanks again.

I'd prefer it if you could use the shared library instead, using its
interfaces.  Otherwise we have to rebuild your tool anytime the library
changes. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
