Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13599
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 07:59:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h14CwxI13499
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 12:58:59 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h14Cwwf13495 for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 12:58:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h14Cwwf28255
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 07:58:58 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h14Cwwa11634
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 07:58:58 -0500
Received: from redhat.com (dwalsh.cipe.redhat.com [10.0.2.138])
	by mail.boston.redhat.com (8.11.6/8.11.6) with ESMTP id h14Cwvs12001
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 07:58:57 -0500
Message-ID: <3E3F72AE.1070503@redhat.com>
Date: Tue, 04 Feb 2003 02:58:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux question?
References: <200301271320.IAA05862@moss-shockers.ncsc.mil> <200302012351.48969.russell@coker.com.au>
In-Reply-To: <200302012351.48969.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why are certain applications (ls, cp, cd) ported to use SELinux with the 
standard names, while others
(spasswd, schfn) have a prefix added?  

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
