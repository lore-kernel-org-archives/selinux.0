Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6KEYXQT001268
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 10:34:33 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6KEZL4Q013655
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 14:35:21 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6KEYW9M022354
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 10:34:32 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6KEYUD4014390
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 10:34:31 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6KEYUm2000880
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 10:34:30 -0400
Message-ID: <4A648075.3090402@redhat.com>
Date: Mon, 20 Jul 2009 10:34:29 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: adding human understandable, and translatable description support
 to selinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm currently working on improving the gui tools for managing selinux(the ones that ship with fedora). One of the things that has already come up is a need for more plain English descriptions of various policy components. Currently this capability exists in the policy.xml for booleans however this file is not rebuilt at policy compile time so changes and even the installation of modules is not reflected in this. I'd like to propose that a documentation section be added to each policy directory, "/etc/selinux/<policyname>/docs/". This would contain locale specific documentation files that would store information in key-value pairs. ie: {users.guest_u:"A guest user who can only (etc)"}. An interface to this store would be built for libselinux and support for setting and getting documentation would be added to some of the command line tools or given it's own tool. Additionally a method would need to be created for policy authors to define descriptions in there policy (similar to
 the policy.xml method)
Before I get started on this I wanted to see what the general opinion on both the need and the best implementation would be. So what do you guys think?

Christopher Pardy <cpardy@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
