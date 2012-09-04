Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q84BVUtP026543
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2012 07:31:30 -0400
Date: Tue, 4 Sep 2012 13:31:05 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: 'Context Separation'
Message-ID: <20120904113105.GE2999@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd like to take a moment to introduce the project I'm working=20
on. I call it 'context separation' (consep). It shall provide a=20
user with the means to separate his desktop into different=20
contexts (Which I will call 'subuser' to distinguish from selinux=20
contexts). The subusers can be named by the user. One subuser is=20
supposed to be used for every of the user's tasks: one for=20
browsing, one for mail, one for working on project A, one for=20
project B etc.

A subuser can be thought of like a sandbox on Fedora (I think so=20
atleast). The main difference probably is that I use XSELinux for=20
separation under X11 while Fedora uses Xephyr proxies. The latter=20
one certainly is cleaner and probably more secure but has a=20
performance and usability impact.

What consep is supposed to offer besides a policy is a set of=20
tools to integrate the subusers into the user's desktop and=20
(hopefully) workflow.


* The policy

The policy is written from scratch but could be rebased to refpol=20
with not so much effort due to strong modularity. I just thought,=20
things were complicated enough already without having to deal=20
with refpol.

Essentially it is a targeted policy. All system processes run in=20
unconfined domains at the moment. Nevertheless the whole=20
filesystem is labeled trying to replicate DAC, so extending the=20
policy to a strict one can be accomplished by writing policy=20
modules for the system processes.

The separation between the main user and his subusers is done via=20
TE between the types main_t (which further divides into xserver_t=20
and wm_t) and sub_t. The subusers themself are separated by MCS=20
in the manner I described in my previous post on this list.

It boils down to this: Every user has 100 slots for subusers,=20
each slot having a specific mcs range to separate it from every=20
other slot.


* The tools

The primary goal of the consep tools is to provide the user with=20
means to name his subuser slots (which by themselves are just=20
category ranges) and then refer to these slots by the given=20
names for all kinds of tasks.

For example: The user creates subusers with names browser, mail=20
and selinux-policy. The system automatically assigns free subuser=20
slots to those names. Once a slot is in use, it cannot be assign=20
to any other name.

The windowmanager then can use the tool 'consep-doas' to do=20
something like:

	consep-doas browser firefox

This will automatically transition to sub_t and the mcs range=20
associated with 'browser' and start firefox.

Each subuser has his own home dir and is supposed to behave like=20
an independent traditional linux user.

Tools also include:

	- A menu program to easily start terminals and other apps as=20
	  one of your subusers.

	- A program to copy X11 selections between subusers. Each=20
	  subuser has his own cutbuffer through polyinstantiation.
=09
	- A daemon that can be used by subusers to send files to=20
	  other subusers.

	- A program to mount removable vfat drives to a specific=20
	  subuser. (E.g. mounting your MP3-player to your=20
	  music-subuser. Gives him and only him access to it.)

	- A simple statusbar program that shows the name of the=20
	  subuser owning the currently active X-window. (That's just=20
	  for convenience, could be spoofed easily.)

All the programs prompt for subuser names using dmenu. The whole=20
system is easily maintained. You just add subuser names to a file=20
in your main user's home dir.

So far this is all working and currently in use by me. I'll open=20
up my hg repository as soon as I have set up a server for this.=20

My time is a bit scarce now, but I will use the next few weeks to=20
write some basic documentation, comment some code and sort out=20
some license issues with stuff I use. Then I'll release a=20
preliminary version under GPL.=20

Not working yet but planned is the ability for subusers to=20
further transition down to subsubusers (e.g. the mail user=20
dropping privileges to view a pdf). This is implemented in the=20
policy already but not in the tools.

Ole

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBF5nkACgkQS1FjE303ERzcEQCePc56OMs7D2JlAxMhmHcu048b
5KoAn1npZSQeRg2YNznmK6hbqaqvC/Jf
=vxw8
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
