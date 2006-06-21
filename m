Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LK0WvG031206
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 16:00:32 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LK0Vsi016068
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 20:00:32 GMT
Message-Id: <20060621194234.979661000@flek.zko.hp.com>
Date: Wed, 21 Jun 2006 15:42:35 -0400
From: paul.moore@hp.com
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, sgrubb@redhat.com
Subject: [RFC 0/7] Updated NetLabel patch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an updated version of the NetLabel patch I sent out on May 25th.  It
contains a variety of fixes and incorporates comments from James Morris,
Stephen Smalley, and Steve Grubb.  An intermediate version of this patch set
has also been tested against Trusted Solaris and HP-UX CMW for CIPSO
interoperability.  I have tested this patch set on x86 and x86_64
architectures running both the targeted/enforcing and mls/permissive SELinux
policies.

Just like before I am sending this patch out in an effort to solicit feedback
from developers, any comments you can afford to send would be greatly
appreciated.  While the patch is still "unfinished" my current todo list is
much shorter, the major tasks still remaining are:

 * protect against setsockopt() calls
 * address the remaining "PM" comments

For those wishing to try the patch for themselves you will need to download
and install the NetLabel tools.  The tools are used to configure the NetLabel
subsystem, documentation (including a man page) is included in the tarball.
The NetLabel tools, as well as more information, can be found here:

 * http://free.linux.hp.com/~pmoore/projects/linux_cipso

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
