Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GHfnL9017623
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 12:41:51 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GHcDNj012570
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 17:38:13 GMT
Date: Wed, 16 Feb 2005 17:50:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216175027.GZ31121@lkcl.net>
References: <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net> <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil> <20050216134457.GL31121@lkcl.net> <20050216152644.GU31121@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050216152644.GU31121@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

just fyi: this is an actual real-world deployment of SE/Linux for
a Bastion Server, where it is necessary to restrict which users
may sftp in and upload files on the box - and also to restrict
the users to only one particular directory - _and_ also to restrict
which IP addresses those users can come in on.

so it's actually quite an exciting project.

bearing in mind that it is possible to compromise or just
absent-mindedly or otherwise in a blaze fashion copy ssh
private keys (esp. amongst security-unconscious users) it
becomes necessary to restrict one set of sftp users from being
able to sftp in to another customer's upload directory.

yes, the iptables approach works fine - right up to the point
where you run out of virtual interfaces because of the number
of different customers that the Bastion Server is supporting.

l.

On Wed, Feb 16, 2005 at 03:26:45PM +0000, Luke Kenneth Casson Leighton wrote:
> stephen, i believe i have enough to go on, now: thank you for your
> help, even if it's not entirely clear what i want to achieve here :)
> 
> i aim to add a setcon() into sshd's "input_userauth_request()"
> function just after the point where the username is obtained,
> such that any unauthorised IP addresses for that username will
> immediately stop any further TCP traffic.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
