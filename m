Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1H09VRb012532
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2004 19:09:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1H081lK017404
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 00:08:01 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1H07xOX017374
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 00:08:00 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 2E3BD61BEF
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 11:08:07 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 00689-02 for <selinux@tycho.nsa.gov>;
	Tue, 17 Feb 2004 11:08:06 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 63D0561B13
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 11:08:06 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id EED38B59DD
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 11:08:04 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Something seems to be self-contradictory
Date: Tue, 17 Feb 2004 11:08:04 +1100
References: <20040216175312.84847.qmail@web15205.mail.bjs.yahoo.com>
In-Reply-To: <20040216175312.84847.qmail@web15205.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200402171108.04387.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Feb 2004 04:53, Park Lee <parklee_2004@yahoo.com.cn> wrote:
> You say that:
> >A domain is a special type.
> >When you define types they can have attributes, one >attribute is "domain"
> > which indicates that it's possible to >use that type for labelling
> > processes.
>
> Do you mean that program is assigned a domain?

Every running process has a domain.

> Then what is the difference between a program and a common file?
> There are some examples:

The only files that can be labeled with a "domain" are under /proc.

> # sshd_exec_t is the type of the sshd executable.
> # sshd_key_t is the type of the ssh private key files
> type sshd_exec_t, file_type, exec_type, sysadmfile;
> type sshd_key_t, file_type, sysadmfile;
> (in selinux-usr\policy\domains\program\ssh.te)
>
> In my opinion, the sshd executable is a program ,and the ssh private key
> files are common files. But, Why Doesn't the type of sshd executable have a
> domain attribute with it?

In SE Linux as in regular Unix, there is nothing really special about a file 
that can be executed.  In Unix permissions the difference between an 
executable and a data file is 1 bit in the file mode.  In SE Linux the 
difference is the presence of execute permission in the SE policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
