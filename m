Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GJAbLa021756
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 15:10:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8GJAamw021937
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 19:10:36 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8GJAa9d021934 for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 19:10:36 GMT
Date: Tue, 16 Sep 2003 20:10:35 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030916191035.GP8988@vnl.com>
References: <20030916155439.GN8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030916155439.GN8988@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 16, 2003 at 04:54:39PM +0100, Dale Amon wrote:
> It should be linked into rcS.d as S0Selinux -> ../init.d/Selinux

Correction, I mean:

	S00Selinux

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
