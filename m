Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA10192
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 16:56:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA01149
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 20:55:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA01145
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 20:55:40 GMT
Date: Tue, 10 Apr 2001 16:56:01 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200104102056.QAA00629@coalstove.epoch.ncsc.mil>
To: bcarver2@austin.ibm.com
Subject: Re: I would like to help.
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would suggest sending the patches to this list (a tarred gziped
attachment should work). That will ensure everyone has the ability to
review them and perhaps use them as a base for other work.  We'll see
them here as well and see what we can do about including them in a future
release.  Of course, it makes life easier for everyone if you make
sure that the code and your mail message makes clear that you are the
author and that you're releasing your changes under the GPL.

I would personally be interested in hearing about your experience
porting, (i.e., what you had to change and any problems you had) since
you're the first person I'm aware of to port selinux to another
architecture.  I'm sure other potential porters on the list might also
be interested.

> From: bcarver2@austin.ibm.com
> Date: Tue, 10 Apr 2001 15:21:45 -0500
> To: Howard Holm <hdholm@epoch.ncsc.mil>
> CC: selinux@tycho.nsa.gov
> Subject: Re: I would like to help.
> 
> Howard,
> 
> I have ported Flask for Linux 2.4.2 version to the PowerPC
> (an IBM 44P-270 POWER3 server, to be specific, although
> the changes should be generic enough to run on any PowerPC
> platform).  Where should I send the patches?
> 
> Howard Holm wrote:
> 
> > For those who want to contribute, I would personally suggest looking at
> > the future work list <http://www.nsa.gov/selinux/todo.html> for some
> > potentially interesting things to work on, and the papers in
> > <http://www.nsa.gov/selinux/docs.html> for design information.  I strongly
> > urge you, or anyone, who wants to work on something to keep the list
> > informed about what you are doing and your progress.  This will help
> > people with similar interests coordinate, avoid duplication of effort, and
> > potentially allow other developers to offer advice
> >
> > --
> > Howard Holm <hdholm@epoch.ncsc.mil>
> > Information Assurance Research Office
> > National Security Agency
> >
> 
> --
> Bob Carver
> 
> ``Being politically correct means always having to say you're sorry.''
> --Charles Osgood

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
