Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0VLZLeW029676
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 16:35:21 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0VLZLq9005301
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 21:35:21 GMT
Received: by wr-out-0506.google.com with SMTP id c55so794247wra.0
        for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 13:35:21 -0800 (PST)
Message-ID: <dd18b0c30801311335x468a5952s62315a5120bc2130@mail.gmail.com>
Date: Thu, 31 Jan 2008 21:35:19 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: shadow
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17980_3812169.1201815319653"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_17980_3812169.1201815319653
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hello, Thanks you for the help,Stephen exactly what you had said, The avc
denial should be supressed by dontaudit rules, unless you've rebuilt with
those stripped from the policy.  Hopefully I understand this correctly; make
enableaudit was giving me allow system_chkpwd_t security_t:file read;
and allow sysadm_sudo_t shadow_t:file { read getattr }; After recompiling my
policy;(without make enableaudit) make clean make policy; the allow rules
worked for shadow, without commenting out anything.
regards;
               --Justin P. Mattock

------=_Part_17980_3812169.1201815319653
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hello, Thanks you for the help,Stephen exactly what you had said, The avc denial should be supressed by dontaudit rules, unless you&#39;ve rebuilt with those stripped from the policy.&nbsp; Hopefully I understand this correctly; make enableaudit was giving me allow system_chkpwd_t security_t:file read; <br>
and allow sysadm_sudo_t shadow_t:file { read getattr }; After recompiling my policy;(without make enableaudit) make clean make policy; the allow rules worked for shadow, without commenting out anything. <br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_17980_3812169.1201815319653--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
