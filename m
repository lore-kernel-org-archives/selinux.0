Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4V6BBKI027211
	for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 02:11:11 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4V6BAO3009960
	for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 06:11:10 GMT
Received: by wf-out-1314.google.com with SMTP id 23so139872wfg.30
        for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 23:11:09 -0700 (PDT)
Message-ID: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
Date: Sat, 31 May 2008 06:11:09 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: changing role to user_r
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I'm running an experiment with SELinux and seem to be at a crux
with changing roles:
newrole -r user_r
I get a permission denied, the allow rule is this: allow newrole_t
user_t:process transition;
I don't have a problem changing to sysadm_r any thoughts on what I'm missing?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
