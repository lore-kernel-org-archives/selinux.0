Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9140fCm021001
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 00:00:41 -0400
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m913xc04024889
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 03:59:38 GMT
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: "Working with SELinux" sections
In-Reply-To: Your message of "Wed, 01 Oct 2008 10:19:15 +1000."
             <48E2C203.6020603@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <48D889A0.1010604@redhat.com> <9405.1222399818@turing-police.cc.vt.edu>
            <48E2C203.6020603@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1222833628_2952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 01 Oct 2008 00:00:28 -0400
Message-ID: <60227.1222833628@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1222833628_2952P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Oct 2008 10:19:15 +1000, Murray McAllister said:

> > Erm. What *exactly* produces that entry in /var/log/messages?
> Are you referring to SELinux denying access or setroubelshoot-server?
> > AVC stuff ends up in auditd.  Or is this just because the setroubleshoot
> > RPMs aren't *quite* as mandatory as you noted above, and I don't see those
> > messages because I don't have them installed *and enabled*? (Gotta watch
> > out for those pesky 'chkconfig off' ;)
> I thought I tried this before writing (thinking it only went into 
> audit.log if setroubleshoot-server was installed, otherwise it would go 
> to /var/log/messages). I will fix the text up to reflect this...

AVC's go into dmesg (and wherever your syslog dumps that) if auditd isn't running.

AVC's goes into audit.log if auditd *is* running.

If setroubleshoot is running, it reads audit.log and pretty-prints them
into the syslog.

> This is coming next in a separate chapter. Why can't you do much with 
> MCS if everyone is user_u? Doesn't it use the level, not the user/role/type?

Whether you're using either the level or the classification, you need to be
able to run users at different levels/classes for it to do any real good:

Consider:

User1 can read classes A, B, C.
User2 can read classes B, D, E.
User3 can read classes A, B, and E.

Wow.  That works pretty nice.

Now consider if you only have 1 defined user for people to run as:

User_u can read classes A, B, C.
User_u can read classes B, D, E.
User_u can read.. oh nevermind. ;)

So you need to be able to say "userid fred runs as user1, userid joe runs
as user2, userid dept-paperwork runs as user3/levelA, userid dept-admin runs
as user3/levelB", and so on....

The stock MCS policy provides enough user classes and levels to protect the
*system* from users - but you need to roll-your-own to protect user data to
a similar level.


--==_Exmh_1222833628_2952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFI4vXccC3lWbTT17ARAqUQAKCACpqjyOkJLNvOtECMAqsTMKYEOACg3y/w
Qkz4X+ew0Nj15z/5pI75LjI=
=e7ha
-----END PGP SIGNATURE-----

--==_Exmh_1222833628_2952P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
