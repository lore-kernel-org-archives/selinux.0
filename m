Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOL8WRb010810
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 16:08:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAOL8UqY019370
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 21:08:30 GMT
Received: from web12608.mail.yahoo.com (web12608.mail.yahoo.com [216.136.173.231])
        by jazzband.ncsc.mil  with SMTP id hAOL8T0o019367 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 21:08:30 GMT
Message-ID: <20031124210713.59826.qmail@web12608.mail.yahoo.com>
Date: Mon, 24 Nov 2003 15:07:13 -0600 (CST)
From: =?iso-8859-1?q?Miguel=20Guirao?= <thinkfreemx@yahoo.com.mx>
Subject: Re: smart cards
To: Sead Muftic <sead@dsv.su.se>, russell@coker.com.au,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3.0.32.20031124113541.00aedb98@mail.dsv.su.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!!

I work with SC, try these two web sites:

http://www.linuxnet.com/
http://www.globalplatform.org/

Regards,

Miguel Guirao

 --- Sead Muftic <sead@dsv.su.se> escribió: > Russell:
> 
> >Anyone working on smart-card support for SE Linux?
> 
> My answer to you is "Yes", but it needs some
> clarifications.
> 
> The first problem with smart cards on Linux machines
> are SC and reader
> drivers. We tried to activate
> M.U.S.C.L.E. drivers, we worked on this on-and-off
> several months and we
> didn't reach the point of 
> smooth installation, then activation.
> 
> Just to mention that we have developed SC middleware
> (compliant with OCF
> and US Gov't GSC-IS, v 2.0), 
> so "underneath" we can plug multiple drivers, only
> if they work. This means
> that some alternative
> drivers, if you know of some, can be relatively
> easily "plugged" under our
> middleware.
> 
> Finally, we have in fact developed nice,
> easy-to-use, GUI system to
> administer all aspects
> and entities of SELinux which performs SELinux admin
> functions at the click
> of the button.
> The first version was "single machine" version, i.e.
> it had to be located
> on the same machine
> as SELinux being administered. Now, we are in the
> final phase of testing
> the networked version.
> 
> This SELinux admin interface can use smart cards for
> login and remote
> commands security (based 
> on SSL). However, due to problems with SC drivers it
> runs only on Windows
> (sorry !). 
> 
> 
> >
> >I think it's something we need for the future, but
> at the moment I don't
> know 
> >anyone who is using such hardware and have no
> access to it myself.  If 
> >someone is using smart cards and can tell me what
> needs to be done then I
> can 
> >start planning what we need for SE Linux policy to
> support it.
> >
> 
> 
> As far as policy is concerned, we are following
> Certification Policy,
> compliant with Federal
> Bridge CA, but it regulates only issuance of cards,
> technical parameters
> for those cards and rules
> of handling certificates, not much related to
> SELinux, for the time being.
> 
> Regards,
> 
> Sead Muftic
> SETECS
> Rockville, MD
> 
> 
> 
> --
> This message was distributed to subscribers of the
> selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message. 

_________________________________________________________
Do You Yahoo!?
La mejor conexión a internet y 25MB extra a tu correo por $100 al mes. http://net.yahoo.com.mx

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
