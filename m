Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V8cADo022930
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 03:38:10 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V8Y9Tg009208
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 08:34:09 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Tom <tom@lemuria.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050330235010.B622@lemuria.org>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com>
	 <1112199204.8592.13.camel@cobra.ivg2.net> <20050330235010.B622@lemuria.org>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 03:42:47 -0500
Message-Id: <1112258567.10137.44.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> People who use Linux for their desktop usually enjoy one thing: That
> they can sort things according to _their_ needs, not according to
> whatever some "expert" in Redmond has prescribed.

It's hard to think of a plan that confines desktop applications, if
people want to do whatever they'd like with their system, not caring
about file placement. I had the same opinion about a year ago when
SElinux started restricting what I do with my files outside ~/home - 
I had a folder called /data, and now that wouldn't be accessible 
the way I expected. I wasn't too happy about it, but since then I've 
accepted that it's necessary for me to change my expectations a bit.

The root user already can't do whatever he wanted to before - there's
an expected schema that he/she must follow in order for things to work -
expected placement of system files. This is just extending that
restriction to the /home folder.

If you have a better proposal...

> Define the roles, but don't define the directories. If I want my
> downloads in ~/Downloads/ and not in ~/content/downloads/ there is no
> reason not to allow me that.

Well, If you want to create ~/Downloads and label it with the proper
context manually, there wouldn't be anything to stop you, and that 
should work. However, I think a folder should already exists, which is
properly labeled, so a user wouldn't have to figure out how to do this
by themselves.

> Plus, I still don't dig your "content" idea. First, it's a marketing
> buzzword abstraction with zero meaning for regular folks. Two, are you
> kidding me? How much "non-content" do you think I store in my $HOME to
> give "content" it's own subdirectory?

You store .bashrc, .bash_profile, .xauth files, configuration files, 
secret gpg keyrings... Those are all things I wouldn't describe as
content. If it's hidden, then I wouldn't consider it content.
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
