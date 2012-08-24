MIME-Version: 1.0
In-Reply-To: <1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	<5036E824.7030007@manicmethod.com>
	<CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
	<CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
	<1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 24 Aug 2012 14:22:47 -0700
Message-ID: <CAFftDdqOf3frr7bK9vZ3j7uCPdfhdwxbaH6A3UBw=UV8+nEB7Q@mail.gmail.com>
Subject: Re: sepol help
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm with you there, ill look into these new interfaces.

On Fri, Aug 24, 2012 at 5:10 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2012-08-23 at 21:41 -0700, William Roberts wrote:
>> You got me with the cannot link as shared object....I was looking at
>> the text section going why wont it link, and then I tried static and
>> it worked. I should have paid more attention to that detail in your
>> email. So for all those make sure you link sepol statically.
>> Otherwise, thanks again.
>
> I'd prefer it if you could use the shared library instead, using its
> interfaces.  Otherwise we have to rebuild your tool anytime the library
> changes.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
