Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LDXZgA025713
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 09:33:36 -0400 (EDT)
Received: from mx07.ms.so-net.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LDSCBa017239
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:28:13 GMT
Received: from admin0 (pdd5cde.ykhmac00.ap.so-net.ne.jp [218.221.92.222])
	by mx07.ms.so-net.ne.jp  with SMTP id j6LDSvTL023138
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 22:28:57 +0900 (JST)
Message-ID: <002b01c58df8$260c6700$0300a8c0@admin0>
From: "shintarou_fujiwara" <shin216@xf7.so-net.ne.jp>
To: <selinux@tycho.nsa.gov>
Subject: I have a question about log on SELinux
Date: Thu, 21 Jul 2005 22:28:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My name is Shin from JAPAN.

Hello, I'm pretty new to this SELinux world,but one of my friend have some 
question on logging .

He is now using RHEL4u1 and testing SELinux .

He uses targeted & enforcing and httpd_enable_cgi tuned off .

When he accesses to cbi-bin directory, he got these messages on 
/var/log/messages.
######################################################
#First one is,

Jul 12 18:16:20 host1 kernel:
audit(1121159780.840:0): avc:  denied  { search } for  pid=3037
comm=httpd name=cgi-bin dev=cciss/c0d0p1 ino=883150
          ^^^^
scontext=user_u:system_r:httpd_t 
tcontext=system_u:object_r:httpd_sys_script_exec_t
tclass=dir

#Second one is,

Jul 12 18:16:20 host1 kernel:
audit(1121159780.840:0): avc:  denied  { getattr } for  pid=3037
comm=httpd path=/var/www/cgi-bin dev=cciss/c0d0p1 ino=883150
          ^^^^
scontext=user_u:system_r:httpd_t 
tcontext=system_u:object_r:httpd_sys_script_exec_t
tclass=dir
########################################################
His question is , the difference between "name" and "path" .

He and I have no idea the differences between these two.
They look totaly the same...

Please give us an advice .

Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
