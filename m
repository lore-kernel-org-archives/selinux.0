Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GJiDL9019597
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 14:44:13 -0500 (EST)
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j1GJgdfu022789
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 19:42:54 GMT
Subject: Re: sshd transition points
From: "Peter K. Lee" <saint@corenova.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050216175027.GZ31121@lkcl.net>
References: <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net>
	 <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net>
	 <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
	 <20050216134457.GL31121@lkcl.net> <20050216152644.GU31121@lkcl.net>
	 <20050216175027.GZ31121@lkcl.net>
Content-Type: text/plain
Message-Id: <1108576757.26442.72.camel@snap3401>
Mime-Version: 1.0
Date: 16 Feb 2005 09:59:17 -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke, I was wondering why you can't use sshd_config like this:

AllowUsers \
	restricted_user1@192.168.0.223 \
	restricted_user2@192.168.0.224 \
	...

Also, wouldn't using SE/Linux to do per/user/IP ACL, you need an entry
in the policy (file?) for every user?  And the policy can be reloaded
during run-time of the system every time it gets modified?  (sorry, I
have _no_ idea how SE/Linux works yet...)

-Peter



On Wed, 2005-02-16 at 09:50, Luke Kenneth Casson Leighton wrote:
> just fyi: this is an actual real-world deployment of SE/Linux for
> a Bastion Server, where it is necessary to restrict which users
> may sftp in and upload files on the box - and also to restrict
> the users to only one particular directory - _and_ also to restrict
> which IP addresses those users can come in on.
> 
> so it's actually quite an exciting project.
> 
> bearing in mind that it is possible to compromise or just
> absent-mindedly or otherwise in a blaze fashion copy ssh
> private keys (esp. amongst security-unconscious users) it
> becomes necessary to restrict one set of sftp users from being
> able to sftp in to another customer's upload directory.
> 
> yes, the iptables approach works fine - right up to the point
> where you run out of virtual interfaces because of the number
> of different customers that the Bastion Server is supporting.
> 
> l.
> 
> On Wed, Feb 16, 2005 at 03:26:45PM +0000, Luke Kenneth Casson Leighton wrote:
> > stephen, i believe i have enough to go on, now: thank you for your
> > help, even if it's not entirely clear what i want to achieve here :)
> > 
> > i aim to add a setcon() into sshd's "input_userauth_request()"
> > function just after the point where the username is obtained,
> > such that any unauthorised IP addresses for that username will
> > immediately stop any further TCP traffic.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
