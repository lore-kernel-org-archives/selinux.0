Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07709
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 12:09:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA00363
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 17:06:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA00357
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 17:06:44 GMT
Date: Thu, 5 Dec 2002 12:08:04 -0500 (EST)
From: Chris Vance <cvance@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200212031610.12318.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0212051206030.25186-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Dec 2002, Russell Coker wrote:

> diff -ruN /tmp/policy/domains/program/hwclock.te ./domains/program/hwclock.te
> --- /tmp/policy/domains/program/hwclock.te      2002-12-03 15:56:40.000000000
> +0
> 100
> +++ ./domains/program/hwclock.te        2002-08-21 20:22:44.000000000 +0200
> @@ -45,3 +45,5 @@
>  allow hwclock_t ptyfile:chr_file rw_file_perms;
>  ifdef(`gnome-pty-helper.te', `allow hwclock_t sysadm_gph_t:fd use;')
>
> +# hwclock needs to search file_t directories when run from rc.sysinit on RH8
> +allow hwclock_t file_t:dir search;
>
> For the above change that's recently committed, shouldn't it have
> ifdef(`rpm.te', around it?

I'm just curious why you think this is necessary?  If anything I would
have thought something more along the lines of ifdef(`hwclock.te',...)
would be appropriate.  Neither are really specific to RH systems, and the
permission itself isn't that critical.

Thanks,

chris.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
