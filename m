Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1HLa1dW002029
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 16:36:02 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1HLWDqo026688
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 21:32:14 GMT
Date: Thu, 17 Feb 2005 21:44:33 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Peter K. Lee" <saint@corenova.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050217214433.GC6136@lkcl.net>
References: <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net> <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil> <20050216134457.GL31121@lkcl.net> <20050216152644.GU31121@lkcl.net> <20050216175027.GZ31121@lkcl.net> <1108576757.26442.72.camel@snap3401>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108576757.26442.72.camel@snap3401>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 09:59:17AM -0800, Peter K. Lee wrote:
> Luke, I was wondering why you can't use sshd_config like this:
> 
> AllowUsers \
> 	restricted_user1@192.168.0.223 \
> 	restricted_user2@192.168.0.224 \
> 	...
 
 hey, that's a good idea.  duh :)

> Also, wouldn't using SE/Linux to do per/user/IP ACL, you need an entry
> in the policy (file?) for every user?  

 well, in my case, ever user role, but yes.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
