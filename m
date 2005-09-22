Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8MGPJNs021081
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 12:25:20 -0400 (EDT)
Received: from smtp103.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j8MGKms8003808
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 16:20:48 GMT
Message-ID: <4332D995.1060200@sbcglobal.net>
Date: Thu, 22 Sep 2005 11:19:33 -0500
From: Lee Lowder <friedbob@sbcglobal.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Getting started with SELinux and Slackware
References: <43325C75.3060405@sbcglobal.net> <200509221935.06357.russell@coker.com.au>
In-Reply-To: <200509221935.06357.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> 
> If Slackware doesn't include PAM then it will be quite a lot of work to add 
> PAM support to all necessary applications.
> 

Last time I tried messing with SELinux on Slack, I was told that it 
would be easier to install PAM than to modify SELinux stuff to not use it.

> It would probably be easier to modify the policy to remove *_chkpwd_t and 
> grant every daemon that needs to verify a password read access to 
> shadow_t:file.

That does not seem too difficult or complicated, so I will give that a go.

> 
> Why do you want to work on Slackware?  It seems to be a regular occurrance 
> that someone starts work on Slackware SE Linux support, their work doesn't 
> get merged into the Slackware distribution, and then it gets discarded.

Slackware is the distro I use, and have used for years.  I know it and 
amcomfortable with it.  the thought of asking Pat V to merge it never 
crossed my mind, actually.  I'm doing this because it was something I 
wanted to play with and as a learning experience.

> 
> While Debian SE Linux support isn't in the greatest shape at the moment the 
> changes are getting merged into the main packages so any work you do won't 
> get wasted.
> 
> Of course you could just use Fedora and have it all work.
> 
Would the "it just works" thing apply to CentOS as well?  Or does RHEL 
not have the same level of SELinux support as Fedora?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
