Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1PFMlRb000362
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 10:22:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1PFMkQQ022980
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 15:22:46 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i1PFMjP0022975 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 15:22:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i1PFMjb08200
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 10:22:45 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1PFMii06809
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 10:22:45 -0500
Received: from redhat.com (celtics.boston.redhat.com [172.16.65.39])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i1PFMimk005930
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 10:22:44 -0500
Message-ID: <403CBDC4.30100@redhat.com>
Date: Wed, 25 Feb 2004 10:22:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Suggested change to setfiles interface.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I find it curios that the setfiles interface works in recursive mode by 
default.  As we have been trying to get the install to handle labeling 
the file system, several files had to be labeled in the installer 
including /.  The only way to do this was to pipe
echo / | setfiles -s file_context

Looking into this I found this curious that this works differently then
setfiles file_context  /

I would like to see these work consistantly and us add a recursive on 
non recursive switch to setfiles. 

So

setfiles -R file_contexts /
would implement the current behavior

setfiles file_contexts /
would just relabel /.

Dan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
