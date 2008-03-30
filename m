Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2UHWkhH028369
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 13:32:46 -0400
Received: from mwmail02la.mail2world.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2UHWjX6011672
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 17:32:45 GMT
From: "Takesi satoh" <t_mail@mail2Airport.com>
To: <selinux@tycho.nsa.gov>
Subject: RBAC in RHEL5
Date: Sun, 30 Mar 2008 09:58:09 -0700
Message-ID: <0bec01c89287$3b352cc0$016a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0BED_01C8924C.8ED654C0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0BED_01C8924C.8ED654C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,
 
I wonder that I can use RBAC in RHEL5 or not.
Here is my problem.
 
I created new user, and new roles. Let me say john_u: john_r:john_t.
After I made loadable module, loaded it, and I added some entry to
default_context and default_type,
john_u:john_r:john_t was assigned to linux user "john" when john logined
from GNOME.
 
Next, since I wanted to try the case of "john logins from console", 
I added new entry "system_r:local_login_t  john_r:john_t
system_r:unconfined_t" to default_context
and jonh logins from console(tty), then system_r:unconfined_t was
assigned to john.
 
I thought the reason why it happened was the below policy
"type_transition local_login_t shell_exec_t:process transition",
so I downloaded RHEL's selinux-policy-targeted.src.rpm, replaced from
above type_transition sentence to  "allow local_login_t
userdomain:process transition;" in local_login.te, and rebuilded rpm.
 
Then, john logined from console again, and john was assigned to
"local_login_t"
Any domain transition did not happen here.
I wondered " What if I use strict policy? ", so I tried strict policy.
But the result is same, john was assined to local_login_t.
 
So current my assumption is, in RHEL5, I can use RBAC only when user
logins from GNOME.
And my question is,
1) My assumption is correct or did I make any mistake?
2) Is there any way to use RBAC in RHEL5? ( should we try to import
fedora rpm for /bin/login?)
 
Regards,
K
 
 


Click here to find all of your computer accessories for less!
<http://www.relevantads.biz/fc/Ioyw36XImF3EaZY2PYQLisysvFVzIskVW3cTSYqRG
RR3hTWfTvi2Yz/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0BED_01C8924C.8ED654C0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
<DIV>Hello,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I wonder that&nbsp;I can use RBAC in RHEL5 or not.</DIV>
<DIV>Here is my problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I created new user, and new roles. Let me say john_u: john_r:john_t.</DIV>
<DIV>After I made loadable module, loaded it, and&nbsp;I&nbsp;added some entry to default_context and default_type,</DIV>
<DIV>john_u:john_r:john_t was assigned to linux user "john" when john logined from GNOME.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Next, since I wanted to try the case of "john logins from console", </DIV>
<DIV>I added new entry "system_r:local_login_t&nbsp; john_r:john_t system_r:unconfined_t" to default_context</DIV>
<DIV>and jonh logins from console(tty), then system_r:unconfined_t was assigned to john.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I thought the reason why it happened was the below policy</DIV>
<DIV>"type_transition local_login_t shell_exec_t:process transition",</DIV>
<DIV>so I downloaded RHEL's selinux-policy-targeted.src.rpm, replaced from above type_transition sentence to&nbsp; "allow local_login_t userdomain:process transition;" in local_login.te, and rebuilded rpm.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Then, john logined from console again, and john was assigned to "local_login_t"</DIV>
<DIV>Any domain transition did not happen here.</DIV>
<DIV>I wondered " What&nbsp;if I use&nbsp;strict policy? ",&nbsp;so I tried strict policy.</DIV>
<DIV>But the result is same, john was assined to local_login_t.</DIV>
<DIV>&nbsp;</DIV>
<DIV>So current my&nbsp;assumption is, in RHEL5, I can use RBAC only when user logins from GNOME.</DIV>
<DIV>And my question is,</DIV>
<DIV>1)&nbsp;My assumption is correct or did I make any mistake?</DIV>
<DIV>2) Is there any way to use RBAC in RHEL5? ( should we try to import fedora&nbsp;rpm for /bin/login?)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards,</DIV>
<DIV>K</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://www.relevantads.biz/fc/Ioyw36XImF3EaZY2PYQLisysvFVzIskVW3cTSYqRGRR3hTWfTvi2Yz/">Click here to find all of your computer accessories for less!</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_0BED_01C8924C.8ED654C0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
