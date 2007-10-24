Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9OG4QW8025534
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 12:04:26 -0400
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9OG4Q8j021647
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 16:04:26 GMT
Received: by el-out-1112.google.com with SMTP id n30so88601elf
        for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 09:04:25 -0700 (PDT)
Message-ID: <471F6C7D.7090807@gmail.com>
Date: Wed, 24 Oct 2007 11:02:05 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: HOME_DIR in .fc works?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I put entries into an .fc file to not relabel polyinstantied instance 
directories but they get relabeled, am I doing it right:
HOME_DIR/\.mlrc\.inst/.*   <<none>>

I don't see anything about this directory when I do:
/usr/sbin/semanage fcontext -l | grep mlrc

I do see them in /etc/selinux/mls/contexts/files/homedir_templates.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
