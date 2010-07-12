Subject: Re: clamav RWX
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwintorok@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20100712155526.344eefdf@debian>
References: <201007121922.48247.russell@coker.com.au>
	 <20100712140130.468b7b42@debian>
	 <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
	 <20100712155526.344eefdf@debian>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jul 2010 12:31:11 -0400
Message-ID: <1278952271.5221.245.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-12 at 15:55 +0300, Török Edwin wrote:
> On Mon, 12 Jul 2010 07:48:29 -0400
> Eric Paris <eparis@parisplace.org> wrote:
> 
> > 2010/7/12 Török Edwin <edwintorok@gmail.com>:
> > 
> > > [*]
> > > I have some plans to make the JIT work without RWX, since ClamAV
> > > has 2 phases:
> > >  - load DB, JIT compile bytecode (should use only RW- mapping, but
> > >   currently needs RWX)
> > >  - execute (JIT compiled) bytecode (should change mapping to be R-X)
> > 
> > Just so you know that is going to require the same permissions.
> > (Hopefully) The only way to get around the SELinux permissions is to
> > have 2 separate mappings.  Basically in really really rough sudo-code,
> > 
> > file = open(filename, RWX);
> > unlink(file);
> > truncate(file, however big you need);
> > exec_area = mmap(PROT_EXEC, file);
> > write_area = mmap(PROT_WRITE, file);
> > 
> > then do all of the writing to write_area and all of the executing in
> > exec_area.
> > 
> > http://people.redhat.com/drepper/selinux-mem.html
> 
> Yes I've seen that page, however that is not going to be so simple.
> All the relocations are done assuming that the code will be executed
> where you write it to (and all absolute jumps are generated the
> same way).
> Changing that would be a lot of work, and could introduce new bugs.
> 
> > 
> > Simply using mremap to change a mapping from PROT_WRITE to PROT_EXEC
> > will cause the same problems as just doing it at the same time.
> 
> Then I'd better write a small testcase before converting LLVM to do
> that.
> IIRC I tried something like that and worked, but I could have done
> something wrong. Will try again to be sure.
> 
> Is there a boolean (other than execmem) that would allow RW -> RX
> mprotect()?

For a private anonymous mapping, we always check execmem if PROT_EXEC
(even for a RX mapping), as it still represents making executable
arbitrary data (not tied to any file or covered by an file-based
checks).  So you have:
Private anonymous mapping RW => no checks
Private anonymous mapping RX => execmem

For a shared anonymous mapping, which internally creates a tmpfs node,
we have:
Shared anonymous mapping RW => read, write to tmpfs node
Shared anonymous mapping RX => read, execute to tmpfs node

For a private file mapping, we have:
Private file mapping RW => read to file (no write since it is COW and
the file is not modified)
Private file mapping RX => read, execute, execmod (if modified during
prior RW mapping) to file

For shared file mapping, we have:
Shared file mapping RW => read, write to file
Shared file mapping RX => read, execute to file

> Why is the 2 mappings approach more secure though?

In theory, it requires the exploit writer to find two (hopefully
independently randomized) mappings in order to both write the payload
and execute from it.

> What I want is generate some code at runtime, execute it, then maybe
> change it again, and execute that. Both do just that.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
