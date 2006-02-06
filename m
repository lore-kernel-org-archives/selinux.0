Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k16IFMXf010635
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 13:15:22 -0500 (EST)
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k16IFKhQ018182
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 18:15:20 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k16IFL82003997
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 13:15:21 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k16IFLWC212446
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 13:15:21 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k16IFLNM007503
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 13:15:21 -0500
Subject: writing refpolicy modules...
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: dvelarde@us.ibm.com, selinux-dev@tresys.com
Content-Type: text/plain
Date: Mon, 06 Feb 2006 12:09:18 -0600
Message-Id: <1139249359.3137.53.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We (Deb and I) have a few questions in regards to creating new modules
within refpolicy architecture. We have installed FC5-Test2 and we
are converting old policy to the new refpolicy format.

Is it ok to use the selinux-policy source rpm from rawhide as
a source tree to build a refpolicy module? I understand that the
necessary headers to build independent of source are not yet available.

Do all refpolicy modules need a require and/or optional statement when
using types/attributes from other modules? I ask this because I had
downloaded the rawhide selinux-policy source rpm and had been using the
modules' code as a guideline for writing a refpolicy module. I noticed
that none of the modules used the require/optional statement, but then
they are all compiled as part of the base policy. So, does this mean any
modules written outside of the base module, must use the require or
optional statements if they want to use attributes or types in the base
module? Because my module is not part of the base module.

Also, if I am using interfaces from the base module, are there any
requirements my module must meet? For example, the type domain is now
used as domain_type(), an interface. So, is my policy ok by just
referring to this interface or must I do something else?

Thanks!

Regards,
Joy and Deb



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
