Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1BE7CTC011970
 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2014 09:07:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s1BE79E9003416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2014 09:07:10 -0500
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com
 [10.19.60.53])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 s1BE77fX004808
 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2014 09:07:08 -0500
Message-ID: <52FA2E8A.9040904@redhat.com>
Date: Tue, 11 Feb 2014 15:07:06 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This past week I was doing a demo of how to build an Userspace Object
 Manager for firewalld
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I had a problem where I wanted to allow a cupsd_t to be able to open a
particular port at the firewall, say the ipp_port_t port.

sepolicy network -t ipp_port_t
ipp_port_t: tcp: 631,8610-8614
ipp_port_t: udp: 631,8610-8614


The problem, cups is sending across and open tcp/631 and I need firewalld to
check something like

allow cupsd_t ipp_port_t:tcp_netfilter open;

The only way for firewalld to figure out what type port tcp/361 is assigned
to, was to load the sepolicy framework and read in the currently loaded policy.

I think we should add an interface to the /sys/fs/selinux that would take a
port number and a protocol and return a process_type.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL6LooACgkQrlYvE4MpobObLgCcCVn7A5N1oR1FzkWu4nxwsRB3
p/YAoKHmGISKqsJQySGZVsdPSm+lEF+Z
=jwBl
-----END PGP SIGNATURE-----
