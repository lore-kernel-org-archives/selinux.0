Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n05Jx1Cn007432
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 14:59:01 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n05JuLub017892
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 19:56:21 GMT
Message-ID: <49626681.5050004@redhat.com>
Date: Mon, 05 Jan 2009 14:58:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: semodule patch to use new semanage interfaces
References: <49145394.3050806@redhat.com> <496264FE.3000802@manicmethod.com>
In-Reply-To: <496264FE.3000802@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> Allows semodule to read bzip compressed policy packages directly.

> I'm finally looking at these (sorry it took so long)..

> I thought one part of it was suppose to make hard links to files if you
> install but after merging this patch and the compression support I try
> semodule -i /usr/share/selinux/targeted/somepolicy.pp.bz2 (I'm on F10
> and they are already bzip'd) and instead of making a hard link to the
> bz2 it looks like it writes the uncompressed file to
> /etc/selinux/targeted/modules/active/modules. Am I misunderstanding the
> intention of these patches?

Originally this was the intention but it was wrong.  The problem is the
file context would start to get screwed up every where and we end up
with the /etc/selinux/targeted/modules/active/ directory looking like a
patchwork of labels.

So the patch makes a compressed copy whether or not the file is
originally compressed in the new location.

It does use the hard links for creating the snapshot directory though.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkliZoEACgkQrlYvE4MpobMAQgCfdlq4J4KO0/wejYLYkVUhdf4K
Yn8An25Mf2zzbcIbNRUDOw09iutxfFyi
=ruHv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
