Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA10420
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 22:12:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA18808
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 02:10:44 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id CAA18804
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 02:10:42 GMT
Date: Wed, 2 Oct 2002 11:48:15 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Tracy R Reed <treed@ultraviolet.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002014815.GB14890@snoopy.apana.org.au>
References: <20021001153638.J5416@ultraviolet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021001153638.J5416@ultraviolet.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 03:36:38PM -0700, Tracy R Reed wrote:
> Here are the debs:
> libselinux-dev
> selinux
> selinux-policy-default 
> 
> But the new ps, ls, sshd, etc. do not seem to be included here. Where do I
> get those? Are they not in a deb? 

I think you are looking for the coreutils, fileutils, shellutils, and
procps packages.

> ERROR 'parse error' at token 'run_program' on line 71322:
> run_program(sysadm_t, sysadm_r, deb, dpkg_exec_t, dpkg_t)
> #
> /usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.12] Error 1
> dpkg: error processing selinux-policy-default (--configure):
>  subprocess post-installation script returned error exit status 2
> 
> Errors were encountered while processing:
>  selinux-policy-default
> E: Sub-process /usr/bin/dpkg returned an error code (1)

I believe that problem should be fixed in my latest version.

Now I get another error though:

mkdir -p /etc/security/selinux
/usr/sbin/checkpolicy -o tmp/pol /etc/security/selinux/src/policy.conf
/usr/sbin/checkpolicy:  loading policy configuration from
/etc/security/selinux/src/policy.conf
ERROR 'unknown type devfs_t' at token ';' on line 49839:
# allow writes to devpts devices
allow domain devfs_t:chr_file { ioctl read getattr lock write append };
/usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.12] Error 1

Where is this type defined? It doesn't appear to be in
domains/program/devfsd.te.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
