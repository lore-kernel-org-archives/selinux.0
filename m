Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9OJwYXZ028815
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2004 15:58:34 -0400 (EDT)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9OJvHc9029287
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2004 19:57:17 GMT
Received: by rproxy.gmail.com with SMTP id 77so354307rnk
        for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2004 12:57:58 -0700 (PDT)
Message-ID: <42efd06904102412571e81d4e1@mail.gmail.com>
Date: Sun, 24 Oct 2004 12:57:58 -0700
From: Ryan Graham <ryan.graham@gmail.com>
Reply-To: ryan.graham+cr@gmail.com
To: Rene Cunningham <rene@dclabs.com.au>
Subject: Re: login as sysadm_r remotely
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20041023112327.GW8603@eden.office.dclabs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20041023112327.GW8603@eden.office.dclabs.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think they built a toggle for this into tunable.te. At least it is
there in whatever version I am running on fedora.


On Sat, 23 Oct 2004 21:23:27 +1000, Rene Cunningham <rene@dclabs.com.au> wrote:
> Gday,
> 
> Im trying to allow remote logins via ssh as root to use the sysadm_r role
> by default. At the moment root logs in using staff_r and newrole -r needs
> to be executed. I do want to force logins via tty's to default to
> staff_r though.
> 
> Looking at /etc/selinux/context/root_default_contexts i just need to
> unhash the following
> 
> system_r:sshd_t sysadm_r:sysadm_t staff_r:staff_t user_r:user_t
> 
> I rebuild the policy, though root still logs in as staff_r via ssh.
> 
> Im running debian with selinux-policy-default 1.14-2.
> 
> How do i enable this?
> 
> --
> 
> Rene Cunningham
> DCLabs Pty Ltd
> http://www.dclabs.com.au
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
