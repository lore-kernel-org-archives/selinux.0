Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9J7XNPr028789
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 03:33:23 -0400
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9J7VxGW001560
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 07:31:59 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id AF20D1B7D08
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 09:33:22 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 9B0E85355
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 07:33:22 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31558-07 for <selinux@tycho.nsa.gov>;
 Thu, 19 Oct 2006 09:33:21 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 4BCD155A1
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 09:33:21 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: allow tomcat_t self:capability 0x80000000; ??
Date: Thu, 19 Oct 2006 09:33:18 +0200
MIME-Version: 1.0
Message-Id: <200610190933.19483.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I'm trying to write a policy for Tomcat using RedHat Enterprise 4.
I receive the next message:

Oct 19 09:04:36 cnsu kernel: audit(1161248676.103:4605): avc:  denied  
{ 0x80000000 } for  pid=1223 comm="java" capability=31 
scontext=root:system_r:tomcat_t tcontext=root:system_r:tomcat_t 
tclass=capability

Using the audit2allow tool, I become the next allow to add: "allow tomcat_t 
self:capability 0x80000000;" but this don't works, after the compiler shows 
the following error:

/usr/bin/checkpolicy:  loading policy configuration from policy.conf
domains/xxx/tomcat.te:117:ERROR 'syntax error' at token '0' on line 39415:
allow tomcat_t self:capability 0x80000000;

Somebody can help me to understand what I'm doing wrong?

Thanks

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
