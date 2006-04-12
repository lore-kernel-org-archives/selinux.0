Date: Wed, 12 Apr 2006 07:14:54 -0500
From: Steve Greenland <steveg@moregruel.net>
To: Javier Fernandez-Sanguino Pen~a <jfs@computer.org>
Cc: janak@us.ibm.com, jvdias@redhat.com, ciaranm@gentoo.org, dwalsh@redhat.com,
        sgrubb@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        russell@coker.com.au
Subject: Re: [RFC] [PATCH] Extend vixie-cron to allow cron jobs at multiple security contexts
Message-ID: <20060412121454.GA11981@moregruel.net>
Reply-To: Steve Greenland <steveg@moregruel.net>
References: <1144422989.7681.6.camel@hobbes.atlanta.ibm.com> <200604121859.50999.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604121859.50999.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(Sorry for the wide distribution, but I wanted to make sure all future
replies go to the right place.)

Javier, it looks like the SELinux folks are at it again, see below. Russell
copiedme on this message, I didn't see any of the previous messages.

Everybody else: I, Steve Greenland, am no longer the Debian cron
maintainer. The new maintainer is Javier Fernandez-Sanguino Pen~a
<jfs@computer.org> (I'm sure my 7-bit ASCII lifestyle mangled the accent
on his last name, apologies). Please direct future CCs to him, and
remove me from the CC list.

Thanks,
Steve

On 12-Apr-06, 03:59 (CDT), Russell Coker <russell@coker.com.au> wrote: 
> On Saturday 08 April 2006 01:16, JANAK DESAI <janak@us.ibm.com> wrote:
> > +				if ((strlen(pw->pw_name) +
> > +				     strlen((char *)context)) >= sizeof User) {
> 
> Shouldn't that be the following instead?
>  				if ((strlen(pw->pw_name) +
>  				     strlen((char *)context)) + 2 > sizeof User) {
> 
> > +			if (strlen(optarg) >= sizeof User)
> 
> Shouldn't that be the following instead?
> 			if (strlen(optarg) + 1 >= sizeof(User) )
> 

-- 
Steve Greenland
    The irony is that Bill Gates claims to be making a stable operating
    system and Linus Torvalds claims to be trying to take over the
    world.       -- seen on the net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
