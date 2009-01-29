Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0TAWj8G017721
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2009 05:32:45 -0500
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0TAWhHu013663
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2009 10:32:43 GMT
Date: Thu, 29 Jan 2009 21:32:36 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: ltp-list@lists.sourceforge.net
cc: selinux@tycho.nsa.gov
Subject: LTP SELinux policy error
Message-ID: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to run the LTP SELinux tests using the latest CVS version of 
LTP and current Fedora development, and get the following policy 
compilation error:

----
Compiling targeted test_policy module

test_policy.te:1730: Warning: r_dir_perms is deprecated please use list_dir_perms instead.
test_policy.te:1731: Warning: r_file_perms is deprecated please use read_file_perms instead.
[lots of warnings similar to the above]

/usr/bin/checkmodule:  loading policy configuration from 
tmp/test_policy.tmp
test_policy.te":16:ERROR 'syntax error' at token 
'userdom_use_sysadm_terms' on line 3198:
userdom_use_sysadm_terms(testdomain)
# This allows read and write sysadm ttys and ptys.
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make[1]: *** [tmp/test_policy.mod] Error 1
make[1]: Leaving directory `/usr/share/selinux/devel'
make: *** [load] Error 2
Failed to build and load test_policy module, aborting test run.
----

Is this likely to be fixed soon, and/or any suggestions for a workaround?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
