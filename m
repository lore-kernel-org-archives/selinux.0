Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2BCNBvs004225
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 07:23:11 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2BCLaqf029227
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 12:21:36 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k2BCNAsK022484
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 07:23:10 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k2BCNA101693
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 07:23:10 -0500
Received: from [172.16.50.11] (vpn50-11.rdu.redhat.com [172.16.50.11])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k2BCN8Wr014601
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 07:23:09 -0500
Message-ID: <4412C109.1040906@redhat.com>
Date: Sat, 11 Mar 2006 07:22:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: We need a tool to extract the file context contents out of a policy
 package.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If we had this we could do something like

fixfiles -P mypolicy.pp

And it would restorecon over the file context.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
