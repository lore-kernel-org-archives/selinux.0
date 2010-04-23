Subject: Re: [PATCH 1/3] SELinux: standardize return code handling in
 policydb.c
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <alpine.LRH.2.00.1004230833200.18002@tundra.namei.org>
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
	 <alpine.LRH.2.00.1004230833200.18002@tundra.namei.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Apr 2010 22:37:47 -0400
Message-ID: <1271990267.2899.74.camel@dhcp235-240.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-04-23 at 08:44 +1000, James Morris wrote:
> On Thu, 22 Apr 2010, Eric Paris wrote:

The whole point of this, in my eyes, is the make sure that it's hard to
get rc wrong and to maximize the amount of useful readable code on the
screen at one time.  Lets argue style!

> > policydb.c has lots of different standards on how to handle return paths on
> > error.  For the most part transition to
> > 
> > 	rc=errno
> > 	if (failure)
> > 		goto out;
> > [...]
> > out:
> > 	cleanup()
> > 	return rc;
> > 
> > Instead of doing cleanup mid function, or having multiple returns or other
> > options.  This doesn't do that for every function, but most of the complex
> > functions which have cleanup routines on error.
> 
> I think the idea is that the 'goto out' paradigm is used when multiple 
> return points need the same cleanup, otherwise, just use return normally.

I got it.  Notice i didn't add goto when inline returns made sense for
the function in question.  Only when we needed a generic cleanup()
(although sometimes I added stuff to the generic cleanup that was
originally done in the meat of the function)

> > +++ b/security/selinux/ss/policydb.c
> > @@ -144,35 +144,33 @@ static int roles_init(struct policydb *p)
> >  {
> >  	char *key = NULL;
> >  	int rc;
> > -	struct role_datum *role;
> > +	struct role_datum *role = NULL;
> 
> Why is this being initialized to NULL?  The kzalloc call will assign it a 
> definite value.  Initializing variables unnecessarily can hide bugs in the 
> code.

I can go back through and not initialize things which are kmalloc() as
the first operation in the function.  sure.   I don't think there are
many cases of that in the series but I'll check tomorrow.

> 
> > +	rc = -ENOMEM;
> >  	role = kzalloc(sizeof(*role), GFP_KERNEL);
> 
> I'm not sure what the point is of assigning the error code first -- 
> perhaps if all or most of the error cases use that error, but they don't.

Actually I think it's a bad idea to do

rc = -ENOMEM;
obj1 = kmalloc()
if (!obj1)
	goto out;
obj2 = kmalloc()
if (!obj2)
	goto out;

we should set rc = -ENOMEM BOTH times, even thought the second time is
useless.  The compiler is going to clean it up.  And setting it both
times explicitly makes it impossible to screw up when I decided to add
to the function.

Another reason is prettier, more readable code (in my book)   5 lines vs
4 in some cases.  Which gets more of the code on the screen at the same
time.  My understanding is that compilers are going to end up doing
about the same thing in either case.  Even if they don't, I seem to
recall everything I really changed is a low use non-hot path function.
There are times where we can't drop the extra line of } to get more code
on the screen, but i'd still rather assign those outside the if() block
just to be consistent.

obj = kmalloc()
if (!obj) {
	rc = -ENOMEM;
	goto out;
}

vs

rc = -ENOMEM;
obj = kmalloc()
if (!obj)
	goto out
> 
> > -out:
> > -	return rc;
> > +	return 0;
> >  
> >  out_free_symtab:
> >  	for (i = 0; i < SYM_NUM; i++)
> >  		hashtab_destroy(p->symtab[i].table);
> > -	goto out;
> > +	return rc;
> >  }
> 
> Also, I think part of the point of this approach is that you reduce, not 
> increase, the number of return statements, to make reading the code 
> simpler.  It also forces you to account for 'rc' properly at all times.

the alternative to a return 0 is longer and no more readable since it
adds another goto.

[meat of function]
	rc = 0;
out:
	return rc;
err:
	do error cleanup()
	goto out;

vs:

[meat of function]
	return 0;
err:
	do error cleanup()
	return rc;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
