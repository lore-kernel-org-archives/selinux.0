Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFCFdRb019240
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 07:15:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBFCFcpn017348
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 12:15:38 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBFCFOab017321 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 12:15:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Information
Date: Mon, 15 Dec 2003 23:13:59 +1100
References: <3FDD9A28.9070406@ipen.br>
In-Reply-To: <3FDD9A28.9070406@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312152313.59234.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 Dec 2003 22:25, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> I have seen that the binary policy file (policy.15) have "15" as version
> of the checkpolicy utility, right ?
> The change done in the sysvinit package load the policy as:
> /sbin/load_policy /etc/security/selinux/policy.15, right?
> If yes, a change in the version of the checkpolicy, I have that change
> the sysvinit too ?

The file /selinux/policyvers has the version.  A future version of sysvinit 
will examine that file to determine which (of possibly many) policy databases 
should be loaded.

Maybe Dan's rpm has this already, I haven't checked.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
