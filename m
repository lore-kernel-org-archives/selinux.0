Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k56Hr0ae026593
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 13:53:00 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k56HqxvL023444
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 17:52:59 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k56HqxR7018756
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 13:52:59 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k56HqwJv014396
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 13:52:58 -0400
Received: from [172.16.50.200] (vpn50-200.rdu.redhat.com [172.16.50.200])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k56HqwuF024865
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 13:52:58 -0400
Message-ID: <4485C100.4030805@redhat.com>
Date: Tue, 06 Jun 2006 13:53:04 -0400
From: Chuck Mead <csm@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: permissions on /proc/self/attrib/current
Content-Type: multipart/mixed;
 boundary="------------030008020509060200080609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030008020509060200080609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The file /proc/self/attrib/current is world read and write. Is this
correct? Why does it need world read and write?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEhcEAZfy0juH51WsRAsXBAKCgFqHPpEfK5NSP5o/sZGqcbWBnCwCgjQZD
4kXDs9cr3Dax9ygN5BZ/x0I=
=cz5D
-----END PGP SIGNATURE-----

--------------030008020509060200080609
Content-Type: text/x-vcard; charset=utf-8;
 name="csm.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="csm.vcf"

begin:vcard
fn:Chuck Mead
n:Mead;Chuck
org:Red Hat, Inc.;GPS,
adr:;;1801 Varsity Drive;Raleigh;NC;27606;USA
email;internet:csm@redhat.com
title:Consultant
tel;cell:919-621-0605
note;quoted-printable:You can have peace. Or you can have freedom. Don=E2=80=99t ever count onh=
	aving both at once. - Lazarus Long
x-mozilla-html:FALSE
url:http://redhat.com
version:2.1
end:vcard


--------------030008020509060200080609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
