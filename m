Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k79DuGuU001779
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 09:56:16 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k79Du5FH026151
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 13:56:05 GMT
Subject: re: id -Z subsumed by secon?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Meyering <meyering@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44D8DED5.4040304@redhat.com>
References: <44D8DED5.4040304@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 09:55:55 -0400
Message-Id: <1155131755.942.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-08 at 14:58 -0400, Daniel J Walsh wrote:

> >
> > Thanks for the example.
> >
> > By the way, doesn't secon make id's -Z option unnecessary?
> > I'm planning not to include the 'id -Z' patches upstream,
> > Instead, runcon (with neither CONTEXT nor COMMAND) will
> > print the current security context -- to be analogous to how nice(1)
> > works if you don't give it a command.
> >
> > Any objection?
> >
> >
> >   
> Yes I would like to maintain the idea of "-Z" being the way to view 
> contexts.  This makes it easy for
> a user to figure out how to see what context is being used.  ls -Z, ps 
> -Z, netstat -Z ...
> 
> 

Jim - I didn't see a response on this so I thought I would go ahead and
agree with Dan here. All of the "-Z" options have been documented for
_years_ - removing them now would be a real hardship on users.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
