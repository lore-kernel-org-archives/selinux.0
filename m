Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7606c1032623
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 01:00:07 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7606To006804
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 06:00:06 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7606M5004606
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 01:00:06 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7605fb027992
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 01:00:05 -0500
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7603RT024473
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 01:00:04 -0500
Message-ID: <4913D962.2070600@redhat.com>
Date: Fri, 07 Nov 2008 16:00:02 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SELinux User Guide: weekly report 20081107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This week:

* added "Port Numbers" to "How are Confined Services Running?" section.
* Started drafts for the "Troubleshooting" chapter: "What Happens when 
Access is Denied", "Top Three Causes of Problems", "Searching For and 
Viewing Denials", "Analyzing Denials", and "Fixing Problems".
* help from Dominick Grift. Created Red Hat Bugzilla #470398 
(restorecond not running by default; files in home dirs created with 
wrong types).

Created:
* Red Hat Bugzilla #469980 ("sealert -a /var/log/audit/audit.log" 
traceback when run as a non-root user).
* Red Hat Bugzilla #469989 (possible typo in sealert man page: "-b 
--password").

Next week:

* continue revisions.
* clean up for release with Fedora 10.

Thanks :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
