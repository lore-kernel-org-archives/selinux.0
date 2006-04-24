Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3OEtvSk026109
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 10:55:57 -0400
Received: from mx52.ms.so-net.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3OEtrQT021566
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 14:55:55 GMT
Received: from papa.intrajp-yokosuka.co.jp (p8039ad.ykhmac00.ap.so-net.ne.jp [211.128.57.173])
	by mx52.ms.so-net.ne.jp  with SMTP id k3OEtq35017609
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 23:55:53 +0900 (JST)
Date: Tue, 25 Apr 2006 00:07:40 +0900
From: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
To: selinux@tycho.nsa.gov
Subject: semodule fails
Message-Id: <20060425000740.41ed51f5.shin216@xf7.so-net.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

When I try to install .pp file, it fails with messages.

#semodule -i postgresql_by_me.pp
libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { write };
libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { read };
libsepol.check_assertions: 2 assertion violations occured
libsemanage.semanage_expand_sandbox: Expand module failed
semodule: Failed!

I saw archives and it says that libsepol-1.11 could solve the problem,
but mine is 1.12.

*******************************************
selinux-policy-strict-2.2.29-3.fc5
libsepol-1.12.4-1.fc5
*******************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
