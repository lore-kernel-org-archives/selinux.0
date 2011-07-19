Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6JLkklx018074
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 17:46:46 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6JLkjfb002344
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 21:46:45 GMT
Received: from wm1.irbs.net (wm1.irbs.net [216.86.168.168])
	by smtp.mxes.net (Postfix) with ESMTP id 141FB50A6B
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 17:46:44 -0400 (EDT)
Received: from localhost (wm1.irbs.net [216.86.168.168])
	by wm1.irbs.net (Postfix) with ESMTPA id 8E5E55009EB
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2011 17:46:44 -0400 (EDT)
Message-ID: <20110719224644.1622385u2ewqtf0g@webmail.tuffmail.net>
Date: Tue, 19 Jul 2011 22:46:44 +0100
From: Martin Orr <martin@martinorr.name>
To: selinux@tycho.nsa.gov
Subject: What is /selinux/null?
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can anyone explain the following AVC denial?  What is the purpose of  
/selinux/null and why would ifconfig open it instead of /dev/null?

type=1400 audit(1311107387.404:18): avc:  denied  { use } for   
pid=2211 comm="wpa_supplicant" path="/null" dev=selinuxfs ino=22  
scontext=system_u:system_r:NetworkManager_t:s0  
tcontext=system_u:system_r:ifconfig_t:s0 tclass=fd

-- 
Martin Orr


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
