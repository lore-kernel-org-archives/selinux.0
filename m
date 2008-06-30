Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UHwKP4006020
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 13:58:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5UHwKhx004743
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 17:58:20 GMT
Message-ID: <48691EB3.30706@manicmethod.com>
Date: Mon, 30 Jun 2008 13:58:11 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds permissive to semanage
References: <4869037D.5040208@redhat.com>
In-Reply-To: <4869037D.5040208@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Gives users the ability to set a domain as permissive
> 
> 
> semanage permissive -a http_t
> 
> It created a policy module named permissive_httpd_t.pp with the
> permissive call.
> 

So, a really quick glance brings up a couple issues. First you have '-n', '--noheading' which aren't documented in the man page or elsewhere. Second (and more importantly) why are you executing semodule like that? libsemanage is the library that manages modules, and also the library used by semanage for everything else. 

I would prefer a more 'pure' approach where we keep a list of permissive types and inject them into the kernel policy after linking (like libsemanage does with users, ports, nodes, etc) but I understand that adding a whole new set of databases and interfaces is both annoying and time consuming so I'm fine with it working on modules, I'd just like to see it using libsemanage interfaces instead of calling semodule.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
