Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VHZIDo027031
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 12:35:18 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VHXviv024324
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 17:33:57 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050331160546.36303.qmail@web31615.mail.mud.yahoo.com>
References: <20050331160546.36303.qmail@web31615.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 12:40:01 -0500
Message-Id: <1112290802.12948.29.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > 3) If they're not changed, it doesn't matter,
> > because what I'm proposing
> > is backwards compatible. User_t will still have
> > access to all content
> > types, and can write stuff to /home as user_home_t.
> 
> But ...
> 
> > Apps will have to be
> > specifically confined in order not to be able to
> > write to user_home_t.
> > If some app is a problem, it can be left to run at
> > user_home_t for now.
> 
> ... then what's your whole point? I mean,
> why this whole line about structuring where
> user data goes?

Because then certain applications can be constrained further than
they are constrained right now. They will be revoked privileges
to user_home_t, and you will have a more secure system, since exploits
of that app will not affect data in the user_home_t domain.

Specifically, the download folder is most important to implement, as
the target folder for any potentially hostile content.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
