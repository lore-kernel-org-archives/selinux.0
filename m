MIME-Version: 1.0
In-Reply-To: <CAFftDdrJpFsQRwxpg8U=KC0aG16BWcKmR+vmcnEWC78BKqx-vg@mail.gmail.com>
References: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	<5036E824.7030007@manicmethod.com>
	<CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
	<CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
	<1345810236.18849.16.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdqOf3frr7bK9vZ3j7uCPdfhdwxbaH6A3UBw=UV8+nEB7Q@mail.gmail.com>
	<CAFftDdrJpFsQRwxpg8U=KC0aG16BWcKmR+vmcnEWC78BKqx-vg@mail.gmail.com>
Date: Fri, 24 Aug 2012 19:35:04 -0700
Message-ID: <CAFftDdrBnacqwOXpDZ4bz5PrWnTQKvt-GaNq3SBAWtJWApX07A@mail.gmail.com>
Subject: Re: sepol help
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tried getting mls prefix by doing:

sepol_context_create(pol.handle,&pol.con);
char *mls = sepol_context_get_mls(pol.con);

but mls is NULL. Not really sure if I am creating the handle and
context properly.

Bill

On Fri, Aug 24, 2012 at 4:56 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
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
>
> Also on the level, currently we reformat the level on setcontext in android.c
> snprintf(level, sizeof level, "%s:c%lu",
>                                  context_range_get(ctx), id);
>
> in the sepolicy lib their is sepol_mls_check that I am using, but I
> need to convert the mls to a similar format and don't know what the
> corresponding sepol call is for context_rage_get...
>
> I looked in context.h and didn't see anything giving me back some data
> I could use to recreate this, can someone (again) point me in the
> right direction?
>
> Thanks,
> Bill
>
> On Fri, Aug 24, 2012 at 2:22 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> I'm with you there, ill look into these new interfaces.
>>
>> On Fri, Aug 24, 2012 at 5:10 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On Thu, 2012-08-23 at 21:41 -0700, William Roberts wrote:
>>>> You got me with the cannot link as shared object....I was looking at
>>>> the text section going why wont it link, and then I tried static and
>>>> it worked. I should have paid more attention to that detail in your
>>>> email. So for all those make sure you link sepol statically.
>>>> Otherwise, thanks again.
>>>
>>> I'd prefer it if you could use the shared library instead, using its
>>> interfaces.  Otherwise we have to rebuild your tool anytime the library
>>> changes.
>>>
>>> --
>>> Stephen Smalley
>>> National Security Agency
>>>
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>
>
>
> --
> Respectfully,
>
> William C Roberts



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
