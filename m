Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h577ZRI4007724
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 03:35:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h577Ypss004949
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 07:34:52 GMT
Received: from blackhole.oftc.net (blackhole.oftc.net [213.70.168.208])
	by jazzswing.ncsc.mil  with ESMTP id h577YohY004946
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 07:34:51 GMT
Received: from eelf.ddts.net
	([24.102.105.152] helo=willow.eelf.ddts.net ident=mail)
	by blackhole.oftc.net with esmtp (Exim 3.35 #1 (Debian))
	id 19OYEW-0002dM-00
	for <selinux@tycho.nsa.gov>; Sat, 07 Jun 2003 07:35:24 +0000
Received: from willow.eelf.ddts.net ([192.168.1.1])
	by willow.eelf.ddts.net with smtp (Exim 3.36 #1 (Debian))
	id 19OYEV-0006xm-00
	for <selinux@tycho.nsa.gov>; Sat, 07 Jun 2003 03:35:23 -0400
Date: Sat, 7 Jun 2003 03:35:22 -0400
From: David B Harris <david@eelf.ddts.net>
To: selinux@tycho.nsa.gov
Subject: Re: LSM/SELinux 2.4.x on a production machine
Message-Id: <20030607033522.7036240a.david@eelf.ddts.net>
In-Reply-To: <200306071629.44125.russell@coker.com.au>
References: <20030607013114.2356788d.david@eelf.ddts.net>
	<200306071629.44125.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.lGzoFDf5XxXz7/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=.lGzoFDf5XxXz7/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey folks :)

At Russell's request, I've included below Russell's replies to a couple
of questions, and my replies to his replies. I'm subscribed to this as
of a few minutes ago, so please don't Cc: me on replies; I get way too
much non-filterable mail as it is.

Just a bit of background, I'm the primary systems administrator for
http://www.oftc.net/. We've recently received some dedicated hardware,
and I'm going to be implementing the framework to provide FOSS
projects/communities with hosting facilities (ie: web, CVS, mail, that
sort of thing).

Ideally, I would like to lock down the systems to a reasonable degree,
while still maintaining a free flow of information and files to and from
all the various users. This type of shared system is a ways off yet, we
don't quite have the hardware and bandwidth to support heavy usage yet.
So in the meantime, we'll just be doing CVS/mail/web, managed by the
users through CVS or similar. I've enough experience to do this
reasonably safely in a non-LSM/SELinux system.

However, given the obviously large amount of time it'll take for me to
audit the distributed policies, and adjust them to our needs, I'm
getting started now :)

On Sat, 7 Jun 2003 16:29:44 +1000
Russell Coker <russell@coker.com.au> wrote:
> I find it very difficult to match up names and faces.  If you send me a jpg of 
> yourself I'll probably recognise you.

Oh, it's not really relevant. I grilled you for a few minutes on the
general concepts behind SELinux, but didn't really get into the
detailed, implementation-specific stuff.

> > Right now, I'm pretty much just going to give members restricted
> > (CVS-only) access to our hardware, no shell login or anything. They'll
> > manage their web stuff, mailing list stuff, etc., via CVS. This is
> > doable with stock Linux, and reasonably safe.
> >
> > One of these days, however (perhaps after we get some more dedicated
> > hardware), I'd like to set up a true multiuser system. Real community
> > thing, you know?
> 
> Sounds like a good use for SE Linux.  SourceForge use OpenWall (or used it 
> last time I checked) for such things.  SE Linux is much more powerful than OW 
> and gives you detailed control over what to allow and what to deny.

Yeah, I've come to (more or less) the same conclusion. Though
preliminary. It may turn out that something a la OpenWall or grsecurity
is "good enough". We'll see, anyways, when I'm done prototyping systems
:)

> > Given how complex LSM/SELinux is, I want to start working on it now.
> > However, given the amount of time and effort it's going to take auditing
> > the distributed policy and adjusting it for our needs, I wanted to know
> > - do you consider it production-ready? I asked if anybody in #selinux on
> > irc.freenode.net was using it for production machines, and it was
> > generally used on single-purpose/simplistic installations.
> 
> I'm running two ISPs on SE Linux.  I think it's production ready.

Thanks, a vote of confidence from somebody who uses it full-time means a
fair bit.

> 
> The only problem with SE Linux at the moment for serious installations is the 
> lack of support for backup of security contexts of files.  This will be fully 
> addresses in Linux 2.6.0, and in the mean time there are hacks you can use, 
> but nothing satisfactory.

Probably won't be moving to 2.6.x in the forseeable future, for the
machine(s) in question. That being said, I'll back them up manually if
need be. (ie: by hand, writing down on a piece of paper what's being
done where ;)

> As you won't want people using your server for running Netscape then the most 
> you will have to worry about is some small difficulty with UML, which could 
> easily be fixed by changing the policy.  Also as your typical user probably 
> won't be interested in great security they will probably run UML kernels 
> under their own user domain, in which case the issue is moot.

I'll be running UMLs myself (as system administrator), but I also have
the ability to modify policy and whatnot, so that's not a big deal :)

I won't support users running UMLs, at least not currently. They're too
resource-intensive; any UMLs running will be shared resources.

> I have considered the possibility of patching a mail server to run procmail 
> for delivery in a special user context.  Then procmail can safely access the 
> .procmailrc file and deliver mail to the user's home directory, but it can't 
> access the home directory of a user in another role.

Yeah, this is my question; Exim will presumably be able to drop its Unix
privileges as normal, but it will remain in the same domain, correct?
(So should that procmail process elevate its privileges in a mundane
manner via buffer overflow or setuid root shell or somesuch, they will
actually have elevated privileges? Compared to say, a patched SSH,
where even if the user's process gets "root", they can't do root-y
stuff? They're not "real" root?)

> However will you even be using multiple roles?  For a system such as you 
> describe it's likely that you will have three roles, staff_r (for minor 
> administration tasks), sysadm_r (for serious administration - mkfs, fdisk, 
> etc), and user_r (for the users).  Now if you demand that all people in 
> staff_r also have an account in user_r for their email, then you can just 
> restrict procmail to only accessing user_r.

I'm afraid my inexperience with SELinux and MAC in general will show a
bit here, I'm unsure of the subtle differences between a domain and a
role, in this case.

Specifically, all I'm really aiming for is a somewhat hardened box (ie:
those three basic roles you mentioned), and the ability to segregate
users should they desire it. For instance, should one of our users be a
bit paranoid about others sniffing around /proc to see what they're
doing and whatnot, we'd like to be able to support their request (within
reason).

Personally, I look forward to seeing how well I can get this stuff done
while still retaining the community part of it :) SourceForge really
segregates projects from one another, ditto for users.

> Please take this discussion to the SE Linux list if possible, so others can 
> also join in.  I will post a message to the list containing parts of my text 
> that don't directly refer to your message for the benefit of others.

Sure. I'm about to head off to bed, but I'll subscribe to it in the
morning and carbon copy this email to it. If you haven't fired off your
own email yet, can you hold off until tommorow so I can participate?
Thanks :)

Er, yeah, thanks again too :)


--=.lGzoFDf5XxXz7/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+4ZW6uCQ/g7GxJcARAs5CAJ4iA9ViTyuVyOOMlrkgbwfJacfa6ACgi4CW
BFGTxWv37U7Iz3iiMaLBRDY=
=HIJf
-----END PGP SIGNATURE-----

--=.lGzoFDf5XxXz7/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
