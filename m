Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PBVQsJ023307
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 07:31:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PBTfZt011936
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 11:29:41 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8PBTfM3011933
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 11:29:41 GMT
Date: Thu, 25 Sep 2003 12:31:20 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925113120.GE10234@vnl.com>
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au> <20030924203129.GQ21997@vnl.com> <200309251332.53496.russell@coker.com.au> <20030925104456.GD10234@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030925104456.GD10234@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 11:44:57AM +0100, Dale Amon wrote:
>  Sep 25 11:40:26 cvs ssh(pam_unix)[394]: authentication failure; logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=10.0.0.25  user=root
>  Sep 25 11:40:32 cvs sshd[394]: Accepted password for root from 10.0.0.25 port 1160 ssh2
>  Sep 25 11:40:32 cvs sshd[394]: default security context is root:staff_r:staff_t
>  Sep 25 11:40:32 cvs sshd[394]: setting tty /dev/pts/2 context to root:object_r:staff_devpts_t
>  Sep 25 11:40:32 cvs sshd[394]: fatal: chown(/dev/pts/2, 0, 5) failed: Permission denied
>  Sep 25 11:40:32 cvs sshd[394]: error: chown /dev/pts/2 0 0 failed: Permission denied
>  Sep 25 11:40:32 cvs sshd[394]: error: chmod /dev/pts/2 0666 failed: Permission denied

Okay, I tried it with a policy that allowed the only
remaining avc and I still get the same as the above.
So I'm really starting to look at the devpts angle.
Has anyone else had problems with it? 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
