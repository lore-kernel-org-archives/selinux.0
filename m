Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA04798
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 03:43:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA21187
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 07:41:50 GMT
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com [194.25.134.83])
        by jazzband.ncsc.mil  with ESMTP id HAA21183 for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 07:41:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id 43DA61AE90
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 09:42:39 +0200 (CEST)
Message-ID: <3CCE4CFC.D18FF4E4@dr-baldeweg.de>
Date: Tue, 30 Apr 2002 09:51:24 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Security Context of nscd_socket
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Yesterday I rebuild the file security context and after this the nscd
did not work, because the security context of the file
/var/run/.nscd_socket was set to var_run_t and not to nscd_var_run_t.
The policy denied the unlink of this file.
A solution is to add follow line in the file file_context 
/var/run/.nscd_socket   system_u:object_r:nscd_var_run_t. 

Could anybody add this to the source code?

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
