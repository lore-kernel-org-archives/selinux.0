Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0A9Gr4F021067
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 04:16:53 -0500
Received: from [10.0.1.5]
 (107-206-68-196.lightspeed.rcsntx.sbcglobal.net [107.206.68.196])
 by nk11p07mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MZ600HZ6HS2SG80@nk11p07mm-asmtp001.mac.com> for
 selinux@tycho.nsa.gov; Fri, 10 Jan 2014 09:16:51 +0000 (GMT)
From: Bryan Harris <bryanlharris@me.com>
Content-type: text/plain; charset=us-ascii
Subject: new to selinux
Message-id: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
Date: Fri, 10 Jan 2014 03:16:49 -0600
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
MIME-version: 1.0 (Mac OS X Mail 7.1 \(1827\))
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I'm wondering if it is possible to use selinux network & process labeling, iptables, and something like /usr/bin/script to create an environment where we can enforce session recording for ssh sessions.

We will soon have a requirement to record our actions on customer environments, but at the same time we also need to block users who have not activated the recording.  Is selinux policy an appropriate way to accomplish these requirements?  I'd like to search for the details and learn more, but if I'm taking the wrong approach I'd like to know that before starting out.

Any guidance is greatly appreciated.  Thanks in advance.

V/r,
Bryan
