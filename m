Subject: Re: clamav RWX
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwintorok@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20100713092956.32be6466@debian>
References: <201007121922.48247.russell@coker.com.au>
	 <20100712140130.468b7b42@debian>
	 <AANLkTin7CS0jgjas9otPYwMh0CSqdIaMMQ72YhQaqdmT@mail.gmail.com>
	 <20100712155526.344eefdf@debian>
	 <1278952271.5221.245.camel@moss-pluto.epoch.ncsc.mil>
	 <20100712210807.675e6e0e@debian>
	 <1278966414.5221.296.camel@moss-pluto.epoch.ncsc.mil>
	 <20100713092956.32be6466@debian>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 11:26:16 -0400
Message-ID: <1279034776.28691.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-13 at 09:29 +0300, Török Edwin wrote:
> On Mon, 12 Jul 2010 16:26:54 -0400
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Mon, 2010-07-12 at 21:08 +0300, Török Edwin wrote:
> > > On Mon, 12 Jul 2010 12:31:11 -0400
> > > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > 
> > > > On Mon, 2010-07-12 at 15:55 +0300, Török Edwin wrote:
> > > > > On Mon, 12 Jul 2010 07:48:29 -0400
> > > > > Eric Paris <eparis@parisplace.org> wrote:
> > > > > 
> > > > > > 2010/7/12 Török Edwin <edwintorok@gmail.com>:
> > > > > > 
> > > > > > > [*]
> > > > > > > I have some plans to make the JIT work without RWX, since
> > > > > > > ClamAV has 2 phases:
> > > > > > >  - load DB, JIT compile bytecode (should use only RW-
> > > > > > > mapping, but currently needs RWX)
> > > > > > >  - execute (JIT compiled) bytecode (should change mapping
> > > > > > > to be R-X)
> > > > > > 
> > > > > > Just so you know that is going to require the same
> > > > > > permissions. (Hopefully) The only way to get around the
> > > > > > SELinux permissions is to have 2 separate mappings.
> > > > > > Basically in really really rough sudo-code,
> > > > > > 
> > > > > > file = open(filename, RWX);
> > > > > > unlink(file);
> > > > > > truncate(file, however big you need);
> > > > > > exec_area = mmap(PROT_EXEC, file);
> > > > > > write_area = mmap(PROT_WRITE, file);
> > > > > > 
> > > > > > then do all of the writing to write_area and all of the
> > > > > > executing in exec_area.
> > > > > > 
> > > > > > http://people.redhat.com/drepper/selinux-mem.html
> > > > > 
> > > > > Yes I've seen that page, however that is not going to be so
> > > > > simple. All the relocations are done assuming that the code
> > > > > will be executed where you write it to (and all absolute jumps
> > > > > are generated the same way).
> > > > > Changing that would be a lot of work, and could introduce new
> > > > > bugs.
> > > > > 
> > > > > > 
> > > > > > Simply using mremap to change a mapping from PROT_WRITE to
> > > > > > PROT_EXEC will cause the same problems as just doing it at the
> > > > > > same time.
> > > > > 
> > > > > Then I'd better write a small testcase before converting LLVM
> > > > > to do that.
> > > > > IIRC I tried something like that and worked, but I could have
> > > > > done something wrong. Will try again to be sure.
> > > > > 
> > > > > Is there a boolean (other than execmem) that would allow RW ->
> > > > > RX mprotect()?
> > > > 
> > > > For a private anonymous mapping, we always check execmem if
> > > > PROT_EXEC (even for a RX mapping), as it still represents making
> > > > executable arbitrary data (not tied to any file or covered by an
> > > > file-based checks).  So you have:
> > > > Private anonymous mapping RW => no checks
> > > > Private anonymous mapping RX => execmem
> > > > 
> > > > For shared file mapping, we have:
> > > > Shared file mapping RW => read, write to file
> > > > Shared file mapping RX => read, execute to file
> > > 
> > > So if I map a tempfile as RW, write my JITed code to it, then
> > > mprotect to RX will it work without 'execmem'?
> > 
> > That would remove the requirement for execmem, yes.  But clamd_t and
> > freshclam_t would then require appropriate permissions to the file,
> > including create, unlink, read, write,
> 
> I would have these permissions for something in /tmp, right?
> 
> > and execute.
> 
> I probably wouldn't have this though.
> 
> >  You can avoid the
> > create+unlink requirement by mapping /dev/zero or using MAP_SHARED|
> > MAP_ANONYMOUS, but you'd still need RWX to the file.  So I'm not sure
> > what we gain there.
> 
> If I can change the mapping from RW <-> RX, then the mapping is
> writable only for a brief period (DB reload), so an exploit can't take
> advantage of the RWX mapping (since there is no RWX mapping).
> Thats better than allowing 'execmem' for the entire process, isn't it?

Allowing execmem just permits the process to perform a mmap or mprotect
of an anonymous mapping with PROT_EXEC.  It doesn't automatically apply
PROT_EXEC to any mappings (it isn't the same as marking the executable
as requiring an executable stack).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
