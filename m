Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03JqFXf023758
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:52:15 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03JpEqa002999
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:51:14 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k03JqDk4027781
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:52:13 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k03JqD108120
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:52:13 -0500
Received: from [172.16.83.104] (dhcp83-104.boston.redhat.com [172.16.83.104])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k03JqDxk030163
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:52:13 -0500
Message-ID: <43BAD603.5060209@redhat.com>
Date: Tue, 03 Jan 2006 14:52:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policy diffs, very large
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ftp://people.redhat.com/dwalsh/SELinux/policy-20060103.patch

Default type should not include :s0

Many changes to make MLS Policy work...

Added selinux policy man pages.

Updated mcs and mls file to match Old policy files

Update cvs policy to be able to read shadow and use kerberos.

Added boolean for shadow access.

Fixed kudzu for MLS and execmem changes.

Added java policy for execmem fixes.

Added locate, logwatch, prelink policies

Many minor changes...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
