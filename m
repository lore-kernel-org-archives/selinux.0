Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA12465
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 04:55:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA01923
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:54:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA01919
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:54:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, Tracy R Reed <treed@ultraviolet.org>
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 10:54:16 +0200
Cc: selinux@tycho.nsa.gov
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au>
In-Reply-To: <20021002014815.GB14890@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200210021054.16283.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 03:48, Brian May wrote:
> Now I get another error though:
>
> mkdir -p /etc/security/selinux
> /usr/sbin/checkpolicy -o tmp/pol /etc/security/selinux/src/policy.conf
> /usr/sbin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf
> ERROR 'unknown type devfs_t' at token ';' on line 49839:
> # allow writes to devpts devices
> allow domain devfs_t:chr_file { ioctl read getattr lock write append };
> /usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.12] Error 1
>
> Where is this type defined? It doesn't appear to be in
> domains/program/devfsd.te.

That was removed in the last NSA release (over a month ago).  Check the list 
archives, it was discussed on the list at the time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
