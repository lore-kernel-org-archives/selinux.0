Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAEKumF3009322
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 15:56:48 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAEKulJu005175
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 20:56:47 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mAEKuliC004421
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 15:56:47 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mAEKujjD006703
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 15:56:46 -0500
Received: from localhost.localdomain (vpn-10-38.bos.redhat.com [10.16.10.38])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mAEKuivO032671
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 15:56:45 -0500
Message-ID: <491DE60C.3040205@redhat.com>
Date: Fri, 14 Nov 2008 15:56:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This policy causes checkmodule to segfault.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

policy_module(test, 1.0)

gen_require(`
  type a_t;
')
type b_t alias a_t;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkd5gwACgkQrlYvE4MpobMCXgCfSDZV7JhIOnAvb+akOXGDdCaE
Al4AnAyNBj9oCXwxyDaxsO+KeQ9It2xG
=YtwJ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
