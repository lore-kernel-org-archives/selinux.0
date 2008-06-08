Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m588hrWI003336
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2008 04:43:53 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m588hqmX015825
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2008 08:43:52 GMT
Received: by an-out-0708.google.com with SMTP id d30so413334and.75
        for <selinux@tycho.nsa.gov>; Sun, 08 Jun 2008 01:43:52 -0700 (PDT)
Message-ID: <dd18b0c30806080143t6d601bacta7b3652331a48dbf@mail.gmail.com>
Date: Sun, 8 Jun 2008 08:43:52 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: No AVC messages found
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; why do I receive this: No AVC messages found when I audit2allow -d when
I have this under dmesg:
[ 8395.499759] type=1701 audit(1212909990.108:3): auid=4294967295
uid=1000 gid=1000 ses=4294967295 subj=a-12:sysadm_r:sysadm_t pid=3389
comm="aterm" sig=6

the only action that I took was "uptime" in a terminal, could this be it?
should I have seen the definition uptime in the AVC? i.g. /usr/sbin or  /*/*
or is this something diff.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
