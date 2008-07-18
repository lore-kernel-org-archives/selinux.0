Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6I6fLmp005113
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 02:41:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6I6fLuG018208
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 06:41:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6I6fK0n023372
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 02:41:20 -0400
Received: from pobox.bne.redhat.com (pobox.bne.redhat.com [10.64.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6I6fJxN018611
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 02:41:20 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by pobox.bne.redhat.com (8.13.1/8.13.1) with ESMTP id m6I6fHBk017684
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 16:41:18 +1000
Message-ID: <48803B08.1030205@redhat.com>
Date: Fri, 18 Jul 2008 16:41:12 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux User Guide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Apologies if this doubles up for anyone.

My name is Murray McAllister and I am working as a content author for 
Red Hat. I have recently started a new project -- an SELinux User Guide 
-- with Daniel Walsh, Michael Smith, and a few other people from Red Hat.

There are a few SELinux books, but these are very technical. We want to 
create a guide that people with no previous SELinux experience can use, 
to allow them to do what they want without turning SELinux off.

I have started a rough information plan that includes the current 
schedule, information sources, and some ideas for the content that may 
be included. The information plan is located at 
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Information_Plan>. 
The main project page is located at 
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide>.

Among other things, we are going to try to cover the following topics 
from the current SELinux project documentation todo list 
(http://selinuxproject.org/page/Documentation_TODO):

* "Explain how to interpret an AVC message and how to get additional 
information via SYSCALL audit, including how to add a simple syscall 
audit filter to enable collection of PATH information".
* Document Confined Users".
* "Update FC5 FAQ".
* "Document the use of the mount command for overriding file context".
* "Describe Audit2allow and how it can just Fix the machine".
* "Update and organize the Fedora SELinux FAQ".

If anyone has any ideas about what they would like to see in the guide, 
or any corrections to the current topics we would like to include, 
please let us know. As well, user feedback and comments can be left at 
<https://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Feedback>. 
A Fedora account (https://admin.fedoraproject.org/accounts/) is required 
to use the Wiki - if you do not have one, please do not hesitate to mail 
me directly, or respond to this thread.

Thanks for your time,

Murray.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
