Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i53JEFrT014281
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 15:14:15 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5438joJ025874
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 23:08:46 -0400 (EDT)
Date: Thu, 3 Jun 2004 19:11:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, samba-tng@lists.samba-tng.org,
   samba-technical@samba.org
Subject: Re: samba
Message-ID: <20040603191131.GC3856@lkcl.net>
References: <200406031543.15551.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406031543.15551.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

uhm.

my apologies for being sufficiently rusty on samba stuff for it to take
several days to remember things.

it occurred to me that there are other locations where seteuid() calls
will be used: in the emulation of NT's DCE/RPC services.

under certain circumstances, for example in an NT printer client,
an NT program will cause an NT system to make an authenticated
DCE/RPC connection over an already authenticated SMB connection.

there are two circumstances in which i definitely know that this
occurs: as mentioned already the first is when viewing a print job:
one thread does the printing and another thread deals with print
monitoring (like famd only in a polling fashion).

the two threads use DIFFERENT security contexts.

the other circumstance that i am aware of is when a user presses
ctrl-alt-delete and then changes their password: _any_ user may
use that dialog to change their password, and so you get an
authenticated DCE/RPC connection made over someone else's
authenticated SMB session.

_there may be other circumstances where this is done_.

now, why am i mentioning this?

the reason is because not only is there a seteuid done in the
SMB connection, but also due to the authenticated DCE/RPC connection
which is piggy-backed over the SMB authenticated transport, there
is also ANOTHER seteuid in the DCE/RPC layer.


therefore, it is necessary to consider context separation at the
DCE/RPC level as well.

and funnily enough, the Samba TNG design has already split out
all of its DCE/RPC services into separate daemons.

therefore, the way to guarantee a working secure se-samba system
with an absolute minimum of coding is:

- to use samba(4) as the front-end

- to use samba-tng as the back-end

- to use samba-tng's NT domain DCE/RPC services.


samba(3) is a monolithic design which runs all DCE/RPC services in a
single process.

therefore, as it stands, it cannot be used for se-samba without
also taking care of the seteuid calls in the DCE/RPC layer as well.


On Thu, Jun 03, 2004 at 03:43:15PM +1000, Russell Coker wrote:
> When discussing SE Linux and Samba with Andrew Tridgell last night we came up 
> with an idea that should work reasonably well without hurting performance 
> much.
> 
> Firstly we consider Samba to be a trusted object manager, so there is no plan 
> to prevent any Samba process from exceeding it's access (IE we are not 
> protecting against a buffer overflow or other attack to make the Samba daemon 
> perform inappropriate actions).
> 
> For operations which require access to a directory tree (IE every operation 
> that does not involve an open file handle - open, creat, unlink, rename, 
> stat, chmod, chown, truncate, etc) we can have a separate samba process 
> that's run in a different context (eg smbd_user_t, smbd_staff_t, etc).  The 
> operations that result in an open file handle (open() and creat()) can then 
> pass back a file handle to the parent process over a Unix domain socket.  For 
> read/write/ioctl/fstat/ftruncate operations the main Samba process can query 
> the SE Linux kernel (or maybe use user space AVC code) as to whether the 
> operations are permitted.
> 
> This was one of many possible ways of doing this that we discussed.  I don't 
> think it was Andrew's favourite, but I think it works best with what we are 
> trying to do.

 as i have mentioned before, andrew's knowledge of unix system
 programming is extremely comprehensive, and if anyone can implement
 it in a secure manner, it's going to be andrew.


 it's not the simplest "get-it-working" approach.  using samba(4)
 as the front-end and samba-tng as the back-end is definitely the
 simplest.


> Another possibility is to just not permit multiple SMB identities over the 
> same TCP socket, there's apparently a registry setting that can be used on 
> each SMB client machine to make it use a separate TCP socket per connection.  

 that does not take care of DCE/RPC services which cannot be stopped
 from using the SMB layer to seteuid or provide threaded  support.


> In which case we just need to change the Samba code from fork/setuid to 
> fork/setuid/exec (which will not be fun).
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
