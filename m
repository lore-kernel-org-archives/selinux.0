Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GLqODo011174
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 16:52:24 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GLkJfp020966
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 21:46:19 GMT
Message-Id: <200503162146.j2GLk28R025705@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>
Cc: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Wed, 16 Mar 2005 16:46:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050316101339.GK6055@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> Sent: Wednesday, March 16, 2005 5:14 AM
> To: Kaigai Kohei
> Cc: Karl MacMillan; 'KaiGai Kohei'; 'SELinux Mail List'; 
> selinux-dev@tresys.com
> Subject: Re: [RFC & PATCH] inherited type definition.
> 
> On Wed, Mar 16, 2005 at 01:35:36PM +0900, Kaigai Kohei wrote:
> > Hi Karl, Thanks for your comments.
> > 
> > > Not exactly - that is certainly one problem, but the main 
> problem is 
> > > that I want the ability to create a group of types based 
> on another 
> > > group of types, e.g. I want to create staff_ssh_t and 
> > > staff_home_ssh_t based on the corresponding user types. In this 
> > > model staff_ssh_t wouldn't have any access to user_home_ssh_t, 
> > > instead it will have the same access that user_ssh_t has 
> to user_home_ssh_t except to staff_home_ssh_t.
> > 
> 
>  oh _drat_.
> 
>  you might be running into almost exactly the same stupid  
> pre-processor issues i ran into in gcc with c++ (if you 
> pre-process,  how can you use c++ templates on 
> macro-pre-processed code???)
> 
> 
>  *thinks some more*.
> 
>  karl, could you elaborate with an example?
> 
>  if you put the inheritance statement into the macro, such 
> that it gets  expanded out, why is there a problem?
> 

I am looking for a semantic that is part of the binary format - putting it in a
macro makes it happen at compile time and therefore isn't useful for production
systems without source.

>  $1_t extends $1_something_t
> 

'staff_ssh_t extends user_ssh_t'?

Again, I don't want to give staff_ssh_t access to user_home_ssh_t which the
above statement would, I want to give staff_ssh_t access to staff_home_ssh_t. I
want to pattern the access between two or more types on the access of two or
more types.

More generally, I want to be able to define an access template that can be
expanded in the binary policy so that, for example, adding a role will create
the appropriate set of types with the correct relationship.

In a lot of ways, this is moving a subset of the macro language into the binary
format with some additional syntax to say expand this macro for this type, type
prefix, all roles, etc. This could also be used to address the same things that
the EXTEND syntax does with more control and flexibility, though it would
require changes to the existing policy similar to converting a policy into
macros (the passwd_t, groupadd_t, etc macro is a good example).

Karl

>  l.
>

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
