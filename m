Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6GADio017573
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 11:10:33 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id B99F71A1BB
 for <selinux@tycho.nsa.gov>; Fri,  6 Nov 2015 17:10:15 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nmL2_a4lHvsO for <selinux@tycho.nsa.gov>;
 Fri,  6 Nov 2015 17:10:13 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1:6c0f:d8f0:feb1:4106] (unknown
 [IPv6:2a02:578:85fc:1:6c0f:d8f0:feb1:4106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id C97F11A070
 for <selinux@tycho.nsa.gov>; Fri,  6 Nov 2015 17:10:12 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: Wrong audit message type when policy is reloaded
Message-ID: <563CD0E4.4060105@debian.org>
Date: Fri, 6 Nov 2015 17:10:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

When the policy is reloaded, systemd and dbus are sending a USER_AVC 
audit event instead of a USER_MAC_POLICY_LOAD one.

Looking at an other object manager (the xserver) it uses the following 
code: 
http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c#n300

Can we really link SELINUX_INFO to AUDIT_USER_MAC_POLICY_LOAD? Is there 
a better way to achieve this?

An downstream bug has been opened: 
https://bugzilla.redhat.com/show_bug.cgi?id=1195330

Cheers,

Laurent Bigonville
