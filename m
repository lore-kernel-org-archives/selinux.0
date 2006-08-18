Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IDQ3OG010255
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 09:26:03 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7IDPorn019079
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 13:25:50 GMT
To: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov,
        bug-coreutils@gnu.org
Subject: Does SELinux-enabled mkdir *really* need --context=CTX (aka -Z CTX)?
From: Jim Meyering <meyering@redhat.com>
Date: Fri, 18 Aug 2006 15:26:01 +0200
Message-ID: <87ejve5g5y.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just posted the above question to fedora-list:
  https://www.redhat.com/archives/fedora-list/2006-August/msg02264.html
Feedback welcome.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
