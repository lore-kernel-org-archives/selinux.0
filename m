Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6IK3Pq007580
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 13:20:03 -0500
Received: from M4.sparta.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6IJGiG018967
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 18:19:18 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id kA6IK9Cl021935
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:20:09 -0600
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id kA6IK6Mm028007
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:20:08 -0600
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <126A50F9-399D-465B-A24C-D9F0AA6CF332@sparta.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: SE Linux <selinux@tycho.nsa.gov>
From: Todd Miller <Todd.Miller@sparta.com>
Subject: ANN: SEDarwin Release
Date: Mon, 6 Nov 2006 13:19:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The first widespread release of SEDarwin is now available for
download at http://sedarwin.org/

SEDarwin is a port of the TrustedBSD Mandatory Access Control
Framework to Apple's Darwin operating system platform, along with a
Type Enforcement policy based on SELinux.  SEDarwin is still
experimental, but currently allows the enforcement of mandatory
process and file protections under Darwin 8.7 (Mac OS X 10.4.7) on
Apple PowerPC hardware.

The October 31 snapshot includes the most recent SELinux kernel and
user space components available.  We are still working to adapt the
Treysys reference policy for Apple's System, but the kernel and user
space components are largely complete.


Todd Miller

SPARTA, Inc.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
