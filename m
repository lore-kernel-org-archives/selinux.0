Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4II3XRb004046
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:03:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4II3TAR010855
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:03:29 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4II3RHn010693 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:03:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Date: Wed, 19 May 2004 04:02:16 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
References: <20040518104026.GC24333@lkcl.net> <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil> <20040518151112.GF24917@lkcl.net>
In-Reply-To: <20040518151112.GF24917@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190402.16586.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 01:11, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  /usr/bin/[xgkw]dm       -- system_u:object_r:xdm_exec_t
>
>  therefore, the programs gdm, xdm, kdm and wdm all have type xdm_exec_t
>  therefore, according to line 24 of domains/programs/xdm.te, gdm,
>  xdm, kdm and wdm are all allowed to automatically transition from
>  the initialisation context into a new context named xdm_t.

Yes, and they can also transition from initrc_t by line 21.  This is important 
because in Debian xdm is not started directly from init.

>  therefore, the programs gdm, xdm, kdm and wdm are all allowed to do
>  the things that are mentioned as allow xdm_t etc.

Yes.

>  okay, just a guess: when you declare an allow, are the relevant
>  permissions added or replaced if there already exists, say,
>  allow xdm_xserver_t var_lib_t:file { read };

Added.

>  and i then add, in a following line to policy.conf :
>  allow xdm_xserver_t var_lib_t:file { getattr };
>
>  do i end up with _only_ getattr permissions or do i end up
>  with both read _and_ getattr?

Both.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
