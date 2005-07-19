Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JL3YgA010956
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 17:03:34 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JKxF3G005959
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 20:59:15 GMT
Message-Id: <200507192059.j6JKx2vx016238@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ulrich Drepper'" <drepper@redhat.com>
Cc: <gyurdiev@redhat.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   <selinux@tycho.nsa.gov>
Subject: RE: SElinux nss/nscd service
Date: Tue, 19 Jul 2005 16:59:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
In-reply-to: <42DD61A1.9010805@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ulrich Drepper [mailto:drepper@redhat.com]
> Sent: Tuesday, July 19, 2005 4:25 PM
> To: Karl MacMillan
> Cc: gyurdiev@redhat.com; 'Daniel J Walsh'; selinux@tycho.nsa.gov
> Subject: Re: SElinux nss/nscd service
> 
> Karl MacMillan wrote:
> 
> > It doesn't matter whether it is a library or not, it matters whether this is
> a
> > public api upon which applications will start to depend.
> 
> There are only a handful of apps and all come with the system.
> 

Somewhere the context of this discussion was lost or I was just being unclear - I was referring the administrative code for adding / modifying users. Not for authentication / retrieving user information. For the admin interfaces there can be an arbitrary number of applications.

> 
> > Putting this in
> > libselinux means that we are stuck with the api for _years_.
> 
> And putting the interface with these half-cooked ideas in the central
> library is OK since you don't have to deal with it, right?
> 

See above - I was never suggesting this go in libc.

> Gee.  Especially since, now that I spend a second thinking about this,
> the whole approach proposed so far is bogus.  The extra "username" is
> just an additional piece of information for a user as represented by the
> passwd structure.  Therefore adding such an additional database makes no
> sense at all.  What should happen is that the information is added to
> the user database.

Umm - this is exactly what I have been suggesting for user authentication. The selinux user information (which is more than just a name, btw) should be stored along with the other information. This should be in a flat file, ldap, or whatever database you store your user information in.

>  struct passwd cannot be changed but it isn't
> necessary since there is no requirement to provide the information this
> way.  Just create a function or three which take either a user name,
> UID, or passwd pointer as the parameter and return the selinux user name.
> 

Fine - but the implementation of this depends on how the user information is stored. Again, I don't think it makes sense for libselinux to duplicate code that is already part of PAM. I don't think it makes sense for libc to do that either, but that is already what happens with nscd. This also comes with an increased configuration overhead (you now have to point PAM, nscd, _and_ libselinux at the correct user database).

Look, this discussion is just going in circles. I suggest that we agree that this code won't go into libc and Steve can make the final decision about whether it goes into libselinux when he is connected to the internet again.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
