Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8IIdjZO012479
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 14:39:52 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 2B8BF1A1A8
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 20:39:50 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id oQx75Zx0Dw4s for <selinux@tycho.nsa.gov>;
 Sun, 18 Sep 2016 20:39:48 +0200 (CEST)
Received: from [IPv6:2a02:a03f:d9:8b00:faa3:456b:4d88:6dc7] (unknown
 [IPv6:2a02:a03f:d9:8b00:faa3:456b:4d88:6dc7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 2BC9B1A06E
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 20:39:48 +0200 (CEST)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: sandox -X not working with recent Xephyr
Message-ID: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
Date: Sun, 18 Sep 2016 20:39:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

It seems that sandbox -X is not working anymore on debian.

Xephyr (1.18.4) is giving me the following error:

_XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be created.

The X socket is not created inside the sandbox and then the application 
can obviously not connect to it.

I'm not sure how this could be fixed, maybe let's seunshare create that 
directory?

Cheers,

Laurent Bigonville
