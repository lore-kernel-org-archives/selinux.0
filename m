Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JHfQI4005192
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 13:41:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JHf4Qj013386
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 17:41:04 GMT
Received: from datas-world.dyndns.org (dsl-213-023-225-006.arcor-ip.net [213.23.225.6])
	by jazzswing.ncsc.mil  with ESMTP id h4JHf1xS013377
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 17:41:03 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Re: Thinking about an extension to the cron patch
Date: Mon, 19 May 2003 19:37:22 +0200
References: <200305181707.00953.tk-selinux@datas-world.de> <1053345240.4729.931.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1053345240.4729.931.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305191940.55964.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > I already had a mail conversation with the cron maintainer about some
> > changes to the patch. The patch is now a little smaller, because we don't
> > need the *system* hack any more.
> > But we are also thinking about another change. In the system
> > crontab's, there are the users. We could split them with a delimiter like
> > : and allow to set the SE Linux user for this line. As long this isn't
> > used, the jobs run under system_u. With this change, we could clean up
> > the crond policy. I don't feel very good allowing all system cronjobs all
> > this. Also it would allow to get these policy parts back into the package
> > policies owning these jobs.
> Rather than specifying different SELinux users, why not just specify the
> domain for the system cron job?
Sorry, that's what I wanted to say. I thought one thing and wrote the other.

> Also, please note that the SELinux API is undergoing significant changes
> as part of integration into mainline 2.5, so the patches for the daemons
> and utilities are also being reworked.  You can get a reasonably current
> snapshot of the ongoing 2.5 work from http://www.nsa.gov/selinux/lk; in
> particular, see the API being exported by libselinux from
> selinux-2.5.tgz.
Russell already pointed out this to me. I'm currently working on a 2.5 test 
environment for me.

Regards
	Torsten

- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yRcmvxZktkzSmiwRAgSOAJ4mBVSNBnOIrPA5D6QX8G3r50Nu4gCffpkV
FmOQZezY8hpnn4kY3hE+bHk=
=MAVH
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
