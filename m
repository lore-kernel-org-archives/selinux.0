Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14Fqqw4008613
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 10:52:52 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14Fqqh9004841
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 15:52:52 GMT
Message-ID: <47A734C4.9080702@redhat.com>
Date: Mon, 04 Feb 2008 10:52:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Seth D. Guikema" <sguikema@jhu.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: reindexing time for SELinux?
References: <47A71F79.1020300@jhu.edu>
In-Reply-To: <47A71F79.1020300@jhu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Seth D. Guikema wrote:
> I am trying to set up SELinux on my Fedora Core 7 workstation. I am
> using the pre-installed GUI SELinux configuration tool in FC7. I
> selected a targeted set-up. I was warned that the workstation would need
> to reindex the files at the next reboot and that this would take a
> while. I clicked ok. I rebooted the workstation Saturday morning at
> about 10am. It is still unresponsive (and not available for remote
> connections) and working hard this morning, almost 48 hours later. How
> long should reindexing take? The workstation is new. It has 2 1TB disks
> (RAID mirrored), but there isn't much on them yet - perhaps 30MB plus
> the OS and other programs installed by the manufacturer (ASL). Does
> reindexing really take this long? This is my first attempt at SELinux,
> and any help is appreciated. Thank you.
> 
> Sincerely,
> Seth Guikema
> 
It should not take more then 10 minutes.  I think the process is hung.
I would force a reboot.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkenNMQACgkQrlYvE4MpobP5gQCgnTkOk0fgAZ9oNBo2fwXneMcb
7+EAnRtxxhzYQAngiK0O0LNzU1cBRH7L
=XVH5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
