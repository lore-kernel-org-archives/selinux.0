Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGCxR11001199
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 07:59:27 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAGCxPKK009675
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 12:59:26 GMT
Date: Fri, 16 Nov 2007 13:59:23 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org, Martin Orr <martin@martinorr.name>
Subject: [martin@martinorr.name: [DSE-Dev] /selinux getattr messages]
Message-ID: <20071116125923.GA25905@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I'm trying to stabilize refpolicy-20070928 on Debian Etch.

Repository with some updated selinux packages will be available soon.
I took packages from Sid and updated these with 20070928 upstream
releases.

I'm SELinux beginer, but my intention is to understand the SELinux
finally :) and run targeted and possibly strict policies in production
environment on Debian.

Currently I'm booting Xen DomU Debian Etch in permissive mode.

There are two audit messages, and I found solution (attached) in
selinux-devel@lists.alioth.debian.org.

audit(1195215260.590:3): avc:  denied  { getattr } for  pid=760
comm="mount" name="/" dev=selinuxfs ino=475
scontext=system_u:system_r:mo
unt_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem

audit(1195215263.626:6): avc:  denied  { getattr } for  pid=1017
comm="swapon" name="/" dev=selinuxfs ino=475 scontext=system_u:system_r:
fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem


So after insertion

selinux_get_fs_mount(fsadm_t)
-> ./policy/modules/system/fstools.te

selinux_get_fs_mount(mount_t)
-> ./policy/modules/system/mount.te

both messages dismiss.

Is such solution ok and acceptable upstream (conditionaly for
Debian distro or so)?

Regards
-- 
Zito

--RnlQjJ0d97Da+TV1
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org>
Envelope-to: zito@localhost
Delivery-date: Mon, 25 Jun 2007 08:53:53 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=bobek.localdomain)
	by bobek.localdomain with esmtp (Exim 4.63)
	(envelope-from <selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org>)
	id 1I2iQO-0001za-5J
	for zito@localhost; Mon, 25 Jun 2007 08:51:48 +0200
Received: from sprg11.i.cz [192.168.30.71]
	by bobek.localdomain with IMAP (fetchmail-6.3.6)
	for <zito@localhost> (single-drop); Mon, 25 Jun 2007 08:51:48 +0200 (CEST)
Received: from sprg11.ad.i.cz ([192.168.30.71]) by sprg13.ad.i.cz with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 23 Jun 2007 13:40:54 +0200
Received: from ns1.i.cz ([192.168.24.101]) by sprg11.ad.i.cz with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 23 Jun 2007 13:40:53 +0200
Received: from localhost (localhost [127.0.0.1])
	by ns1.i.cz (Postfix) with ESMTP id 2EF24FE85
	for <vaclav.ovsik@i.cz>; Sat, 23 Jun 2007 13:40:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on ns1.i.cz
X-Virus-Scanned: Debian amavisd-new at ns1.i.cz
X-Spam-Score: -2.464
X-Spam-Level: 
X-Spam-Status: No, score=-2.464 required=3.5 tests=[BAYES_00=-2.599,
	FORGED_RCVD_HELO=0.135]
Received: from ns1.i.cz ([127.0.0.1])
	by localhost (ns1.i.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxHwBK6bZpLj for <vaclav.ovsik@i.cz>;
	Sat, 23 Jun 2007 13:40:13 +0200 (CEST)
Received: from vidle.i.cz (brana.i.cz [192.168.1.10])
	by ns1.i.cz (Postfix) with ESMTP id 330B3FE87
	for <vaclav.ovsik@i.cz>; Sat, 23 Jun 2007 13:39:58 +0200 (CEST)
Received: from alioth.debian.org (alioth.debian.org [217.196.43.134])
	by vidle.i.cz (Postfix) with ESMTP id 1D4471CC07
	for <vaclav.ovsik@i.cz>; Sat, 23 Jun 2007 13:39:58 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=alioth.debian.org)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org>)
	id 1I23y9-00082X-Gg
	for vaclav.ovsik@i.cz; Sat, 23 Jun 2007 11:39:57 +0000
Received: from smithers.debconf.org ([82.195.75.76])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <martin@martinorr.name>) id 1I23y3-000826-0z
	for selinux-devel@lists.alioth.debian.org;
	Sat, 23 Jun 2007 11:39:56 +0000
Received: from homer.dc7.debconf.org (unknown [129.215.255.137])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client CN "homer.dc7.debconf.org",
	Issuer "Certificate Authority - Email" (verified OK))
	by smithers.debconf.org (Postfix) with ESMTP id 63E0222622B
	for <selinux-devel@lists.alioth.debian.org>;
	Sat, 23 Jun 2007 11:39:50 +0000 (UTC)
Received: from [10.7.10.37] (helo=wireless-10-37.internal.dc7.debconf.org)
	by homer.dc7.debconf.org with esmtpa (Exim 4.63)
	(envelope-from <martin@martinorr.name>) id 1I23y1-0005TB-PX
	for selinux-devel@lists.alioth.debian.org;
	Sat, 23 Jun 2007 12:39:49 +0100
Received: from [127.0.0.1] (localhost [::ffff:127.0.0.1])
	by tiberius.martinorr.name with esmtp; Sat, 23 Jun 2007 12:39:33 +0100
	id 00000000000C61F5.00000000467D0676.00002232
Message-ID: <467D065F.6000109@martinorr.name>
Date: Sat, 23 Jun 2007 12:39:11 +0100
From: Martin Orr <martin@martinorr.name>
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070621)
Mime-Version: 1.0
To: selinux-devel@lists.alioth.debian.org
X-Enigmail-Version: 0.95.0
Subject: [DSE-Dev] /selinux getattr messages
X-BeenThere: selinux-devel@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: SELinux packaging and policy development
	<selinux-devel.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/selinux-devel>,
	<mailto:selinux-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/selinux-devel>
List-Post: <mailto:selinux-devel@lists.alioth.debian.org>
List-Help: <mailto:selinux-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/selinux-devel>,
	<mailto:selinux-devel-request@lists.alioth.debian.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6287118005055585529=="
Mime-version: 1.0
Sender: selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org
Errors-To: selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: selinux-devel-bounces+vaclav.ovsik=i.cz@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
X-OriginalArrivalTime: 23 Jun 2007 11:40:53.0563 (UTC) FILETIME=[5B0738B0:01C7B58B]

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============6287118005055585529==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_tiberius-8754-1182598782-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tiberius-8754-1182598782-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am using the targeted policy in permissive mode.  During boot I get the=

following messages:
audit(1182511335.252:36): avc:  denied  { getattr } for  pid=3D1249
comm=3D"mount" name=3D"/" dev=3Dselinuxfs ino=3D318
scontext=3Dsystem_u:system_r:mount_t:s0
tcontext=3Dsystem_u:object_r:security_t:s0 tclass=3Dfilesystem
audit(1182511346.457:47): avc:  denied  { getattr } for  pid=3D1503
comm=3D"swapon" name=3D"/" dev=3Dselinuxfs ino=3D318
scontext=3Dsystem_u:system_r:fsadm_t:s0
tcontext=3Dsystem_u:object_r:security_t:s0 tclass=3Dfilesystem
audit(1182511347.644:48): avc:  denied  { getattr } for  pid=3D1570
comm=3D"iptables" name=3D"/" dev=3Dselinuxfs ino=3D318
scontext=3Dsystem_u:system_r:iptables_t:s0
tcontext=3Dsystem_u:object_r:security_t:s0 tclass=3Dfilesystem

These come because libblkid and iptables are both linked against libselin=
ux,
which locates the selinux mount point in a constructor.  When this was
introduced in libselinux, the selinux_get_fs_mount interface was added to=

the reference policy to allow this.  So mount.te should gain
selinux_get_fs_mount(mount_t)
and fstools.te should gain
selinux_get_fs_mount(fsadm_t)

So far as I can see iptables has no need to be linked against libselinux,=

but I will check further.

--=20
Martin Orr




--=_tiberius-8754-1182598782-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGfQZwZ6a/BjxtAMARAgMAAJ9BRohF8Jr2OoijjtAWXbrgXb7oMgCgkfft
QL182WLRsFbUE6bw1B1/XOs=
=Irx0
-----END PGP SIGNATURE-----

--=_tiberius-8754-1182598782-0001-2--


--===============6287118005055585529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
SELinux-devel mailing list
SELinux-devel@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/selinux-devel
--===============6287118005055585529==--


--RnlQjJ0d97Da+TV1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
