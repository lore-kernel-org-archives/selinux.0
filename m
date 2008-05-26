Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4Q8j1gc003958
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 04:45:01 -0400
Received: from hermod.iguanait.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4Q8j0MW002092
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 08:45:01 GMT
Received: from localhost (hermod.iguanait.com [127.0.0.1])
	by hermod.iguanait.com (Postfix) with ESMTP id 6429F3A48578
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 10:45:00 +0200 (CEST)
Received: from hermod.iguanait.com ([127.0.0.1])
 by localhost (hermod.iguanait.com [127.0.0.1]) (amavisd-maia, port 10024)
 with LMTP id 31488-03 for <selinux@tycho.nsa.gov>;
 Mon, 26 May 2008 10:45:00 +0200 (CEST)
Received: from [192.168.1.7] (87-126-80-161.btc-net.bg [87.126.80.161])
	by hermod.iguanait.com (Postfix) with ESMTP id 01C543A48557
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 10:44:59 +0200 (CEST)
Subject: Problem with multisame specification warning messages RHEL 5
From: Ali Nebi <anebi@iguanait.com>
Reply-To: anebi@iguanait.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 May 2008 11:44:57 +0300
Message-Id: <1211791497.5210.21.camel@hugo.iguanait.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

we have installed RHEL 5 and after update we get these warnings: 

/etc/selinux/targeted/contexts/files/file_contexts: Multiple same
specifications for /usr/local/lost\+found/.*.
/etc/selinux/targeted/contexts/files/file_contexts: Multiple same
specifications for /usr/local/\.journal.
/etc/selinux/targeted/contexts/files/file_contexts: Multiple same
specifications for /usr/local/lost\+found.

I tried to remove these with semanage tool this way:

semanage fcontext -d "/usr/local/lost\+found/.*"

/usr/sbin/semanage: File context for /usr/local/lost\+found/.* is
defined in policy, cannot be deleted

I got the error above, that i can't delete this policy, because it is
defined in policy. How can i fix this problem? If i edit manually user
definitions file, will it be generated automatically after restart and i
will get the same warnings?

There is already a bug report in centos bugzilla. But i would like to
find out how to fix this problem.

Please help me for this.

Thanks in advanced!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
