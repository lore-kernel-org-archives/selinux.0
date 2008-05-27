Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RI8MXB013229
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 14:08:22 -0400
Received: from mail.fluendo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RI8KVS024567
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 18:08:21 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id 9872D2500F8
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 20:08:19 +0200 (CEST)
Received: from deathwing00.fluendo.lan (core.fluendo.com [195.10.6.237])
	by mail.fluendo.com (Postfix) with ESMTP id 6B64A2500F5
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 20:08:19 +0200 (CEST)
Message-ID: <483C4E13.2030903@flumotion.com>
Date: Tue, 27 May 2008 20:08:19 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Quick question
References: <483C46FA.9030904@flumotion.com> <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> 
> If I understand correctly, you want to provide separation on a per-user
> basis (not just per-role) for NFS-mounted home directories.  I don't
> think that is realistically supportable by SELinux today, as 1) SELinux
> distinguishes based on security context/label, not uid, and 2) NFS
> doesn't support file labeling yet.  Sounds more like a job for 'normal
> permissions' i.e. discretionary access modes and/or ACLs.  There is
> ongoing work to support file labeling in NFSv4, but it is still in
> development, and even then, instantiating a separate role for every user
> is going to be problematic for any large number of users.
> 


And would there be a way to do something so that each user has a
different context? That is to say, I can assign a different context to
each user and have something easily maintained. Do you see that viable?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFIPE4SFq+8w76sCAARAjn1AJ9WOkv51PzZTueUkD8jCYAN1z/U8wCcDsyj
r2FnoXXpA0la49+Li2jAuK4=
=h8RH
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
