Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k45JZTf2025287
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 15:35:30 -0400
Received: from mx53.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k45JZRFK003710
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 19:35:28 GMT
Received: from papa.intrajp-yokosuka.co.jp (pdd5aa5.ykhmac00.ap.so-net.ne.jp [218.221.90.165])
	by mx53.ms.so-net.ne.jp  with SMTP id k45JZQH7001323
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 04:35:26 +0900 (JST)
Date: Sat, 6 May 2006 04:49:05 +0900
From: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov
Subject: semodule fails in -i or -u
Message-Id: <20060506044905.27fa8440.shin216@xf7.so-net.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello.
Today, I yum updated evrything and I cannot 
semodule -i or -u at all
in strict policy.


#cd /usr/share/selinux/devel
# ./policygentool backup_new /etc/cron.backup/backup
#make
# semodule -i backup_new.pp
libsepol.verify_module_requirements: Module backup_new's global requirements were not met: type/attribute exec_type
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!


And when I try to update module it also fails.


# semodule -u apache.pp
libsepol.permission_copy_callback: Module apache depends on permission search in class file, not satisfied
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!


Please tell me what is wrong and what should I do.
Thank you.

******************************
libsepol-1.12.4-1.fc5
selinux-policy-strict-2.2.34-3.fc5
libselinux-1.30-1.fc5
checkpolicy-1.30.3-1.fc5
policycoreutils-1.30.1-3.fc5
******************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
