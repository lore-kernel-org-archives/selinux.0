Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JIaIgA009132
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:36:18 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JIPTZb005302
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 18:25:29 GMT
Message-Id: <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Ulrich Drepper'" <drepper@redhat.com>
Cc: <selinux@tycho.nsa.gov>, <dwalsh@redhat.com>
Subject: RE: SElinux nss/nscd service
Date: Tue, 19 Jul 2005 14:25:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1121794572.4780.15.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Tuesday, July 19, 2005 1:36 PM
> To: Ulrich Drepper
> Cc: kmacmillan@tresys.com; selinux@tycho.nsa.gov; dwalsh@redhat.com
> Subject: Re: SElinux nss/nscd service
> 
> >
> > So, what I suggest is that you add some code to libselinux.  Use flat
> > file and LDAP.  Try using it in the programs which need the information.
> >  If there are real problems with this approach, e.g., the number of
> > programs is really higher or the performance is really bad, then we can
> > talk about this again.  But adding this code without any real
> > justification isn't going to fly.
> 
> What are other people's thoughts on this subject (cc-ed selinux list).
> I'd like to reach some level of agreement here. What you're saying
> makes sense to me, but again, I started looking at adding an nss service
> in response to an upstream request/discussion - we want our code for
> user management to be accepted upstream.
> 
> Karl? Steven?
> 
> The alternative is to put this code into libsemanage, for which
> I already have most of the implementation.

Libsemanage is the wrong place for this - if login and ssh have to link to
libsemanage we have failed to properly separate the functionality of these
libraries.

> I think from RedHat's point
> of view LDAP is important, since we'd like to better integrate
> SELinux with the directory server. I'm not sure about other backends.
> 
> 

Well, as I've said before I think that it is ridiculous to have to add backend
code into libselinux. The number of backends considered important now might be
small, but that might not always be true. I'm concerned about:

1) Duplicating code with PAM / NSS (and general feature / size creep of
libselinux).
2) Forcing configuration of PAM, NSS, and libselinux to switch from one backend
to another. 

I'm trying to draw a strong conceptual line here: SELinux should not know about
specific Linux users. We may have to back down from this, but hopefully not yet.
I'm _not_ concerned about performance - this will probably only be done at login
so it won't happen often. Is PAM really so pitiful that it can't return
arbitrary extra data about a user at authentication that login can use? If there
is no other place to put this, then I'm not going to object to putting it into
libselinux, but I think it is a pragmatic hack at best.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
