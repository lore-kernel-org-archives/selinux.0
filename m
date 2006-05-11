Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4BDjVe6009550
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 09:45:31 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4BDjUcm004709
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 13:45:30 GMT
Received: by wr-out-0506.google.com with SMTP id 50so134567wri
        for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 06:45:30 -0700 (PDT)
Message-ID: <a9951d2a0605110645v42cb9987ucb697d866cae8960@mail.gmail.com>
Date: Thu, 11 May 2006 21:45:30 +0800
From: "Rogelio Serrano" <rogelio.serrano@gmail.com>
To: russell@coker.com.au
Subject: Re: pam_namespace
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200605051623.25533.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605051623.25533.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

separate namespaces is somewhat similar to selinux/dte and clashes
with it. i dont think we can mix selinux with separate namespaces as
it is right now.

On 5/5/06, Russell Coker <russell@coker.com.au> wrote:
> I was just playing with pam_namespace.  It seems to me that the current setup
> of having tmp/tmp.inst-$USER- does not provide adequate protection.  A
> process that is hostile to the user and which runs in the system name space
> (EG any cracked daemon) can access the user's instance of /tmp.
>
> If we had tmp/tmp.inst-$USER-/tmp (or something similar) and
> gave /tmp/tmp.inst-$USER- permission mode 000 (and something equivalent in
> terms of SE Linux access) then processes in the global name space would not
> be able to try anything.
>
>
> PS  I am posting here because I am no longer subscribed to the LSPP list.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


-- 
www.smsglobal.net SMS Global Ltd Short Message Service For Seafarers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
