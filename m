Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RKhkNs029289
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 16:43:46 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RKcNcJ006900
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 20:38:23 GMT
Message-Id: <200509272038.j8RKcKYs000732@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Tue, 27 Sep 2005 16:38:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <43397960.5070905@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Tuesday, September 27, 2005 12:55 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 4/17
> 
> \Karl MacMillan wrote:
> 
> >This patch adds semanage.h - this is the new public interface for
> >libsemanage.
> >
> >
> Why is it that you have to keep re-adding the components that I'm
> currently working on. Please leave those out of the semanage.h header
> for now. If you don't approve of my APIs, then you should submit patches
> on top of them, instead of introducing duplicate work. Anything that
> says semanage_mls_* semanage_user_*, semanage_boolean_*, and
> semanage_homedir_* should be left out for now.
> 

These are the stubs that we put in a while ago - we will send a patch to
remove those. I would prefer that everything be in semanage.h, however. I
don't think that it will make the header too long and it will make it
clearer I believe. 

> 1) Users - those will be handled via the user_record data structure,
> which is already in CVS. The implementation is in sepol, but I've
> uninlined the data structure, so the API is now opaque.
> 

These also need to be routed through the handle function pointers so that
alternative implementations for the policy server can be provided. This can
be done by:

1) adding the function pointers to the semanage_func_table in
src/include/semanage_private.h.

2) Adding a routing function in semanage.c that calls the function pointer
in the handle and performs any error passing. This function cannot assume
any implementation details.

3) Filling in the function pointers in semange_direct_connect
(direct_api.c).

> 2) Booleans - those will be handle via the boolean_record data
> structure. I have no included that in semanage yet, because I'm still
> testing how other records (like the user record) will work, but you can
> look at the data structure in sepol.
> 
> 3) Homedirs - this part of the API is too unclear to add at this point
> (at least, it's not clear to me yet, and I'll probably be implementing
> it..)
> 

We'll leave these in for now as we work on what they should look like.

> P.S. Your semanage header should likely draw in my user/port/record
> headers, but please don't do this yet, as those interfaces are in flux.
> Also, I think the handle stuff and the module stuff should go into
> separate headers, and you should include those into semanage.h.

As above - I disagree. I would prefer a single header for everything that
works with the transactions. The header will not be that large and it makes
it easier to see the API as a whole.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
