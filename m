Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFA2URb018842
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 05:02:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBFA2Tpn014653
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 10:02:29 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id hBFA2Rab014650 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 10:02:28 GMT
Received: from vsa.hitachi-sk.co.jp ([133.108.250.41])
	by nsa.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id hBFA2Qq16351
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 19:02:26 +0900
Received: from gwa.hitachi-sk.co.jp (localhost [127.0.0.1])
	by vsa.hitachi-sk.co.jp (8.9.3+3.2W/3.7W) with ESMTP id TAA28265
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 19:02:25 +0900 (JST)
Received: (from root@localhost)
	by gwa.hitachi-sk.co.jp (8.11.7p1+Sun/3.7W) id hBFA2ON14765
	for selinux@tycho.nsa.gov; Mon, 15 Dec 2003 19:02:24 +0900 (JST)
Received: from ori.hitachi-sk.co.jp (ori.ori.hitachi-sk.co.jp [133.108.2.2])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id hBFA2NS13387
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 19:02:23 +0900
Date: Mon, 15 Dec 2003 19:02:37 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp
Subject: log_domain macro
Message-Id: <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


In log_domain macro,
file_type_auto_trans($1_t, var_log_t, $1_log_t, file)
is described.

By file_type_auto_trans, $1_t can write(unlink) $1_log_t.

If attackers obtains the domain where log_domain macro is used, 
attackers can erase log file.

Many daemons only need append permission to log files.
I think macro such as following is necessary.

define(`append_log_domain', `
type $1_log_t, file_type, sysadmfile, logfile;
allow $1_t var_log_t:dir rw_dir_perms;
allow $1_t $1_log_t:file  { create ra_file_perms };
type_transition $1_t var_log_t:file $1_log_t;
')

--
Yuichi Nakamura
Hitachi Software Engineering Co.,Ltd.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
