Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1MWRN4010691
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 17:32:27 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1MWQwc022455
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 22:32:27 GMT
Received: by wa-out-1112.google.com with SMTP id j5so1328629wah.18
        for <selinux@tycho.nsa.gov>; Mon, 01 Dec 2008 14:32:26 -0800 (PST)
Subject: the new way of newrole
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 14:32:22 -0800
Message-Id: <1228170742.2966.6.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello;
this new policy(svn) is killing me over here... 
Am I supposed to be startingx
like this:(after login a command prompt)
newrole -r staff_r -- -c /usr/bin/startx
if so how do I change dbus to run the right context?


-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
