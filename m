Message-ID: <1346070437.2317.4.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: sepol help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua
	Brindle <jbrindle@tresys.com>
Date: Mon, 27 Aug 2012 08:27:17 -0400
In-Reply-To: <CAFftDdrJpFsQRwxpg8U=KC0aG16BWcKmR+vmcnEWC78BKqx-vg@mail.gmail.com>
References: 
	<CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	 <5036E824.7030007@manicmethod.com>
	 <CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
	 <CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
	 <1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdqOf3frr7bK9vZ3j7uCPdfhdwxbaH6A3UBw=UV8+nEB7Q@mail.gmail.com>
	 <CAFftDdrJpFsQRwxpg8U=KC0aG16BWcKmR+vmcnEWC78BKqx-vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-24 at 16:56 -0700, William Roberts wrote:
> Ok so I have the boolean stuff in place using the sepol_ family of
> functions. You can check out this work of the "dev" branch of this
> repo....
> 
> https://bitbucket.org/billcroberts/check_seapp
> 
> After using that interface, checking the seboolean's was pretty
> straightforward, Ill have to look into those other projects for
> examples on how to check on the other output selectors:
> 
> domain
> type
> level
> 
> Are domain and type just going to be checked using the same function
> that searches types, does anyone know offhand what this function is
> before I start searching the examples Stephen provided me with?

I'm not sure the shared lib exposes an interface for that functionality
presently.  It would be a single function for domains and types (as both
are "types" to SELinux), likely modeled after sepol_bool_exists().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
