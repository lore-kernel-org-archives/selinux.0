Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3MJjLac004598
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2008 15:45:21 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3MJjKHV018228
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2008 19:45:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m3MJgDXr020886
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2008 15:42:13 -0400
Message-ID: <480E3F8F.3070502@redhat.com>
Date: Tue, 22 Apr 2008 15:42:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: port numbers for sctp support?
References: <20080422182103.GJ7449@angus.ind.WPI.EDU>	<480E3ABF.2020109@redhat.com> <20080422192552.GM7449@angus.ind.WPI.EDU>
In-Reply-To: <20080422192552.GM7449@angus.ind.WPI.EDU>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chuck Anderson wrote:
> On Tue, Apr 22, 2008 at 03:21:35PM -0400, Daniel J Walsh wrote:
>> TCP Port 22 is labeled ssh_port_t.
> 
> For TCP, yes.  I need SCTP, a different IP protocol.
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list

I have no idea if this is handled  SCTP  Are you seeing AVC messages?

You might want to bring this up for discussion on Developer list.

<selinux@tycho.nsa.gov>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgOP48ACgkQrlYvE4MpobNDdQCgsr4usMZttCbcaq+SyuMCHav1
H58AoJ+wWJqxTKvkbyq37/cGVryzah/F
=ibh6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
