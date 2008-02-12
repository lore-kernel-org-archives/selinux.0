Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CEhsV4022502
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:43:54 -0500
Received: from mo11.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1CEhn4S024837
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 14:43:50 GMT
Date: Tue, 12 Feb 2008 23:43:39 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: Disabling SELinux by kernel vulnerability
Message-Id: <20080212234339.40551955.himainu-ynakam@miomio.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I saw an article on slashdot.
http://it.slashdot.org/article.pl?sid=08/02/10/2011257

Local exploit code for Linux kernel exists, 
exploit code is also disclosed in http://www.milw0rm.com/exploits/5092.

In the exploit code, only uid is changed to 0.
So, SELinux is not affected.

However, SELinux can be disabled by overwriting selinux_enforcing to 0.
The address of selinux_enforcing can be seen in /proc/kallsyms, 
and I've set the value on the address to 0.

I tried that on Fedora 8, 
and I could disable SELinux(set selinux as permissive) from xguest_t
domain.

I want to make it more difficult 
for attackers to disable SELinux by kernel exploit.

I think not exporting selinux_enforcing(and selinux_disable) to
/proc/kallsyms is useful.
And /proc/kallsyms is visible from many processes because it is proc_t,
assigning /proc/kallsyms label such as proc_ksym_t may be also useful.
Are they really useful?
Or any idea??

--
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
