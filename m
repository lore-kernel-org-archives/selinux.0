From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill Laut <wlsel@verizon.net>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Date: Fri, 1 Aug 2003 09:41:55 +1000
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <200308010126.58444.russell@coker.com.au> <200307311226.14299.wlsel@verizon.net>
In-Reply-To: <200307311226.14299.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308010941.55431.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Aug 2003 02:26, Bill Laut wrote:
> > Using IRC without X access is no great hardship, while using a text based
> > MUA loses significant functionality.  X is currently the main area that
> > SE Linux does not address yet.
>
> And, IMO, one of the greater dangers since it is/can be installed with
> privilege, so that a latent buffer overrun exploit there could allow an
> attacker unrestrained write access to the kernel itself.

I think that you misunderstood my message.  I was referring to the fact that 
it is impossible to restrict an application which has X access from snooping 
the windows of other X programs or reading the keyboard buffer.

As for the access that the X server program gets, I run X with the FrameBuffer 
driver and it has no access to kernel memory and the only capabilities it has 
which are of note are sys_rawio and sys_admin.  I'm not sure why sys_admin is 
needed, and sys_rawio should not be needed for framebuffer (but the X server 
wants it anyway - probably a bug in the X server).

If we fix these issues then a compromise of the X server should not grant any 
access other than the ability to have total control over the screen and 
keyboard (which is still quite bad).

> > A mail client wants to access mail files under the user's home directory,
> > this means that the files in question need a separate type as you don't
> > want the mail client to access all the other files in the home directory.
> > This gives the usual issues of mv followed by file creation giving a
> > different type and preventing things working in a way that novice users
> > can't debug...
>
> Or, perhaps, what is needed all along is a security-aware mail client
> that's been properly designed and tested against buffer overruns, so that
> it can specify the type for the files it creates/maintains while at least
> attempting to protect itself from being compromised by an exploit, along
> with existing files being properly relabeled.

If we're going to do such things then the best first step would be to have an 
external program establish the POP/IMAP connection and then pass the file 
handle back to the main MUA.  Then the MUA would not have the passwords.  
Also something similar needs to be done for GPG.  Currently MUA's get the 
POP/IMAP passwords and the GPG pass-phrase in normal operation...

> > From what I've seen, KDE is
> > way too integrated with itself to behave nicely with SE without changes
> > in the KDE code itself.
>
> I've been looking for an excuse to learn the internals of KDE, so it looks
> like I've found one.  Perhaps the first thing to do is tackle X before
> going after KDE?

KDE is a much easier thing to work on...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
