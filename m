Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7S24SrT024083
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 22:04:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7S23dpX000128
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 02:03:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: more policy patches
Date: Sat, 28 Aug 2004 12:04:22 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <200408241937.04958.russell@coker.com.au> <1093640718.24188.37.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1093640718.24188.37.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408281204.22830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Aug 2004 07:05, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> I also, didn't merge the following:
>
> diff -ru /usr/src/se/policy/file_contexts/program/initrc.fc
> ./file_contexts/program/initrc.fc
> --- /usr/src/se/policy/file_contexts/program/initrc.fc  2004-07-15
> 10:22:53.000000000 +1000
> +++ ./file_contexts/program/initrc.fc   2004-07-08 21:22:51.000000000
> +1000
> @@ -16,5 +16,3 @@
>  /usr/sbin/open_init_pty        --      system_u:object_r:initrc_exec_t
>  /etc/nologin.*         --      system_u:object_r:etc_runtime_t
>  /etc/nohotplug         --      system_u:object_r:etc_runtime_t
> -/halt                  --      system_u:object_r:etc_runtime_t
> -/\.autofsck            --      system_u:object_r:etc_runtime_t
>
> Why remove these?

I had moved them to rpm.fc.  But it would probably be more appropriate to have 
ifdef(`distro_redhat' around those two lines and leave them in the same file.

Debian doesn't have such files, and I suspect that Gentoo doesn't either.  
Those lines would be either Red Hat specific or Red Hat and SUSE specific.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
