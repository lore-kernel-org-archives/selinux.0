Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6OJkNs1005271
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 15:46:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6OJkMXQ027358
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 19:46:22 GMT
Subject: Re: Additional permission checks for nscd
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4694FDA6.3060603@redhat.com>
References: <4694FDA6.3060603@redhat.com>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 15:46:14 -0400
Message-Id: <1185306374.24951.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-11 at 11:56 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/flask/access_vectors  2007-06-19 16:23:34.000000000 -0400
> +++ serefpolicy-3.0.2/policy/flask/access_vectors       2007-07-11 10:06:28.000000000 -0400
> @@ -598,6 +598,8 @@
>         shmempwd
>         shmemgrp
>         shmemhost
> +       getserv
> +       shmemserv
>  }
>  
>  # Define the access vector interpretation for controlling

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
