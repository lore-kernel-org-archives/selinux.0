Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l299JwnX011393
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 04:19:58 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l299JsRB009211
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 09:19:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: radvd policy changes
Date: Fri, 9 Mar 2007 09:50:10 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <48DF9C2F-73CF-4657-91AD-A6E1F3BD4A2E@sf-net.com>
In-Reply-To: <48DF9C2F-73CF-4657-91AD-A6E1F3BD4A2E@sf-net.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703090950.11945.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 08 March 2007 02:41, Stefan Schulze Frielinghaus 
<stefan@sf-net.com> wrote:
> radvd needs ioctl perms for the configfile (/etc/radvd.conf)
>
> < allow radvd_t radvd_etc_t:file { getattr read };
> ---
>
>  > read_files_pattern(radvd_t,etc_t,radvd_etc_t)

It probably doesn't actually need ioctl permissions, in most such cases the 
program uses a library that does an ioctl to determine whether it's talking 
to a terminal device (which could be achieved just as easily through 
fstat()).  But it doesn't do any harm to add it.

> Another problem may only concern to Debian distributions. The init-
> script for radvd cleans a file (/var/run/radvd/saved-settings) and
> needs special privileges to do the work. audit2allow output:
>
> allow initrc_t radvd_var_run_t:dir add_name;
> allow initrc_t radvd_var_run_t:file { append create };
>
> What is the suggested SELinux way to handle such a situation? Deny
> and don't care? A "ifdef(`distro_debian'" and allow init to do the job?

It doesn't do any harm to add this for all distributions.  In Fedora initrc_t 
is given all this and more through unconfined_domain()...

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
