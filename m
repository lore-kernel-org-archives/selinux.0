Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09LIEba023249
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:18:14 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09LJ3PN021884
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 21:19:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l09LJ3DG028335
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:19:03 -0500
Subject: Re: [RFC] Support for bzip compressed modules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1168361406.13080.12.camel@code.and.org>
References: <45A2AADC.1090907@mentalrootkit.com>
	 <1168327098.22423.93.camel@code.and.org>
	 <45A3BA1B.9000908@mentalrootkit.com>
	 <1168361406.13080.12.camel@code.and.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 16:18:22 -0500
Message-Id: <1168377502.4983.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 11:50 -0500, James Antill wrote:
> On Tue, 2007-01-09 at 10:51 -0500, Karl MacMillan wrote:
> > James Antill wrote:
> > > On Mon, 2007-01-08 at 15:34 -0500, Karl MacMillan wrote:
> 
> > >> I didn't want to add additional set functions - I would have preferred 
> > >> to allow sepol_policy_file_set_[mem,fd] to transparently open compressed 
> > >> streams with functions to set other behaviors as options stored in 
> > >> sepol_policy_file_t structs. This was not possible becuase the current 
> > >> set functions do not return errors.
> > > 
> > >  Do we really care about the memory usage, my instinct would be to drop
> > > the FILE specific code and just dump everything into memory and then
> > > call the mem_set function and thus. have only one decompression loop
> > > (adding the fd version is simple then too).
> > >  Calling fstat(fileno(fp)) to read the policy in is probably easier than
> > > a loop.
> > > 
> > 
> > Not certain what you are getting at - both code paths result in an 
> > uncompressed copy of the compressed data in memory. The only difference 
> > is whether we are decompressing from an fd or from another memory buffer.
> 
>  Just that it seems easier to have the set_fp() function load all the
> data into memory and call the set_mem() function, and have all of the
> bz2 stuff in just the set_mem() function.
> 

Ah - I see. I prefer the separate decompression paths because the mem
case is potentially very inefficient. No strong preference though.

> > > . check is always true in callers, and I'm not sure why you'd have it
> > > zero.
> > > 
> > 
> > The magic number checking seems fragile - I'm assuming it might be 
> > necessary to force the stream as compressed at some point. Since we are 
> > maintaining ABI for this library (and these functions), seems better to 
> > be safe.
> 
>  Do policy files not have a magic value, then?

They do, but there is no real restriction that these policy file things
get used for files containing policy. Currently they are used for a
variety of file types and I would hate to hard code a list valid file
types into this function.

>  You can also (for bz2)
> check that the next value is between 1 and 9 (it's the compression
> ratio).

Ok. Could this be used for sizing the buffer in the memory case? In
other words, is it a user setting that was passed to bzip or information
about the result of the compression?

>  I assume this means you'd rely on anything ending in ".bz2" being
> compressed, and not otherwise ... do we always have a filename?
> 

No, and in fact we explicitly rename the policy modules in the store to
whatever name is set within the policy. So if you create a module name
foo saved in the file bar.pp.bz2, after 'semodule -i bar.pp.bz2' there
will be a file called foo.pp in the module store. I didn't change that
behavior, so file extension is not useful here.

> > > . All code paths have:
> > > 
> > >  if (set_foo_bz2() == FAILED)
> > >   set_foo();
> > > 
> > > ...which tells me set_foo_bz2() should do that ... in fact it seems sane
> > > to just change set_foo() to check of bz2ness and do the right thing,
> > > without having to alter the callers.
> > > 
> > 
> > Note my comments with the original patch - this isn't possible because 
> > set_foo() has a void return and we want to maintain binary compatibility.
> 
>  Right, but as I said the error paths always just try again without
> compression ... so why not just try the compression at the start of the
> set_foo() code. You get the same behaviour.
> 

It is not about returning information about the compression. It is
because the compression routines have other error paths (failure to load
libbz2, memory allocation, etc.). There is no good way to indicate those
errors without changing the prototypes. Even if we didn't change the
prototypes, it is valid to not check the current functions for error, so
we can't change them in any way that has potential error paths.

> > >  I assume the only reason you went with bzip2 over gzip is the "have to
> > > init yourself in the set_mem case"?
> > 
> > No - just better compression.
> > 
> > [kmacmill@localhost ~]$ ls -l base.pp.*
> > -rw-r--r-- 1 kmacmill kmacmill  86379 Jan  9 10:50 base.pp.bz2
> > -rw-r--r-- 1 kmacmill kmacmill 167382 Jan  9 10:50 base.pp.gz
> 
>  Wow ... that's better than usual. Do you have the same difference for
> smaller modules?
> 

[kmacmill@localhost ~]$ ls -l alsa.pp*
-rw-r--r-- 1 kmacmill kmacmill 41720 Jan  9 16:13 alsa.pp
-rw-r--r-- 1 kmacmill kmacmill  4987 Jan  9 16:13 alsa.pp.bz2
-rw-r--r-- 1 kmacmill kmacmill  5145 Jan  9 16:13 alsa.pp.gz

[kmacmill@localhost ~]$ ls -l apache.pp*
-rw-r--r-- 1 kmacmill kmacmill 416123 Jan  9 16:14 apache.pp
-rw-r--r-- 1 kmacmill kmacmill  15800 Jan  9 16:14 apache.pp.bz2
-rw-r--r-- 1 kmacmill kmacmill  26585 Jan  9 16:14 apache.pp.gz

Not quite as dramatic always, but still a significant difference.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
