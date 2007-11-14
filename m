Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAEL4E6x029501
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 16:04:14 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAEL4DYJ023980
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 21:04:13 GMT
Message-ID: <473B62CA.30102@redhat.com>
Date: Wed, 14 Nov 2007 16:04:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: tolliver@dal.ca
CC: selinux@tycho.nsa.gov
Subject: Re: Apache problem with Selinux
References: <473AE81D.7080500@dal.ca>
In-Reply-To: <473AE81D.7080500@dal.ca>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

tolliver@dal.ca wrote:
> 
> Hello,
> 
> I have setup Red Hat Enterprise Linux with SELinux enforced.
> 
> When I try to start apache, I get and error *[FAILED]*.
> 
> Apache will load fine when I run *setenforce 0*. I am new to
> SELinux. What exactly can I do to get it running under SELinux.
> 
> 
> 
> Thanks ever so much!
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
WHat version of RHEL are you using?
Do you see avc messages in /var/log/messages or /var/log/audit/audit.log


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHO2LKrlYvE4MpobMRAp26AKC+ldtUvwW/WLUKGw7Rh+63GV9hPgCg3fGy
RD/rH7ZINj4Hjr9A2DekKJU=
=wSz9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
