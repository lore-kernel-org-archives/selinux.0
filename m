Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26015
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 10:06:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1BF6gI00244
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 15:06:42 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h1BF6ef00240 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 15:06:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h1BF6bf01658
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 10:06:37 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h1BF6ba13639
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 10:06:37 -0500
Received: from redhat.com (redsox.boston.redhat.com [172.16.65.225])
	by mail.boston.redhat.com (8.11.6/8.11.6) with ESMTP id h1BF6Ws28164
	for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2003 10:06:36 -0500
Message-ID: <3E491178.8060403@redhat.com>
Date: Tue, 11 Feb 2003 10:06:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux newbie question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I notice a hole bunch of man pages in libsecure/man/man1.

ls
msgget.1   msgsid.1    semperm.1  semwrite.1  shmread.1
msgperm.1  msgwrite.1  semread.1  shmget.1    shmsid.1
msgread.1  semget.1    semsid.1   shmperm.1   shmwrite.1

These man pages get installed via selinux but I do not find
corresponding executables.  I did find some stuff in the test
directory that seems to correspond (Although the test programs
seem to have an "_s" attached.  Are these man pages of
test programs and therefore not intended to be installed?

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
