Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JHhxgA008556
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 13:43:59 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JHdg3G008693
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 17:39:42 GMT
Subject: Re: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Ulrich Drepper <drepper@redhat.com>
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <42DD2773.5010408@redhat.com>
References: <1121784944.4022.39.camel@celtics.boston.redhat.com>
	 <42DD18CE.1030706@redhat.com>
	 <1121787506.27838.17.camel@celtics.boston.redhat.com>
	 <42DD211B.9070400@redhat.com>
	 <1121788758.27838.25.camel@celtics.boston.redhat.com>
	 <42DD2773.5010408@redhat.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 13:36:12 -0400
Message-Id: <1121794572.4780.15.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > The plan is to have pam and other login programs use this interface
> > for reading, and useradd and libuser for writing in the flat file case
> > (put interface). 
> 
> Put interfaces never have been in nss.  So the total number of programs
> and DSOs which need this functionality is what?  2, 3?
>
> This does not warrant adding so much code into glibc.
> 
> 
> > We could put this code in libselinux. In fact, that's what I did 
> > originally, and that generated complaints that libselinux wouldn't
> > be able to handle all the future backends, and that it would
> > be better if it shared code with nss to communicate with ldap.
> 
> Why thinking about different backends?  The reason for nss is not that
> it is hip and cool to have a gazillion services.  The reason is that
> there are many preexisting installations and cross-platform
> considerations which make it impossible to use one service only.
> 
> This isn't the case here.  You can very well demand that there are
> exactly two formats: flat file (optional) and an LDAP map.  I don't see
> there being NIS/NIS+ maps, Hesiod is not really important (or even
> extensible, I think).  Which leaves LDAP.
> 
> And how often do login apps run?  It is not really absolutely necessary
> to have caching.
> 
> 
> So, what I suggest is that you add some code to libselinux.  Use flat
> file and LDAP.  Try using it in the programs which need the information.
>  If there are real problems with this approach, e.g., the number of
> programs is really higher or the performance is really bad, then we can
> talk about this again.  But adding this code without any real
> justification isn't going to fly.

What are other people's thoughts on this subject (cc-ed selinux list).
I'd like to reach some level of agreement here. What you're saying 
makes sense to me, but again, I started looking at adding an nss service
in response to an upstream request/discussion - we want our code for
user management to be accepted upstream. 

Karl? Steven?

The alternative is to put this code into libsemanage, for which
I already have most of the implementation. I think from RedHat's point
of view LDAP is important, since we'd like to better integrate 
SELinux with the directory server. I'm not sure about other backends.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
