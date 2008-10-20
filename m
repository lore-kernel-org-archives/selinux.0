Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9KKetDd010761
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 16:40:55 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9KKdVcQ013704
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 20:39:32 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id DBDF1180B7
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 07:40:52 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 7DD1221C85
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 07:40:50 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: xend and noatsecure
Date: Tue, 21 Oct 2008 07:40:46 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810210740.49713.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allow xend_t xenstored_t:process { noatsecure };
allow xend_t xenconsoled_t:process { noatsecure };

The Xen packages in Debian/Lenny will not support Xen starting correctly on 
boot unless the above lines are added to the policy.

Starting XEN control daemon: xend/usr/lib/xen-3.2-1/bin/xenstored: error while 
loading shared libraries: libxenctrl.so: cannot open shared object file: No 
such file or directory
/usr/lib/xen-3.2-1/bin/xenconsoled: error while loading shared libraries: 
libxenctrl.so: cannot open shared object file: No such file or directory

Above are the errors.

It seems that LD_PRELOAD (or one of the similar environment variables) is 
being set.

What is the best way of solving this?

For Lenny I think I will just have to allow noatsecure, the chance of getting 
modified Xen packages in Lenny at this stage seem quite low.  But for Lenny+1 
I want to get it solved in the best possible way.

Have the Red Hat guys done something in this regard?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
