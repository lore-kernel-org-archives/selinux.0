Message-ID: <1346070096.2317.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: sepol help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua
	Brindle <jbrindle@tresys.com>
Date: Mon, 27 Aug 2012 08:21:36 -0400
In-Reply-To: <CAFftDdrBnacqwOXpDZ4bz5PrWnTQKvt-GaNq3SBAWtJWApX07A@mail.gmail.com>
References: 
	<CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	 <5036E824.7030007@manicmethod.com>
	 <CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
	 <CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
	 <1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdqOf3frr7bK9vZ3j7uCPdfhdwxbaH6A3UBw=UV8+nEB7Q@mail.gmail.com>
	 <CAFftDdrJpFsQRwxpg8U=KC0aG16BWcKmR+vmcnEWC78BKqx-vg@mail.gmail.com>
	 <CAFftDdrBnacqwOXpDZ4bz5PrWnTQKvt-GaNq3SBAWtJWApX07A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-24 at 19:35 -0700, William Roberts wrote:
> I tried getting mls prefix by doing:
> 
> sepol_context_create(pol.handle,&pol.con);
> char *mls = sepol_context_get_mls(pol.con);
> 
> but mls is NULL. Not really sure if I am creating the handle and
> context properly.

sepol_context_create() just creates an empty context record that you
then have to fill.  If you want to create it from an existing string
security context, then use sepol_context_from_string() to initialize it
and then you can use sepol_context_get_* to extract individual fields.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
