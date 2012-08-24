MIME-Version: 1.0
In-Reply-To: <CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
References: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	<5036E824.7030007@manicmethod.com>
	<CAFftDdrHv2vfmV3dZ7c2sRS2VmowvTUj9t7hDrHp+MtsJrQu_Q@mail.gmail.com>
Date: Thu, 23 Aug 2012 21:41:05 -0700
Message-ID: <CAFftDdqqpiLXOgr4=MeHpwExk7HLuVH6N=_Br0d27ZCWM_uVcw@mail.gmail.com>
Subject: Re: sepol help
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You got me with the cannot link as shared object....I was looking at
the text section going why wont it link, and then I tried static and
it worked. I should have paid more attention to that detail in your
email. So for all those make sure you link sepol statically.
Otherwise, thanks again.

On Thu, Aug 23, 2012 at 7:41 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> Thanks  I will dig, try that!
>
> On Thu, Aug 23, 2012 at 7:34 PM, Joshua Brindle <method@manicmethod.com> wrote:
>> William Roberts wrote:
>>>
>>> I am working on a tool for parsing, and allowing overrides to occur in
>>> seapp_contexts. I also want it to check the output selectors against
>>> the compiled binary. After looking at sepol, it wasn't quite clear to
>>> me how to get going with it. Can anyone give me function calls to do
>>> something like this?
>>>
>>> 1. Load the compiled binary
>>
>>
>> look at checkpolicy/test/dispol.c for examples. requires you to be
>> statically linked against libsepol.
>>
>>         fd = open(argv[1], O_RDONLY);
>>         if (fd < 0) {
>> ...        }
>>         if (fstat(fd, &sb) < 0) {
>> ...        }
>>         map =
>>             mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
>> 0);
>>         if (map == MAP_FAILED) {
>> ...        }
>>         policy_file_init(&pf);
>>         pf.type = PF_USE_MEMORY;
>>         pf.data = map;
>>         pf.len = sb.st_size;
>>         if (policydb_init(&policydb)) {
>> ...        }
>>         ret = policydb_read(&policydb, &pf, 1);
>>
>>
>>
>>> 2. Check to see if a boolean exists
>>
>>
>> bool = hashtab_search(policydb->p_bools.table, "some_boolean");
>> if (bool == null) {
>>         //no such boolean
>> }
>>
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
