Date: Thu, 20 Dec 2001 10:34:14 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: Russell Coker <russell@coker.com.au>
cc: Stephen Smalley <sds@tislabs.com>, SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Debian SE Linux ?
In-Reply-To: <20011220114333.80B9616F59@lyta.coker.com.au>
Message-ID: <Pine.LNX.4.21.0112201030220.27491-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Russell Coker has a Debian kernel-patch package for SELinux at
> > http://www.coker.com.au/selinux.  I don't know whether the Debian folks

I am just using the LSM kernel found on NSA's page, with ext3 enabled.

> > I'm not sure what you mean when you say
> > "I am still sorting out ext3 + initrd."  The current release of SELinux
> > works fine with ext3 - we were just waiting for ext3 to be merged into the
> > mainstream kernel, and it is present in the 2.4.16 kernel.  As far as
> > initrd is concerned, you can probably make it work if you really need it.
> > I think you just need to create an initrd image that includes a copy of the
> > compiled policy configuration so that it is available.

what I meant here was "still sorting out ext3" by itself, before working
on attempting to get it to work with SELinux.  (though I heard it should
be no real problem.).

What I meant was I don't quite understand why they did what they did with
initrd.  If it isn't possible to have it simply boot root as ext3, why not
boot it as ext2 and then remount it as ext3 later in the process?  Am I
missing something?

> Having the policy on the initrd is painful.  I think that the best solution 

oh no, I wasn't going to do that!

> is to turn on the SE functionality after the root FS has been mounted (if 
> they can crack your machine at initrd time you're pretty much stuffed 
> anyway).  Stephen, I got the impression from a previous message that such 
> delayed startup of SE functionality is possible with the 
> CONFIG_SECURITY_SELINUX_DEVELOP option, but I haven't looked into that yet.

I was going to ask exactly how you toggle the enforcement with the debug
options.  (I am sure it is in the FAQ somewhere, and I am just blind
though.).


 thanks,
     noah silva 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
