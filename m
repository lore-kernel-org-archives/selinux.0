Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4NI0Qk3022264
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 14:00:26 -0400
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4NI0PPV012987
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 18:00:25 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Takesi satoh" <t_mail@mail2Airport.com>
Subject: Re: netif and node check in RHEL5
Date: Fri, 23 May 2008 14:00:16 -0400
Cc: selinux@tycho.nsa.gov
References: <0a0001c8bcf7$3aa64ba0$036a010a@mail2world.com>
In-Reply-To: <0a0001c8bcf7$3aa64ba0$036a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805231400.16682.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 23 May 2008 1:05:40 pm Takesi satoh wrote:
> Hello Paul,
>
> Thank you for your reply,
>
> > # echo 1 > /selinux/compat_net
>
> It works fine!
> Again, thank you very much.

I'm glad that solved your problem.  I would still encourage you to 
transition your systems to secmark as the compat_net controls are 
considered "deprecated" and may go away in the future.  In addition, 
you should notice better performance with secmark versus compat_net.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
