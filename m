Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1397653028720
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 04:07:07 -0500 (EST)
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13979f1024165
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 09:07:09 GMT
Received: from localhost (pD953A6C7.dip.t-dialin.net [217.83.166.199])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.seekline.net (Postfix) with ESMTP id A55E98E9B6
	for <selinux@tycho.nsa.gov>; Thu,  3 Feb 2005 10:07:00 +0100 (CET)
Date: Thu, 3 Feb 2005 10:05:38 +0100
From: Stefan SF <stefan@sf-net.com>
To: selinux@tycho.nsa.gov
Subject: policy for a cron-job
Message-ID: <20050203090538.GC17286@crux.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

since a couple of days I'm trying to create a policy for a cron-job. But
every time system_crond_t won't change its context to mypackage_t.
Here is my policy maybe someone can give me a hind?

daemon_domain(gentoo_rsync_mirror)

type gentoo_rsync_mirror_log_t, file_type, sysadmfile;

role system_r types gentoo_rsync_mirror_t;
role sysadm_r types gentoo_rsync_mirror_t;

ifdef(`crond.te', `
system_crond_entry(gentoo_rsync_mirror_exec_t, gentoo_rsync_mirror_t)
')


Through this policy I wanted to write the next allow statements but the
only thing I get from the avc is this one:

audit(1107421381.490:0): avc:  denied  { execute_no_trans } for
pid=14902 exe=/bin/bash path=/opt/gentoo-rsync/rsync-gentoo-portage.sh
dev=hda8 ino=730082 scontext=system_u:system_r:system_crond_t
tcontext=system_u:object_r:gentoo_rsync_mirror_exec_t tclass=file

I don't unterstand the problem of my policy file because I have told the
cron entry stuff. Any ideas?

-Stefan

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCAeliUEn3BeoPvtwRAg+TAJ954CLjpJR88hzHZkJwjTddT+6UlQCeJzxE
aG0GRYzEyxtCtjllrLa3yRw=
=oPeW
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
