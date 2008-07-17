Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HGUtVD023670
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 12:30:55 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6HGUsUv026046
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 16:30:55 GMT
Received: by ug-out-1314.google.com with SMTP id m3so815863ugc.15
        for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 09:30:53 -0700 (PDT)
Subject: Re: Patch: selinux-policy: inconsistency: logging_send_syslog_msg
	is not optional policy.
From: Dominick Grift <domg472@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <487F6B54.3040909@redhat.com>
References: <1216307585.11883.17.camel@sulphur.notebook.internal>
	 <487F6B54.3040909@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GVlJEJA/v1BDHZyIAHgz"
Date: Thu, 17 Jul 2008 18:30:51 +0200
Message-Id: <1216312251.11883.30.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GVlJEJA/v1BDHZyIAHgz
Content-Type: multipart/mixed; boundary="=-POD3MuqpzpAUFRPtiul8"


--=-POD3MuqpzpAUFRPtiul8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-17 at 11:55 -0400, Daniel J Walsh wrote:

> Shouldn't all of kernel/system be required, with the exception of
> unconfined?

That is true. You cannot unconditionally require something from a higher
layer.

The patch that i included has a style error in the sysstat module
however. logging_send_syslog_msg() should be under locallogin_use_fds()
i believe. Attached is a patch for sysstat to resolve this issue.

--=-POD3MuqpzpAUFRPtiul8
Content-Disposition: attachment;
	filename*0=sysstat_logging_send_syslog_message_under_locallogin_use_fds.;
	filename*1=patch
Content-Type: text/x-patch;
	name*0=sysstat_logging_send_syslog_message_under_locallogin_use_fds.patc;
	name*1=h; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IC9ob21lL2RvbWc0NzIvV29ya3NwYWNlL3JlZnBvbGljeV90cnVuay9wb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy9zeXNzdGF0LnRlDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gL2hvbWUvZG9tZzQ3Mi9X
b3Jrc3BhY2UvcmVmcG9saWN5X3RydW5rL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3N5c3N0YXQu
dGUJKHJldmlzaW9uIDI3NjEpDQorKysgL2hvbWUvZG9tZzQ3Mi9Xb3Jrc3BhY2UvcmVmcG9saWN5
X3RydW5rL3BvbGljeS9tb2R1bGVzL3NlcnZpY2VzL3N5c3N0YXQudGUJKHdvcmtpbmcgY29weSkN
CkBAIC01OCw2ICs1OCw4IEBADQogDQogbG9jYWxsb2dpbl91c2VfZmRzKHN5c3N0YXRfdCkNCiAN
Citsb2dnaW5nX3NlbmRfc3lzbG9nX21zZyhzeXNzdGF0X3QpDQorDQogbWlzY2ZpbGVzX3JlYWRf
bG9jYWxpemF0aW9uKHN5c3N0YXRfdCkNCiANCiBzeXNhZG1fZG9udGF1ZGl0X2xpc3RfaG9tZV9k
aXJzKHN5c3N0YXRfdCkNCkBAIC02NSw3ICs2NywzIEBADQogb3B0aW9uYWxfcG9saWN5KGANCiAJ
Y3Jvbl9zeXN0ZW1fZW50cnkoc3lzc3RhdF90LHN5c3N0YXRfZXhlY190KQ0KICcpDQotDQotb3B0
aW9uYWxfcG9saWN5KGANCi0JbG9nZ2luZ19zZW5kX3N5c2xvZ19tc2coc3lzc3RhdF90KQ0KLScp
DQo=


--=-POD3MuqpzpAUFRPtiul8--

--=-GVlJEJA/v1BDHZyIAHgz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh/c7oACgkQL00QnzrVtly/HQCeLpDGRpRxQUPzIST495kP0skA
oIkAnjzBYXEWITET7KR8YkfoMDFuKYfE
=H9fV
-----END PGP SIGNATURE-----

--=-GVlJEJA/v1BDHZyIAHgz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
