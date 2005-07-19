Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JJtPgA010199
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:55:25 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JJoMZb018418
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 19:50:22 GMT
Message-Id: <200507191950.j6JJotvx014893@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: SElinux nss/nscd service
Date: Tue, 19 Jul 2005 15:50:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1121801122.7252.15.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Tuesday, July 19, 2005 3:25 PM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; 'Ulrich Drepper'; selinux@tycho.nsa.gov
> Subject: RE: SElinux nss/nscd service
> 
> 
> > This is different - managing the users as an admin is going to be backend
> > specific. Everything that you list is local files specific, right?
> 
> Just because passwords are done that way doesn't necessary mean we want
> the selinux map to work that way.

Yes it does - the whole goal of this is to enable user information to be managed
however the backend wants. Centralized user management means that it is
centralized completely. Admins aren't going to be very happy when their ldap
directory manages users just great except they have to go to every selinux
machine and run some program or edit some random text file. One of the main
points of this user suggestion is that user information _must_ be able to be
centralized or we will break things like ldap.

 I don't see why it has to be backend
> specific (but then again, I'm sure there's probably a reason,
> or glibc would provide a backend independent write interface for pwd).
> 
> In any case, backend specific or not, I don't plan to reimplement the
> read/write code in 10 places, so it should go in a library, not in pam.
> 
> 

It doesn't matter whether it is a library or not, it matters whether this is a
public api upon which applications will start to depend. Putting this in
libselinux means that we are stuck with the api for _years_.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
