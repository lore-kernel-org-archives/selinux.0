Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA27807
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 22:03:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA21982
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 02:02:25 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id CAA21978
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 02:02:24 GMT
Date: Wed, 24 Jul 2002 10:02:02 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: busybox policy and multicall binaries
In-Reply-To: <20020723174843.6B6361CBE@lyta.coker.com.au>
Message-ID: <Pine.LNX.4.44.0207240956520.272-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1





On Tue, 23 Jul 2002, Russell Coker wrote:

> On Tue, 23 Jul 2002 18:14, Rogelio M. Serrano Jr. wrote:
> > On Tue, 23 Jul 2002, Russell Coker wrote:
> > > On Tue, 23 Jul 2002 11:55, Rogelio M. Serrano Jr. wrote:
> > > > Whats the best way to handle multicall binaries like busybox? The basic
> > > > problem is that the context used in permission checking is the context
> > > > of
> > >
> > > Why do you want anything special for busybox?  Why not just have it in
> > > bin_t and let it run in the same domain as the calling process?
> >
> > I see. And then I use special scripts that transition into the proper
> > domains like getty_t for my getty substsututes.
>
> Maybe it would be best to modify busybox to use exec_secure() to run it's
> sub-processes in the correct domain.

This will mean setting up a config file where busybox will get the context
for its applets. Im experimenting with the wrapper script concept above
and its working well. I have modified busybox a bit to help me debug the
policy. I can boot an enforcing kernel now.

I will try using exec_secure when the experiment is complete.

>
> --
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in your
> address-book so that WHEN you get a virus it won't use my address in the
> >From field.
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Pgq76r8UsQIvzXwRAjeMAJ0WwJwOib3wq+DoA2UTbQqVIa3ToQCcCs1a
Bvnm0/HeGQCcLTr3v5I9rqY=
=y/SJ
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
