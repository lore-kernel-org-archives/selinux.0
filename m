Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CB1em3030337
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 07:01:40 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CB3YGn000818
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 11:03:35 GMT
Received: by bwz6 with SMTP id 6so2492083bwz.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 04:01:38 -0700 (PDT)
Date: Mon, 12 Jul 2010 14:01:30 +0300
From: =?UTF-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
To: Russell Coker <russell@coker.com.au>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
Message-ID: <20100712140130.468b7b42@debian>
In-Reply-To: <201007121922.48247.russell@coker.com.au>
References: <201007121922.48247.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2010 19:22:47 +1000
Russell Coker <russell@coker.com.au> wrote:

> cli_bytecode_init_jit() in libclamav/c++/bytecode2llvm.cpp in the
> clamav source tree has the following:
> 
>     sys::MemoryBlock B = sys::Memory::AllocateRWX(4096, NULL,
> &ErrMsg); if (B.base() == 0) {
>         errs() << MODULE << ErrMsg << "\n";
> #ifdef __linux__
>         errs() << MODULE << "SELinux is preventing 'execmem' access.
> Run 'setsebool -P clamd_use_jit on' to allow access\n";
> #endif
>         errs() << MODULE << "falling back to interpreter mode\n";
>         return 0;
>     } else {
>         sys::Memory::ReleaseRWX(B);
>     }
> 
> The fact that the developers assumed that SE Linux is the only
> mechanism that prevents RWX access is interesting.

SELinux seems to be the only one which prevents RWX in a "nice
way" (i.e. mmap of RWX fails), which allows for ClamAV to fallback to
non-JIT mode [*].
PaX for example allows the mapping and just kills the program when RWX
is attempted.

> 
> Now the boolean in question only applies to the clamd_t domain not
> the freshclam_t domain, but for some reason freshclam uses the jit
> anyway. 

Starting with 0.96.1 freshclam loads the databases to test them, that
is why it suddenly needs the JIT.

> Should we put in a dontaudit rule for freshclam_t or include
> it in the boolean section so that it gets execmem access if clamd_t
> gets it?

IMHO clamd, clamscan and freshclam's execmem should be controlled
by the same boolean.

> 
> Also on my system the error message about SE Linux doesn't seem to
> get written to the log file, so I only found it by reading the source.
> 

Yes, unfortunately libclamav doesn't have access to clamd's logfile,
and clamd redirects stderr to /dev/null.
That might change in a future release.

[*]
I have some plans to make the JIT work without RWX, since ClamAV has 2
phases:
 - load DB, JIT compile bytecode (should use only RW- mapping, but
   currently needs RWX)
 - execute (JIT compiled) bytecode (should change mapping to be R-X)

It requires some changes to the JIT though (it still emits some stubs
that need RWX during the DB load).

Best regards,
--Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
