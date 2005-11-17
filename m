Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAHDPIMA009184
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 08:25:18 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAHDHawh017778
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 13:17:36 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jAHDHbOZ006744
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 08:17:37 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jAHDHaV29168
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 08:17:36 -0500
Received: from [172.16.50.51] (vpn50-51.rdu.redhat.com [172.16.50.51])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id jAHDHaUq004762
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 08:17:36 -0500
Message-ID: <437C82F4.2050204@redhat.com>
Date: Thu, 17 Nov 2005 08:17:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: New version of reference policy on people.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ftp://people.redhat.com/dwalsh/SELinux/Fedora/selinux-policy-targeted-2.0.1-2.noarch.rpm

Fixes gdm problems and eliminates the the transition from 
unconfined_t->shell_exec_t->rpm_script_t.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
