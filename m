Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FK3GrT020348
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 16:03:16 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FK2KHF010058
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 20:02:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i8FK3GSR007495
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 16:03:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8FK3Gr16601
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 16:03:16 -0400
Message-ID: <4148A003.6080309@redhat.com>
Date: Wed, 15 Sep 2004 16:03:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
   "ivg2@cornell.edu" <"Ivan Gyurdiev"@redhat.com>
Subject: SELinux policy discussion.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev (ivg2@cornell.edu) Has reported a bug that several files 
in /etc/ are world readable and yet SELinux is
preventing them from being read.  Should we add usercanread attribute to 
most of these files (/etc/exports, /etc/yp.servers) ?
Any file in /etc/ that has a security_context other than etc_t and 
doesn't have an attribute of usercanread, is a problem.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=129584


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
