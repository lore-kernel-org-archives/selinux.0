Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DA2TWt013325
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 06:02:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9DA2SUb020552
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 10:02:28 GMT
Received: from johanna5.ux.his.no (johanna5.ux.his.no [152.94.1.25])
        by jazzband.ncsc.mil  with ESMTP id h9DA2RhX020549 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 10:02:27 GMT
Date: Mon, 13 Oct 2003 14:02:18 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Users are not assigned correct security context on login
Message-ID: <20031013120218.GB14227@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <20031013110626.GA10270@badne3.ux.his.no> <200310131950.09485.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200310131950.09485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Thanks for your reply

On 10/13/03 19:50, Russell Coker wrote:
> On Mon, 13 Oct 2003 21:06, Erlend Aasland wrote:
> > However, after doing a "make reload", rebooting and logging in as root,
> > "id" shows this:
> > uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:user_t
> 
> It looks like you have not installed the SE Linux patched /bin/login or the SE 
I've successfully applied the SELinux patches to util-linux, so
/bin/login should be ok. I will give the PAM module a try and see if it
helps.

Regards,
	Erlend Aasland
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
