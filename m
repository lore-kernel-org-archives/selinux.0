Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2UJpEFb000886
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 14:51:14 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2UJnTwL018086
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 19:49:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k2UJpDcj005275
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 14:51:13 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.11.6) with ESMTP id k2UJpCNU004477
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 14:51:12 -0500
Message-ID: <442C36AF.4090001@redhat.com>
Date: Thu, 30 Mar 2006 14:51:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: AVC Decision Tree.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://fedoraproject.org/wiki/SELinux/Troubleshooting/AVCDecisions#preview

Trying to build a analysys tool to be able to translate avc messages 
into possible boolean/file_context solutions.

The idea is that we can look at the AVC messages that are generated and 
figure out what the servers were trying to do.  Then we can give some 
advise to the administrator on the corrective measures.  So what we are 
looking for are expected code paths where there is a file context of 
boolean available.

Additional suggestions are welcome. 


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
