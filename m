Date: Thu, 23 Sep 2010 23:12:36 +0300
From: =?UTF-8?B?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
To: "SE-Linux" <selinux@tycho.nsa.gov>
Cc: russell@coker.com.au, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris
 <eparis@parisplace.org>
Subject: Re: clamav RWX
Message-ID: <20100923231236.0016cc22@deb0>
In-Reply-To: <201007131641.54298.russell@coker.com.au>
References: <201007121922.48247.russell@coker.com.au>
	<1278966414.5221.296.camel@moss-pluto.epoch.ncsc.mil>
	<20100713092956.32be6466@debian>
	<201007131641.54298.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

A comment on this bug reminded me that we haven't found any solution
for the JIT-under-SELinux issue (except double mapping):
https://bugzilla.redhat.com/show_bug.cgi?id=573191#c29

As discussed last time, the RW <-> RX change would be needed only during
a brief period (DB reload).
Using a shared mapping would trade RWX requirements on memory for
RWX requirements on a file which is not better.

I have some new ideas though.

1. new protection, lets call it execmem_trustedonly

Some observations first:
 - there is 1 thread in clamd that reloads the database
 - if that thread is compromised it is game over anyway (someone can
load a malformed signature that causes clamd to quit, load empty DB,
etc.)
 - hence that thread is somewhat "trusted" already
 - if you find a way to exploit that thread, then execmem protection
   won't help, you can do almost anything with ClamAV already, all you
   need is write access to memory
 - the official databases are digitally signed, and ClamAV by default
   won't load bytecode from unsigned databases (it will for normal
   signatures of course)

It'd be good if clamd could, on startup, tell the OS that it has a
*single* thread that needs RW <-> RX transitions. The OS could check
that the SELinux policy allows that, lets call it execmem_trustedonly.

Not sure what the proper mechanism would be to do this, maybe
some prctl() call, or some mechanism similar to dropping root
privileges:
 - if SELinux policy allows execmem_trustedonly the main thread starts
   with this capability (doing RW <-> RX transitions)
 - it can atomically transfer this capability to other threads
   (permanently losing it, with no transfer back possible)
 - it can completely turn off the capability if it doesn't need it

The DB reload thread happens to be clamd's main thread, so it would
have this capability. As discussed this thread is the most trusted in
clamd, if you found a way to make it execute arbitrary code then
execmem protections will get you no additional protection anyway.

If one of the scanner threads is exploited, then execmem protections
would trigger and stop it. The DB reload thread would be able to
use the JIT, and all would be good.

2. Investigate if LLVM can do relocations to a different map. In fact
it already does relocations, but it assumes the code will run in the
same place as original. Also there might be some absolute addresses
emitted.
If yes then the 2 maps approach would work (codegen to one, exec
another).

3. Once I codegened to the writable map, I don't need it anymore and
will probably free it. Wouldn't it be great if the OS could relocate
the executable mapping to the same place the writable mapping was?
We know for sure there is enough space there.
mremap() seems to be able to do this, and seems to automatically unmap
whatever was in place of the target address so it seems to be atomic
too.
Would this work for SELinux?

It would go like this:
create map pairs at addresses X(RW) and Y (RX) linked by a file as
described in the no execmem docs.
codegen to map at address X as usual.
When done, use mremap() to move the executable mapping from address Y
to X, atomically unmapping the existing RW mapping at address X.

I'm open to other ideas too of course.

Best regards,
--Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
