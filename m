Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9E3wc2g016381
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 23:58:38 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9E3vKOI019083
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 03:57:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: gdm ubuntu 8.10
Date: Tue, 14 Oct 2008 13:58:32 +1000
Cc: "SE Linux" <selinux@tycho.nsa.gov>
References: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com> <dd18b0c30810121424k5aa67d2me25d451166279706@mail.gmail.com> <dd18b0c30810132048s7b1d0263xea6d86bbd6dbee35@mail.gmail.com>
In-Reply-To: <dd18b0c30810132048s7b1d0263xea6d86bbd6dbee35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810141458.32532.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 14 October 2008 14:48, "Justin Mattock" <justinmattock@gmail.com> 
wrote:
> So after using user_r(which I feel is more safe);
> I'm noticing I can't login to sysadm_r.

That is by design, role transitions to sysadm_r are only permitted from 
staff_r, system_r, and unconfined_r.

> This role seems to be safe in a corporate environment,
> but in my case I'm the only user on this machine as well as
> the admin.

Then staff_r may be a better choice for your logins.

Of course there's nothing stopping you from using a ssh client in user_r to 
connect to a staff_r session (or sysadm_r if you set a boolean to allow 
sysadm_r ssh logins).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
