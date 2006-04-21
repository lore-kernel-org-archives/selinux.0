Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3LHSmCi026387
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 13:28:48 -0400
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3LHSlUq028029
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 17:28:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 8D03BB04DE
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 18:28:45 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10077-19 for <selinux@tycho.nsa.gov>;
 Fri, 21 Apr 2006 18:28:43 +0100 (BST)
Received: from [192.168.0.6] (host-87-74-41-35.bulldogdsl.com [87.74.41.35])
	by mail.nagafix.co.uk (Postfix) with ESMTP id AD17CAEFD7
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 18:28:43 +0100 (BST)
Subject: network packets have become unlabeled_t
From: Antoine Martin <antoine@nagafix.co.uk>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ui3K3xAWS/Gi/WWKrX5a"
Date: Fri, 21 Apr 2006 18:29:47 +0100
Message-Id: <1145640587.11012.10.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Ui3K3xAWS/Gi/WWKrX5a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi list,

Using recent kernels (started around 2.6.16) I can't use the network in
enforcing mode because all the packets (in and out) are unlabeled.
ie with ssh:
audit(1145733148.799:164): avc:  denied  { recvfrom } for
scontext=3Dsystem_u:system_r:sshd_t tcontext=3Dsystem_u:object_r:unlabeled_=
t
tclass=3Dassociation

audit2allow would like me to add:
allow mysqld_t unlabeled_t:association { recvfrom sendto };
allow named_t unlabeled_t:association { recvfrom sendto };
allow sshd_t unlabeled_t:association { recvfrom sendto };
(and so on)

Where is this coming from? Have I missed an option for labeling network
interfaces? If so, where? SECURITY_NETWORK is set.

I have done make clean; make reload;
policy.conf does contain things like:
type ssh_port_t, port_type, reserved_port_type;

I'm stuck.

Thanks
Antoine

--=-Ui3K3xAWS/Gi/WWKrX5a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBESRaLrTBrLRG7eDcRAoadAKC8Xrx0ZMaa7H6zmOU6lYTgAEIbFQCfRNE9
kv7lmNV289br5qlIdrHXGM0=
=0JF2
-----END PGP SIGNATURE-----

--=-Ui3K3xAWS/Gi/WWKrX5a--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
