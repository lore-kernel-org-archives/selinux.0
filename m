Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k22Gu6d1015289
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:56:08 -0500
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k22GsZd7024209
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 16:54:36 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k22Gu5aI028744
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:56:05 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k22Gu5GJ055992
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:56:05 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k22Gu4nf008431
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:56:05 -0500
Subject: building base targeted policy...
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, selinux-dev@tresys.com
Content-Type: text/plain
Date: Thu, 02 Mar 2006 10:49:52 -0600
Message-Id: <1141318192.3075.38.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I downloaded the policy-src rpm in order to build a base 
policy. I used the modules-targeted.conf. My goal is to simply add an
interface in kernel's module for ipsec packets. I am running targeted
policy on FC5 test3. My build.conf states I am building targeted,
modular policy.

When I try to install my base policy, I received the following:

  semodule -b base.pp 
  libsepol.link_modules: Tried to link in an MLS module with a
   non-MLS    base.
  libsemanage.semanage_link_sandbox: Link packages failed
  semodule:  Failed!

The targeted modules.conf states "mls=base" is required. 
Just to see what would happen, I commented out "mls=base" and 
rebuilt my base policy. The compile fails though because there are
references to mls_trusted_object() throughout several modules and this
interface is defined in mls module.

For example:
Compiling refpolicy base module
/usr/bin/checkmodule base.conf -o tmp/base.mod
/usr/bin/checkmodule:  loading policy configuration from base.conf
tmp/only_te_rules.conf:36:ERROR 'syntax error' at token
'mls_trusted_object' on line 40705:

mls_trusted_object(devtty_t)
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/base.mod] Error 1

What am I doing wrong?

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
