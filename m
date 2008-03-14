Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2ENXxxW022850
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 19:33:59 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2ENXwGx020910
	for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 23:33:59 GMT
Received: by wf-out-1314.google.com with SMTP id 28so4489315wfc.30
        for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2008 16:33:58 -0700 (PDT)
Message-ID: <dd18b0c30803141633j6a57b32q5cd25ae8e16b6e54@mail.gmail.com>
Date: Fri, 14 Mar 2008 23:33:58 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: pam.d
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2583_24056374.1205537638253"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_2583_24056374.1205537638253
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello;
 try putting: session required pam_selinux.so multiple in /etc/pam.d/login
for namespace I have the folowing: session required pam_namespace.so
multiple
hope this helps with logging in.
-- 
Justin P. Mattock

------=_Part_2583_24056374.1205537638253
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello;<br>&nbsp;try putting: session required pam_selinux.so multiple in /etc/pam.d/login<br>for namespace I have the folowing: session required pam_namespace.so multiple<br>hope this helps with logging in.<br>-- <br>Justin P. Mattock

------=_Part_2583_24056374.1205537638253--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
