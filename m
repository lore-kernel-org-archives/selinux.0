Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PGq5fM026213
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 12:52:05 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6PGq4PQ014350
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 16:52:04 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Export sepol handle
Date: Tue, 25 Jul 2006 12:52:05 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588298D4E@exchange.columbia.tresys.com>
In-Reply-To: <1153842873.12141.15.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Sent: Tuesday, July 25, 2006 11:55 AM
> 
> On Tue, 2006-07-25 at 10:54 -0400, Joshua Brindle wrote:
> 
> <snip>
> 
> >  struct sepol_handle;
> >  typedef struct sepol_handle sepol_handle_t;
> > +typedef void (*sepol_handle_callback_fn_t) (void* varg, 
> > +sepol_handle_t* handle, const char* fmt, ...);
> >  
> 
> I'm confused about the first argument - it is just a blob of 
> data passed to the callback, correct? Why is it called varg 
> (which implies variable argument list to me)? And why is it 
> passed when it is stored in the handle which is also passed? 
> Why not just export a function to grab it from the handle?
> 

This was the previous callback in the handle moved to a typedef, no
changes made. The default callback also uses a varg.

> >  /* Create and return a sepol handle. */ -sepol_handle_t 
> > *sepol_handle_create(void);
> > +extern sepol_handle_t *sepol_handle_create(void);
> > +
> > +/* Set the callback for a sepol handle */ extern void 
> > +sepol_handle_set_callback(sepol_handle_t *h, 
> > +sepol_handle_callback_fn_t fn, void *varg);
> > +
> 
> See a above.
> 
> > +/* Call the callback for a sepol handle */ extern void 
> > +sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, 
> > +...);
> > +
> 
> This is meant to replace ERR, INFO, etc. for external users 
> of the library? Calling it do_callback is odd - it is forcing 
> the user to think about and know about how the error system works.
> 
> Why not:
> 
> sepol_report_err(sepol_handle_t *handle, const char* fmt, ...);
> 

Eh? How does this get the error from the library into the app calling
it. The purpose of this patch is to let errors in libsepol propagate out
to setools.

> With one for info and warn, or a single function that takes a 
> level and some defines.
> 
> Also, the pointer goes with the variable name and not the 
> type (this is C not C++) - e.g., sepol_handle_t *handle not 
> sepol_handle_t* handle.
> 
> > +/* Get the severity level of the last message */ extern int 
> > +sepol_handle_get_level(sepol_handle_t *h);
> >  
> 
> The severity should be passed with the message to the 
> callback - this interface cannot be used reliably with a 
> threaded app. Even if the error reporting system is not 
> re-entrant (which it probably isn't) this interface is harder 
> to use and prevents future threading changes.
> 
> This means that the level should probably be removed from the 
> handle as well.

This is the previous implementation, AFAIK there are other thread unsafe
parts of the handle. This, however, is only being exported to static
users which must have knowledge of the library and can implement locking
on the handle if they are threaded.

> 
> >  /* Destroy a sepol handle. */
> > -void sepol_handle_destroy(sepol_handle_t *);
> > +extern void sepol_handle_destroy(sepol_handle_t *);
> > +
> >  
> 
> Variable names?
> 

Matched format.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
