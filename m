Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8CMBeNs017349
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 18:11:40 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8CM8tl1014315
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 22:08:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 4161B450F7
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 05:15:52 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04508-09 for <selinux@tycho.nsa.gov>;
 Tue, 13 Sep 2005 05:15:49 +0100 (BST)
Received: from [192.168.0.3] (host-87-74-41-116.bulldogdsl.com [87.74.41.116])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 55F15450EE
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 05:15:49 +0100 (BST)
Subject: error building file_contexts
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 23:18:53 +0100
Message-Id: <1126563533.13869.5.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi list,

Anyone knows how to figure out where this error is coming from:
# make
 * Creating policy.conf
 * Policy version: 19
 * Kernel version: 19
 * Compiling and installing policy.19
/usr/bin/checkpolicy:  loading policy configuration
from /etc/security/selinux/src/policy.conf
security:  3 users, 5 roles, 658 types, 3 bools
security:  55 classes, 57721 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 19)
to /etc/security/selinux/policy.19
 * Building file_contexts
Traceback (most recent call last):
  File "/usr/sbin/genhomedircon", line 468, in ?
    oldgenhomedircon(cmds[0], cmds[1])
  File "/usr/sbin/genhomedircon", line 187, in oldgenhomedircon
    if re.search(regex, potential, 0):
  File "/usr/lib/python2.3/sre.py", line 137, in search
    return _compile(pattern, flags).search(string)
  File "/usr/lib/python2.3/sre.py", line 230, in _compile
    raise error, v # invalid expression
sre_constants.error: nothing to repeat
make: *** [file_contexts/file_contexts] Error 1

(non-enforcing mode makes no difference)
* kernel 2.6.13.1
* libselinux 1.24
* libsepol 1.6

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
