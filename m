Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6P4TUgA020399
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 00:29:32 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6P4NTAP012786
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 04:23:29 GMT
Date: Mon, 25 Jul 2005 00:24:08 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, gyurdiev@redhat.com,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
In-Reply-To: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>
Message-ID: <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 24 Jul 2005, Casey Schaufler wrote:

>> IPsec is likely the best way to do this
>
> IPsec is an important part of the "correct" solution but it requires 
> that the application is aware of IPsec and takes advantage of it and can 
> be trusted to do so properly.

I was referring to the IPsec labeling scheme from Trent Jaeger, which 
should not require any modification of the web servers.

> There are many examples (web serving is one) of applications that you 
> don't really want to muck with the internals of (and the maintainers 
> ain't gonna let you anyhow) that work just fine in a server-per-label 
> scheme. At least, that's true for B&L+Biba. There are many deployed 
> examples, which is where I suspect the original questino can from.

Yes, I was thinking of server per level, where IPsec labeling is used to 
enforce security policy across the network.


- James
-- 
James Morris
<jmorris@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
