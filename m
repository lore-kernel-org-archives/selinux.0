Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1TI4YRb022892
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 13:04:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1TI2ulK015475
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 18:02:57 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1TI2tOX015453
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 18:02:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Date: Mon, 1 Mar 2004 05:03:08 +1100
Cc: selinux@tycho.nsa.gov
References: <20040228181418.GO11147@vnl.com> <200402291545.38528.russell@coker.com.au> <20040229160106.GH24151@vnl.com>
In-Reply-To: <20040229160106.GH24151@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403010503.08576.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Mar 2004 03:01, Dale Amon <amon@vnl.com> wrote:
> > What is the problem?  When I compile a policy without klogd (suitable for
> > a syslog-ng system) it works.
>
> After Colin's install script removes klogd.te, the policy build fails:
>
> Using policy installation method "Automatic"
> /usr/bin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf ERROR 'unknown type klogd_t' at token
> ';' on line 39546:
> #
> neverallow ~klogd_t proc_kmsg_t:file ~{ getattr };
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration

I fixed this in my policy ages ago, below is the policy section in question 
(see the list archives for details).  What policy are you running?

ifdef(`klogd.te', `
neverallow ~klogd_t proc_kmsg_t:file ~stat_file_perms;
', `
ifdef(`syslogd.te', `
neverallow ~syslogd_t proc_kmsg_t:file ~stat_file_perms;
')dnl end if syslogd
')dnl end if klogd

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
