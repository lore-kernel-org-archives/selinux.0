Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBJMEfj0020946
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 17:14:41 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBJMFHlj001254
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 22:15:17 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kBJMFGeq001900
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 17:15:16 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kBJMFGP7023353
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 17:15:16 -0500
Message-ID: <45886451.8070601@redhat.com>
Date: Tue, 19 Dec 2006 17:14:41 -0500
From: Karl MacMillan <kmacmill@redhat.com>
MIME-Version: 1.0
To: fedora-devel-list@redhat.com, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Fast User Switching and security / SELinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Reading through http://fedoraproject.org/wiki/Desktop/FastUserSwitching, 
I had two questions.

1) Any work ongoing to look at the security of this solution. For 
example, the proposed fix for device ownership allows multiple users to 
use devices simultaneously. This could have serious security 
implications (e.g., monitoring VIOP calls made by another user).

2) Some work will likely be needed for this to work well with SELinux, 
particularly as we are looking at locking down user apps as an option in 
the future (evolution, firefox, etc.). This may also include XACE 
(http://blogs.sun.com/alanc/entry/xace_merged_into_xorg_for - just 
ignore the trusted extensions notes). Any current plans on tackling this?

Thanks - Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
