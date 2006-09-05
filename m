Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85KweBK018789
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 16:58:40 -0400
Received: from M4.sparta.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85KwHxN005893
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 20:58:17 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id k85KwdwU027986
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 15:58:39 -0500
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id k85KwUlN025062
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 15:58:39 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <3F89D16F-5FBA-405B-A179-EC48DF45D6A4@sparta.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SE Linux <selinux@tycho.nsa.gov>
From: Todd Miller <Todd.Miller@sparta.com>
Subject: current selinux-usr incompatible with refpolicy-20060307?
Date: Tue, 5 Sep 2006 16:55:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In trying to build refpolicy-20060307 on an FC5 machine using an  
selinux userland with the following svn tags: checkpolicy_1_30_11  
libselinux_1_30_27 libsemanage_1_6_15 libsepol_1_12_26  
policycoreutils_1_30_28 I get this error:

/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
libsepol.expand_terule_helper: duplicate TE rule for initrc_t  
insmod_exec_t:process insmod_t
libsepol.expand_module: Error during expand
Error while expanding policy
make: *** [policy.21] Error 1

The selinux userland components that ship with FC5 are able to build  
the policy.conf into a binary file without problems.  Is there a  
newer version of refpolicy that folks are using for development?

Thanks!

  - todd

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
