Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8R6CNrf010659
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 02:12:23 -0400
Received: from mail-yx0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8R6Drqs024504
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 06:13:53 GMT
Received: by yxe4 with SMTP id 4so4394893yxe.32
        for <selinux@tycho.nsa.gov>; Sat, 26 Sep 2009 23:12:21 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 23:12:20 -0700
Message-ID: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com>
Subject: pam_namespace context inside of name.inst
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm going crazy over here trying to figure
out how one system created a context inside
name.inst one way and another for the other system:

the first system has inside of
name.inst:
system_u:object_r:file_t_name

and on the other system I have:

name:object_r:user_home_dir_t_name

the only difference with the machines is one machine
had not been labeled yet, before turning on namespace.

what should be the right context directory inside of
name.inst?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
