Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LKEIWt029906
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 16:14:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LKEHIE017694
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 20:14:17 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9LKED1J017673 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 20:14:16 GMT
Date: Tue, 21 Oct 2003 22:14:06 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
Message-ID: <20031021201406.GA32035@wavehammer.waldi.eu.org>
References: <200310200148.15852.russell@coker.com.au> <200310220043.09925.russell@coker.com.au> <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil> <200310220200.35514.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310220200.35514.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 22, 2003 at 02:00:35AM +1000, Russell Coker wrote:
> #!/bin/sh
> 
if [ $$ = 1 ]; then
if [ ! -e /proc/self ]; then
>   mount -n /proc
> fi
> grep -q selinuxfs /proc/filesystems || exec /sbin/init.real "$@"
> if [ ! -f /selinux/enforce ]; then
hmm? you check for the non-existance first and for existance later
>   mount -n /selinux
>   /usr/sbin/load_policy /etc/security/selinux/policy.15
>   if [ -f /selinux/enforce ]; then
>     echo 1 > /selinux/enforce
>   else
>     echo "Can't set enforcing mode"
>   fi
isn't enforcing mode set according to the compiletime flags?
> fi
fi
> exec /sbin/init.real "$@"

bastian

-- 
Warp 7 -- It's a law we can live with.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
