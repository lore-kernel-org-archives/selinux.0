Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p87Ldc9f031605
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2011 17:39:38 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p87Ldb4b019576
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2011 21:39:37 GMT
Received: by gyd10 with SMTP id 10so129750gyd.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2011 14:39:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <SNT139-W3530952732EBAC19C3E5CAB170@phx.gbl>
References: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
	<SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>
	<CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
	<201108292128.51104.russell@coker.com.au>
	<SNT139-W3530952732EBAC19C3E5CAB170@phx.gbl>
Date: Wed, 7 Sep 2011 17:39:37 -0400
Message-ID: <CACLa4ptyOnMgx8-8RTkzeLTjgsG4iKL3Lb1wBqz6a-N2HFPZ9Q@mail.gmail.com>
Subject: Re: Toolchain is broken?
From: Eric Paris <eparis@parisplace.org>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell, thoughts?

2011/8/30 HarryCiao <harrytaurus2002@hotmail.com>:
> Hi Russell,
>
> Please explicitly set fallback_user_level = NULL; or have
> "s->fallback_user_level = fallback_user_level;" controlled by if(level) too.
>
> Unfortunately, this patch won't fix the segfault issue for standard
> refpolicy(BTW, the MLS refpolicy could be compiled/linked/expanded
> uneventfully) and I got below backtrace information from gdb:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007fb03c2fd052 in ?? () from /lib/libc.so.6
> (gdb) bt
> #0  0x00007fb03c2fd052 in ?? () from /lib/libc.so.6
> #1  0x00007fb03bc4e691 in ustr_replace_cstr () from
> /usr/lib/libustr-1.0.so.1
> #2  0x00007fb03c615846 in replace_all (
>     str=0xac3ab10 "HOME_DIR/.+\tsystem_u:object_r:user_home_t",
>     repl=0x7fff5d711cd0) at genhomedircon.c:442
> #3  0x00007fb03c615ad8 in write_home_dir_context (s=0x7fff5d711df0,
>     out=0x10301f50, tpl=0xe2dc170, user=0xe25cec0 "user_u",
>     seuser=0xe25cec0 "user_u", home=0xe2913d3 "/home/[^/]*",
>     role_prefix=0xe261d30 "user", level=0x0) at genhomedircon.c:509
> #4  0x00007fb03c616b50 in write_context_file (s=0x7fff5d711df0,
> out=0x10301f50)
>     at genhomedircon.c:942
> #5  0x00007fb03c616df0 in semanage_genhomedircon (sh=0x228b790,
>     policydb=0xaab4370, usepasswd=1) at genhomedircon.c:1017
> #6  0x00007fb03c611baa in semanage_direct_commit (sh=0x228b790)
>     at direct_api.c:1008
> #7  0x00007fb03c617c44 in semanage_commit (sh=0x228b790) at handle.c:435
> #8  0x0000000000402471 in main ()
> (gdb)
>
> I didn't go further than that.
>
> Thanks,
> Harry
>
>
>> From: russell@coker.com.au
>> To: eparis@parisplace.org
>> Subject: Re: Toolchain is broken?
>> Date: Mon, 29 Aug 2011 21:28:50 +1000
>> CC: harrytaurus2002@hotmail.com; selinux@tycho.nsa.gov
>>
>> On Sat, 27 Aug 2011, Eric Paris <eparis@parisplace.org> wrote:
>> > Must have come from this patch.
>> >
>> > commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a
>> > Author: Russell Coker <russell@coker.com.au>
>> > Date: Wed Jan 5 19:30:25 2011 +1100
>> >
>> > libsemanage: patch for MCS/MLS in user files
>> >
>>
>> What do you think of the attached patch?
>>
>> --
>> My Main Blog http://etbe.coker.com.au/
>> My Documents Blog http://doc.coker.com.au/
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
