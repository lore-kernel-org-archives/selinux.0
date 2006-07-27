MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH RETRY 1/3] export sepol handle
Date: Thu, 27 Jul 2006 09:32:56 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832A8AA@exchange.columbia.tresys.com>
In-Reply-To: <1153942152.11769.181.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> >  
> > -void sepol_handle_destroy(sepol_handle_t * sh)
> > +void sepol_handle_set_callback(sepol_handle_t *h, 
> > +sepol_handle_callback_fn_t fn, void *varg)
> >  {
> > +	if (h == NULL)
> > +		return;
> > +
> > +	h->msg_callback = fn;
> > +	h->msg_callback_arg = varg;
> > +}
> 
> This looks like sepol_msg_set_callback, which is what 
> libsemanage already uses.  Am I missing something?
> 

Yes, drop this patch, looks like someone didn't do their homework :\

> > +void sepol_handle_do_callback(sepol_handle_t* handle, const char* 
> > +fmt, ...) {
> > +	char *tmp = NULL;
> > +	va_list ap;
> > +
> > +	if (handle == NULL)
> > +		return;
> > +
> > +	va_start(ap, fmt);
> > +	vasprintf(&tmp, fmt, ap);
> > +	va_end(ap);
> > +
> > +	ERR(handle, "%s", tmp);
> > +	free(tmp);
> > +}
> 
> I don't quite understand the intended usage.  If I am 
> generating an error message from outside the library, why 
> would I call into the library and then have it call into the 
> callback I provided in the first place?  What's the point?
> 

The intention was for a library using libsepol (libqpol) to generate an
sepol error that will call the callback in the application, granted its
awkward. The setools guys will rethink this. For now just drop this
patch.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
