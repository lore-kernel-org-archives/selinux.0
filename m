Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GJrGrT027766
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 15:53:16 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GJqK8m011152
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 19:52:20 GMT
Subject: Re: SELinux policy discussion.
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1095356254.4231.188.camel@nexus.verbum.private>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
	 <1095307503.4231.152.camel@nexus.verbum.private>
	 <1095318426.32510.30.camel@localhost.localdomain>
	 <1095356254.4231.188.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Thu, 16 Sep 2004 15:53:09 -0400
Message-Id: <1095364389.10058.85.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > While you can establish exactly what the requirements of an application
> > are and write a policy for it, I'm not sure you can establish exactly
> > what the requirements of user_t are. There's a whole range of things
> > user_t could decide to do. That's why it seems to me that the policy to
> > adhere to when it comes to user_t should be compatible with Unix
> > permissions.
> 
> I completely disagree.  The strict policy is always going to be more
> restrictive than Unix permissions for users.  That's the point of it.
> If you don't want that, use the targeted policy.

I guess that's my mistake. I thought the purpose of the strict policy 
was not to additionally restrict the behavior of the user, but to take
away privileges that applications do not use (when operating properly),
therefore do not need. 

What I want from MAC is to restrict my applications while preserving
100% useful functionality and being transparent. I don't want more
restrictions on my behavior. I don't want to be told that I can't use 
mozilla as a file browser, because it's supposed to be a web browser.
I don't want mozilla_readhome and mozilla_writehome that are false by 
default so I can't save a web page to my home folder. In other words I
don't necessarily like the "deny by default" policy on what I can do - I
only want that to apply to individual programs. Maybe that's what
Stephen Smalley means by "fundamental misunderstanding of mandatory
access control" - I'll have to finish reading that paper to see.


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
