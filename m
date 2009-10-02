Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92FeIhM012112
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 11:40:19 -0400
Received: from atoll.udmvt.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n92FdUQb017310
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 15:39:31 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n92FeCgc051342
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 20:40:14 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Fri, 2 Oct 2009 20:40:12 +0500
From: selinux@udmvt.ru
To: selinux@tycho.nsa.gov
Subject: How to trace why MCS permissions granted?
Message-ID: <20091002154012.GT4221@ruber.office.udmvt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, everyone.
I'm just playing with MCS and trying to understand the system's behavior.

As far as I have read the theory, categories can be used to limit unwanted user's
access to your data. So, I am trying to create a file, mark it with a category,
first time - the same as the process has. Then I write there some data and read it back.
That works OK and is as expected.
But when I change file's category to some other, that my testing process don't have,
to prevent the process from accessing that file, I discover that the process may read,
but cannot write (append) to that file:

	root@selinux1:/tmp# id
	uid=0(root) gid=0(root) groups=0(root) context=root:sysadm_r:sysadm_t:s0:c0
	root@selinux1:/tmp# ls -laZ test
	-rw-r--r-- 1 root root system_u:object_r:sysadm_tmp_t:s0:c1   9 Oct  3 00:44 test
	root@selinux1:/tmp# cat test
	asfasdaf
	root@selinux1:/tmp# cat >> test
	bash: test: Permission denied
	root@selinux1:/tmp# setenforce 0
	root@selinux1:/tmp# cat >> test
	blabla
	root@selinux1:/tmp# cat test
	asfasdaf
	blabla

When the process is at s0:c0, the file is at s0:c1, and in enforcing mode I expect
to have no access at all.

I can only guess, that sysadm_t is in some way marked as a special type for
bypassing MCS constraints, but how can I proof/check that?
And if that is true, I still expect to have all access or no access at all,
but not the read only access.
Please, if there is nothing wrong with what I am seeing, tell where can I read
about that more?

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
