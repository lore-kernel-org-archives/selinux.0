Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LF67q0011700
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:06:07 -0400
Received: from mta5.srv.hcvlny.cv.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LF5CY0018469
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 15:05:12 GMT
Received: from srv.laga.pri (ool-43568f33.dyn.optonline.net [67.86.143.51])
 by mta5.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0KRV00DX9DY5T180@mta5.srv.hcvlny.cv.net> for
 selinux@tycho.nsa.gov; Wed, 21 Oct 2009 11:06:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id 23E6F1B42002	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:06:05 -0400 (EDT)
Received: from srv.laga.pri ([127.0.0.1])
 by localhost (srv.laga.pri [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10256-08 for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:06:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])	by srv.laga.pri (Postfix)
 with ESMTP id 6C3EA1B42003	for <selinux@tycho.nsa.gov>; Wed,
 21 Oct 2009 11:06:04 -0400 (EDT)
Received: from [164.55.144.109] (unknown [164.55.254.106])
	by srv.laga.pri (Postfix) with ESMTP id 389931B42002	for
 <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 11:06:03 -0400 (EDT)
Date: Wed, 21 Oct 2009 11:06:00 -0400
From: Eric Laganowski <eric@laganowski.net>
Subject: 'make policy' issues
To: selinux@tycho.nsa.gov
Message-id: <4ADF2358.4050606@laganowski.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

    Hello,

 I was trying to build selinux userspace tools on my custom linux build. 
Everything went fine until I attempted to compile reference policy.
Could you please help me in understanding what went wrong here.

refpolicy-2.20090730

$ make policy
Compiling refpolicy policy.24
/usr/bin/checkpolicy policy.conf -o policy.24
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/kernel/corenetwork.te":1715:ERROR 'syntax error' at token ':' on line 9122:
allow corenet_unconfined_type node_type:node *;

checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.24] Error 1


Packages:

checkpolicy-2.0.19
libselinux-2.0.85
libsemanage-2.0.33
libsepol-2.0.37
policycoreutils-2.0.69
sepolgen-1.0.17

$ yacc -V
yacc - 1.9 20090221
$ flex -V
flex 2.5.35

-Eric




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
