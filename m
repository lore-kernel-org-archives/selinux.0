Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6CCtZFS007718
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 08:55:35 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6CCvUjj010745
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 12:57:30 GMT
Received: by wyb39 with SMTP id 39so3581974wyb.12
        for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 05:55:33 -0700 (PDT)
Date: Mon, 12 Jul 2010 15:55:26 +0300
From: =?UTF-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: clamav RWX
Message-ID: <20100712155526.344eefdf@debian>
In-Reply-To: <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
References: <201007121922.48247.russell@coker.com.au>
	<20100712140130.468b7b42@debian>
	<AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2010 07:48:29 -0400
Eric Paris <eparis@parisplace.org> wrote:

> 2010/7/12 Török Edwin <edwintorok@gmail.com>:
> 
> > [*]
> > I have some plans to make the JIT work without RWX, since ClamAV
> > has 2 phases:
> >  - load DB, JIT compile bytecode (should use only RW- mapping, but
> >   currently needs RWX)
> >  - execute (JIT compiled) bytecode (should change mapping to be R-X)
> 
> Just so you know that is going to require the same permissions.
> (Hopefully) The only way to get around the SELinux permissions is to
> have 2 separate mappings.  Basically in really really rough sudo-code,
> 
> file = open(filename, RWX);
> unlink(file);
> truncate(file, however big you need);
> exec_area = mmap(PROT_EXEC, file);
> write_area = mmap(PROT_WRITE, file);
> 
> then do all of the writing to write_area and all of the executing in
> exec_area.
> 
> http://people.redhat.com/drepper/selinux-mem.html

Yes I've seen that page, however that is not going to be so simple.
All the relocations are done assuming that the code will be executed
where you write it to (and all absolute jumps are generated the
same way).
Changing that would be a lot of work, and could introduce new bugs.

> 
> Simply using mremap to change a mapping from PROT_WRITE to PROT_EXEC
> will cause the same problems as just doing it at the same time.

Then I'd better write a small testcase before converting LLVM to do
that.
IIRC I tried something like that and worked, but I could have done
something wrong. Will try again to be sure.

Is there a boolean (other than execmem) that would allow RW -> RX
mprotect()?

Why is the 2 mappings approach more secure though?
What I want is generate some code at runtime, execute it, then maybe
change it again, and execute that. Both do just that.


Best regards,
--Edwin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
