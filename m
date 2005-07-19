Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JLIggA011223
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 17:18:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JLEN3G007021
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 21:14:23 GMT
Subject: RE: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ulrich Drepper'" <drepper@redhat.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507192059.j6JKx2vx016238@gotham.columbia.tresys.com>
References: <200507192059.j6JKx2vx016238@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 17:12:04 -0400
Message-Id: <1121807524.10259.11.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Somewhere the context of this discussion was lost or I was just being unclear - 

> I was referring the administrative code for adding / modifying users. Not for 

> authentication / retrieving user information. For the admin interfaces there 

> can be an arbitrary number of applications.

This is probably my fault, because I didn't mention admin apps when 
presenting this issue to Ulrich. Nevertheless, the number of
applications is still small, and his point about us not needing all
those backends is valid. 

On the other hand I think we can get better integration of this data
with selinux if it is in libselinux/manage. You're trying to distance
those libraries from Unix users, but they're not completely separate.
You're storing things like selinux categories, for example, as an
opaque string, which has to be caller-validated. If this code
was in libselinux/manage we could take care of validation internally,
and do other things like manage file contexts internally (an issue
you and Joshua keep ignoring as an implementation detail).
So, my point is - there are some benefits to putting the code in
libselinux, while placing anything in glibc is inherently risky - high 
exposure, supposed to stay very stable, plus I have to integrate
with those awful macros (I'm sorry Ulrich..)

I don't see the problem with writing a relatively stable api, and
adding it to libselinux. 

> > > Putting this in
> > > libselinux means that we are stuck with the api for _years_.
> > 
> > And putting the interface with these half-cooked ideas in the central
> > library is OK since you don't have to deal with it, right?
> > 
> 
> See above - I was never suggesting this go in libc.

That was my impression of our discussion - the code would have to
go into libnss_files, which is part of libc. Now you're saying
it should go into pam, and I don't understand how that would work,
because this code has to go into a shared library, if it is to
be linked by shadow-utils, and libuser, and the various other
admin utilities in question.

> > Gee.  Especially since, now that I spend a second thinking about this,
> > the whole approach proposed so far is bogus.  The extra "username" is
> > just an additional piece of information for a user as represented by the
> > passwd structure.  Therefore adding such an additional database makes no
> > sense at all.  What should happen is that the information is added to
> > the user database.
> 
> Umm - this is exactly what I have been suggesting for user authentication. 
> The selinux user information (which is more than just a name, btw) should be stored along with the other information.

It can't be stored with the other information, because you can't change
the passwd format. Yes, it is information that is very related to the 
user, but that doesn't help us.

> >  struct passwd cannot be changed but it isn't
> > necessary since there is no requirement to provide the information this
> > way.  Just create a function or three which take either a user name,
> > UID, or passwd pointer as the parameter and return the selinux user name.
> > 
> 
> Fine - but the implementation of this depends on how the user information is stored. 
> Again, I don't think it makes sense for libselinux to duplicate code that is already part of PAM.

Pam has to do with information that's needed only at login time by login
programs, which is not the case here (I'm sorry if I've confused
Ulrich).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
