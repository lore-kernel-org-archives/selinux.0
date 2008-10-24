Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9O7ApIW027665
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 03:10:51 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9O79Oaq016917
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 07:09:25 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9O7Aon9011154
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 03:10:50 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9O7AoM1022334
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 03:10:50 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m9O7Am3D010664
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 03:10:49 -0400
Message-ID: <490174F7.1060405@redhat.com>
Date: Fri, 24 Oct 2008 17:10:47 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SELinux User Guide: weekly report 20081024
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This week:

* Continued revisions for "Mounting File Systems".
* Drafts to "Confining Users" (posting next week).
* Added "The file_t and default_t Types" section.
* Samba mount testing. Created Red Hat BZ #468315 (Wrong suggestion when 
export is labeled default_t type).
* Context mounts (NFS) testing in "/etc/fstab": Created Red Hat BZ 
#468331 ("service netfs restart" causes errors and denials when 
"/etc/fstab" has context mounts).

Next week:

* Finish "Confining Users" sections.
* Start troubleshooting sections.

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
