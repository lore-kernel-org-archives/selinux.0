Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOF22Rb008246
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 10:02:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAOF21qY028044
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 15:02:01 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id hAOF200o028041 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 15:02:00 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id hAOF20H27338
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 10:02:00 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id hAOF1xw12041
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 10:01:59 -0500
Received: from redhat.com (celtics.boston.redhat.com [172.16.65.39])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id hAOF1vDI017336
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 10:01:58 -0500
Message-ID: <3FC21D65.5070803@redhat.com>
Date: Mon, 24 Nov 2003 10:01:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: How to handle lots of executables  buried in /usr
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am seeing lots of errors in policy because of shell scripts and exes 
that are installed in subdirectories of /usr being marked as  usr_t 
instead of bin_t .  What do you guys think of adding a script to be 
executed after make relabel that would find these files and change their 
context to bin_t.

find /usr -perm +111 --context system_u:object_r:usr_t -type f -exec 
chcon \
system_u:object_r:bin_t {} ; -print


Is this a bad idea?  I do notice that their are a lot of files marked 
executables by their install that are really not executable, but this 
would clean up several failures untill the package installs are cleaned up.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
