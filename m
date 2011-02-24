Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1OGNBGS031213
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 11:23:11 -0500
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1OGNBWf012554
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 16:23:11 GMT
Received: by vws8 with SMTP id 8so588302vws.12
        for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 08:23:11 -0800 (PST)
From: Bill Chimiak <wch1m1@gmail.com>
To: "selinux-mailing-list" <selinux@tycho.nsa.gov>
Subject: adobe on FC 14
Date: Thu, 24 Feb 2011 11:19:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201102241119.25067.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

acroread wants to execute on a stack and it seems to be ugly.
Any advice?
Details:

/opt/Adobe/Reader9/Reader/intellinux/bin/acroread: error while loading shared 
libraries: libcrypto.so.0.9.8: cannot enable executable stack as shared object 
requires: Permission denied

audit2allow says:
#============= setroubleshootd_t ==============
allow setroubleshootd_t user_home_t:file { execute execute_no_trans };

#============= unconfined_t ==============
#!!!! This avc can be allowed using the boolean 'allow_execstack'
allow unconfined_t self:process execstack;

===============================================
Someone suggested this:

chcon -t execmem_exec_t '/opt/Adobe/Reader9/Reader/intellinux/bin/acroread'

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
