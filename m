Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0FL4ZsN029829
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 16:04:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0FL4Wd5001713
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 16:04:32 -0500
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com
 [10.19.60.53])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 s0FL4VdK002174
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 16:04:32 -0500
Message-ID: <52D6F7DF.2000603@redhat.com>
Date: Wed, 15 Jan 2014 16:04:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: As we move to use Linux Containers User Namespace
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I think we need the kernel to start checking container Capabilities rather
then system capabilities.

I would like to be able to say something like

allow svirt_lxc_net_t self:nscapability sys_admin;

This way we can use MAC to better control break out of user namespace.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLW998ACgkQrlYvE4MpobP6IgCglpmgF8XKjr1W1xzPU6eGU6k+
h8EAniQwwEhMAOeAy4e1NUw/8o2h/oWs
=g8UL
-----END PGP SIGNATURE-----
