Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k59LCXUP032572
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 17:12:33 -0400
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k59LCWTJ011514
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 21:12:32 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k59LCVuk013325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 17:12:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k59LCV6g258616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 17:12:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k59LCViJ003693
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 17:12:31 -0400
Received: from [9.12.232.97] ([9.12.232.97])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k59LCUrG003620
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 17:12:31 -0400
From: Rodrigo Vivi <vivijim@br.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Relabeling Network Objects ?
Date: Fri, 9 Jun 2006 18:12:09 -0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606091812.09677.vivijim@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi folks,

Is it possible to relabel a network object {netif, node} ? 
if yes, how can I do it ?

Or can I easily change the context assigned on creation of an specific {netif, 
node} like a tun interface with a specific address ??

Thanks in advance.

vivijim.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
