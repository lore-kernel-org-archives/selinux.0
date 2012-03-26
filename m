Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QCCqhJ023939
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 08:12:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 0B1F01A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:12:49 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3l66SmGfEv9 for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 14:12:47 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 53F971A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:12:47 +0200 (CEST)
Date: Mon, 26 Mar 2012 14:12:42 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Debian patches to userspace components
Message-ID: <20120326141242.59afdd34@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm currently helping Russel with the SELinux packages in Debian.

The Debian packages are carrying some (a lot?) of patches that I would
like to see merged upstream. The rational of some of them has
unfortunately been lost and not all of these patches are suitable for
being merged upstream.

The patches that are currently applied to the debian packages can be
found at:

http://patch-tracker.debian.org/package/libselinux/
http://patch-tracker.debian.org/package/libsepol/
http://patch-tracker.debian.org/package/libsemanage/
http://patch-tracker.debian.org/package/sepolgen/
http://patch-tracker.debian.org/package/policycoreutils/
http://patch-tracker.debian.org/package/checkpolicy/
http://patch-tracker.debian.org/package/setools/

Are you interested in them? If so, I'll forward the ones that I think
are not Debian specific to the mailing-list.

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
