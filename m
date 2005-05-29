Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <42999EF1.3020205@redhat.com>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117252045.19698.16.camel@localhost.localdomain>
	 <42980072.6090701@redhat.com>
	 <1117336632.24194.8.camel@localhost.localdomain>
	 <42999EF1.3020205@redhat.com>
Content-Type: text/plain
Date: Sun, 29 May 2005 13:44:59 -0400
Message-Id: <1117388699.21505.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >/* Performs a context match, and changes the file creation context.
> > * On success, returns the old context. On failure, returns NULL.
> > * The context returned must be freed with freecon() */
> >
> >security_context_t switch_context(const char* pathname, mode_t mode) {
> >        security_context_t prev_ctx = NULL;
> >        security_context_t tmp_ctx = NULL;
> >
> >        /* Attempt to get the current context. */
> >        if (getfscreatecon(&prev_ctx) < 0)
> >                return NULL;
> >
> >        /* Attempt a match. */
> >        if (matchpathcon(pathname, mode, &tmp_ctx) >= 0) {
> >                if (setfscreatecon(tmp_ctx) < 0) {
> >                        freecon(tmp_ctx);
> >                        freecon(prev_ctx);
> >                        return NULL;
> >                }
> >                freecon(tmp_ctx);
> >        }
> >
> >        return prev_ctx;
> >}
> >
> >...and then do this in every app that needs it, replacing
> >mkdir with the appropriate function. This is annoying.... 
> >but I can't think how else to write a better interface.
> >
> >/* Performs a mkdir call, and sets the context of the directory
> > * being created, according to matchpathcon. On SElinux failure
> > * returns -1. Otherwise, returns the usual mkdir status. */
> >
> >int mkdir_restorecon(const char *pathname, mode_t mode) {
> >        security_context_t prev_ctx = NULL;
> >        int status;
> >
> >        if (is_selinux_enabled()) {
> >                prev_ctx = switch_context(pathname, mode);
> >
> >                if ((prev_ctx != NULL) && security_getenforce())
> >                        return -1;
> >        }
> >
> >        status = mkdir(pathname, mode);
> >
> >        if (prev_ctx != NULL) {
> >                setfscreatecon(prev_ctx);
> >                freecon(prev_ctx);
> >        }
> >
> >        return status;
> >}
> >
> >  
> >
> You do not necessarily want to return an error or matchpathcon failure.  
> matchpathcon can return ENOENT to indicate that it matched <<none>>

>                if ((prev_ctx != NULL) && security_getenforce())

This should be if ((prev_ctx == NULL) ... 
Given that, there is no error on matchpathcon failure.

> In this case the setfscreatecon should not be called but the code should 
> continue.  IE the
> file should get created with the default context.

That's what it does... it also tries to setfscreatecon back to 
restore the old context on no change, but I thought that was acceptable.

The issue is - this interface is rather ugly - can anyone come up 
with a better one, or should I go ahead and patch various programs like
this. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
