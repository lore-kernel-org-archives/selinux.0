Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PCHcsJ023476
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:17:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8PCHbCG009276
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:17:38 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8PCHbqJ009273 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:17:37 GMT
Date: Thu, 25 Sep 2003 13:17:33 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925121733.GF10234@vnl.com>
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au> <20030924203129.GQ21997@vnl.com> <200309251332.53496.russell@coker.com.au> <20030925104456.GD10234@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030925104456.GD10234@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 11:44:57AM +0100, Dale Amon wrote:
> I'm starting to wonder if this has anything to do with the
> 2.6.0 devpts filesystem?

Okay, I find this, which doesn't seem right:

drwxr-xr-x  root     root     (null)                           /dev/pts

Should I perhaps add a a line to genfs_contexts?

  genfscon devpts /                     system_u:object_r:devpts_t


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
