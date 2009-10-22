Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9MIbIxn025091
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 14:37:18 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n9MId4i2004233
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 18:39:04 GMT
Date: Thu, 22 Oct 2009 14:37:16 -0400
Subject: RPM support for SELinux
From: Chad Sellers <csellers@tresys.com>
To: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C7061E9C.AB85E%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just wanted to let everyone know that we've submitted a patchset to add
more robust SELinux support to RPM4. You can view the patchset here:

http://lists.rpm.org/pipermail/rpm-maint/2009-October/002561.html

Note that these patches require running on the current trunk of libselinux
and libsemanage.

If you're interested in trying out the support or just looking at how it
works, we've put up a wiki page talking about it here:

http://selinuxproject.org/page/RPM

Comments are welcome.

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
