Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QEpTBi003339
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 10:51:30 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/4] libsemanage -- fallback-user-level
Date: Tue, 27 Mar 2012 01:51:21 +1100
Cc: selinux@tycho.nsa.gov
References: <20120326155749.4003f8fd@eldamar.bigon.be>
In-Reply-To: <20120326155749.4003f8fd@eldamar.bigon.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203270151.22387.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Mar 2012, Laurent Bigonville <bigon@debian.org> wrote:
> I've no rational and no original author about this patch.

That would be mine.  Having magic numbers in the code is a bad idea, using a 
macro is better.

> 
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -863,7 +877,7 @@
>  			level = semanage_user_get_mlslevel(*u);
>  		} else {
>  			prefix = name;
> -			level = "s0";
> +			level = FALLBACK_USER_LEVEL;
>  		}
> 
>  		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
