Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQDCXZ3029828
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 08:12:34 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAQDCWMA002298
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 13:12:33 GMT
Subject: Re: semodule -i postgresql.pp fails on F8
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820711222214i46474da1ucd1b402fbbc9d38d@mail.gmail.com>
References: <f71a82820711222214i46474da1ucd1b402fbbc9d38d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 08:11:59 -0500
Message-Id: <1196082719.20918.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-23 at 15:14 +0900, Shintaro Fujiwara wrote:
> I got src package of selinux-policy-3.0.8
> 
> #cd serefpolicy-3.0.8/policy/modules/services
> #make -f /usr/share/selinux/devel/Makefile postgresql.pp
> #semodule -i postgresql.pp
> 
> libsepol.scope_copy_callback: postgresql: Duplicate declaration in
> module: type/attribute postgresql_var_run_t
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!
> 
> 
> I doubted that in base.pp having postgresql ( it should not have, though)

>From what I see in the Fedora CVS, postgresql is in the base module.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
