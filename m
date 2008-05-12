Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4CCRded016218
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 08:27:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4CCRcS3029525
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 12:27:39 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4CCRc8T002087
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 08:27:38 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4CCRbCw026570
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 08:27:38 -0400
Received: from localhost.localdomain (vpn-14-120.rdu.redhat.com [10.11.14.120])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m4CCRaFF012494
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2008 08:27:37 -0400
Message-ID: <48283791.80709@redhat.com>
Date: Mon, 12 May 2008 08:26:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think this is a bug in the kernel
References: <4824560E.8060500@redhat.com>
In-Reply-To: <4824560E.8060500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
| https://bugzilla.redhat.com/show_bug.cgi?id=445709
|
| libvirtd is clearly not ptracing the unconfined_t domain.  It is
| problably looking under /proc for some information about the app that is
| communicating with it.  It might be reading unconfined_t environment.  I
| am not sure, but we generate a ptrace and stop the app from working.  My
| only choice is to allow virtd to ptrace unconfined_t processes which is
| not a good idea.  This has to be fixes in the kernel.
|
| Dan

The policykit developer informs me that

"PolicyKit is trying to resolve the /proc/<pid>/exe link for the
connecting client."


- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgoN5EACgkQrlYvE4MpobMb1gCgj+r3ELhTfLWoPYB4RyCl8pHf
fuwAoLZdyFac/547Xn75l6R4TcB5kdHZ
=DzRx
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
