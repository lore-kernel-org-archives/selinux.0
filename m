Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBP4cIIi010508
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 23:38:18 -0500 (EST)
Received: from wproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBP4cMFA023170
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 04:38:22 GMT
Received: by wproxy.gmail.com with SMTP id 68so176192wra
        for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 20:38:22 -0800 (PST)
Message-ID: <41CCEEB5.3040200@gmail.com>
Date: Sat, 25 Dec 2004 04:38:13 +0000
Reply-To: zia.syed@smartweb.rgu.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: selinux@tycho.nsa.gov
Subject: fedora core 3, httpd and PHP exec()
From: Zia Syed <zia.chacho@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'm running PHP in safe mode, and trying to run system command (uptime) 
in exec() statement. When i turn off the selinux (via firewall settings 
in KDE), the script works fine, but when its enabled, i get the 
following error in /var/log/messages

Dec 25 04:15:26 melville kernel: audit(1103948126.072:0): avc:  denied  
{ read }
 for  pid=5926 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441 
scontext=root:sys
tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file
Dec 25 04:17:46 melville kernel: audit(1103948266.882:0): avc:  denied  
{ read }
 for  pid=5944 exe=/usr/sbin/httpd name=sh dev=hda2 ino=670441 
scontext=root:sys
tem_r:httpd_t tcontext=system_u:object_r:bin_t tclass=lnk_file

I tried using chcon (chcon -R -t httpd_sys_script_exec_t .) , but of no 
use as i dont know how to set permissions for binary files.

Please advise!

BR. Zia

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
