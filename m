Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7CEMMu8001031
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 10:22:22 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7CEM3mk016581
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 14:22:03 GMT
Message-ID: <44DDE41A.3080600@tresys.com>
Date: Sat, 12 Aug 2006 10:22:18 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] fixfiles: fix test for $LOGFILE
References: <Pine.LNX.4.64.0608121008560.14758@d.namei>
In-Reply-To: <Pine.LNX.4.64.0608121008560.14758@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> Please apply.
>
> ---
>
> --- fixfiles.orig	2006-08-12 00:52:22.000000000 -0400
> +++ fixfiles	2006-08-12 10:07:30.000000000 -0400
> @@ -48,7 +48,7 @@
>  # Log to either syslog or a LOGFILE
>  #
>  logit () {
> -if [ -z $LOGFILE ]; then
> +if [ ! -z $LOGFILE ]; then
>      echo $1 >> $LOGFILE
>  fi
>  }
>   
Why not if [ -n $LOGFILE ]; then ?

 From man bash:
       -z string
              True if the length of string is zero.
       string
       -n string
              True if the length of string is non-zero.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
