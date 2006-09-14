Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EEtes3005791
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 10:55:40 -0400
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8EEsmg7017641
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 14:54:48 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8EEtbPk006684
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 10:55:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8EEtafG145636
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:55:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8EEta7Z011430
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 08:55:36 -0600
Message-ID: <45096D60.5010902@us.ibm.com>
Date: Thu, 14 Sep 2006 09:55:28 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: lspp-list <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
Subject: MAC_POLICY_LOAD on unloading module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey Steve,

on semodule -r module, the audit message you get (MAC_POLICY_LOAD) has 
the exact same message as the audit message you get on semodule -i 
module. That is, "policy loaded". Shouldn't there be a different between 
module load and module unload?

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
