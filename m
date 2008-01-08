Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m08Lgvwi017201
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 16:42:57 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m08Lgt7v008496
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 21:42:55 GMT
Received: by wx-out-0506.google.com with SMTP id t8so2718727wxc.30
        for <selinux@tycho.nsa.gov>; Tue, 08 Jan 2008 13:42:55 -0800 (PST)
Message-ID: <dd18b0c30801081342s6a9f12f0n324763d5a25e578c@mail.gmail.com>
Date: Tue, 8 Jan 2008 13:42:54 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: pam.d
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22756_29832867.1199828574217"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_22756_29832867.1199828574217
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; does anybody know how I can fix this problem, under /etc/pam.d/login
I have: seesion required pam_selinux.so multiple. During bootup
pam.d sets the default context at system_r:sysadm_t then asks if I want to
change with four optional roles.
How can I change the default context to sysadm_r:sysadm_t ? I've tried to
put session required pam_seinux.so open verbose debug in /etc/pam.d/login
and still have the default
context set to system_r:sysadm_t. Under sestatus -vv Init context is =
system_u:system_r:init_t
regards;
              --Justin P. Mattock

------=_Part_22756_29832867.1199828574217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; does anybody know how I can fix this problem, under /etc/pam.d/login I have: seesion required pam_selinux.so multiple. During bootup<br>pam.d sets the default context at system_r:sysadm_t then asks if I want to change with four optional roles.
<br>How can I change the default context to sysadm_r:sysadm_t ? I&#39;ve tried to put session required pam_seinux.so open verbose debug in /etc/pam.d/login and still have the default<br>context set to system_r:sysadm_t. Under sestatus -vv Init context is = system_u:system_r:init_t
<br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_22756_29832867.1199828574217--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
