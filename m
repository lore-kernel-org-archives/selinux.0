Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Noah silva <nsilva@atari-source.com>
Subject: Re: Debian SE Linux ?
Date: Thu, 20 Dec 2001 12:43:33 +0100
Cc: SELinux Mailing <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0112191314530.5056-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112191314530.5056-100000@raven>
MIME-Version: 1.0
Message-Id: <20011220114333.80B9616F59@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Dec 2001 19:34, Stephen Smalley wrote:
> > looking back on the list, I saw some people have discussed using Debian
> > Linux with the SELinux patch.  I was wondering if that ever came to
> > anything other than talk.  I am currently working on setting up a test
> > machine with Debian Testing (on x86) and SE Linux.  (ATM, I am still
> > sorting out ext3 + initrd... can't believe there isn't a cleaner
> > solution).
>
> Russell Coker has a Debian kernel-patch package for SELinux at
> http://www.coker.com.au/selinux.  I don't know whether the Debian folks
> have made any progress with the daemon and utility patches or the example
> policy configuration.

I am still (slowly) working on this.  I hope to have all the basics packaged 
by the end of the week...

> I'm not sure what you mean when you say
> "I am still sorting out ext3 + initrd."  The current release of SELinux
> works fine with ext3 - we were just waiting for ext3 to be merged into the
> mainstream kernel, and it is present in the 2.4.16 kernel.  As far as
> initrd is concerned, you can probably make it work if you really need it.
> I think you just need to create an initrd image that includes a copy of the
> compiled policy configuration so that it is available.

Having the policy on the initrd is painful.  I think that the best solution 
is to turn on the SE functionality after the root FS has been mounted (if 
they can crack your machine at initrd time you're pretty much stuffed 
anyway).  Stephen, I got the impression from a previous message that such 
delayed startup of SE functionality is possible with the 
CONFIG_SECURITY_SELINUX_DEVELOP option, but I haven't looked into that yet.

> > Looking at the way SELinux works, I assume I will have at least to alter
> > the policies because of the differences in paths?
>
> You will need to adapt the daemon and utility patches to the corresponding
> Debian packages, although only a few of these patches are critical (login,
> sshd, crond).  You will have to customize setfiles/file_contexts for your
> filesystem layout.  If you build with NSA SELinux Development Module
> option, then you can run your system in permissive mode for a while to
> collect audit messages, and can then work on customizing the policy
> configuration based on those audit messages, possibly using Justin Smith's
> perl script.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
