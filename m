Subject: Re: Patch for restorecond to not report an error if filesystem
	does not support XATTR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4576FB84.9050200@mentalrootkit.com>
References: <456E073D.8050109@redhat.com>
	 <4576FB84.9050200@mentalrootkit.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:18:02 -0500
Message-Id: <1165947482.998.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-06 at 12:19 -0500, Karl MacMillan wrote:
> Daniel J Walsh wrote:
> > Caused by NFS Home directories.
> > 
> 
> In the absence of some mechanism to determine which file systems support 
> labeling, do we want to merge this patch or something similar? Would it 
> be better to remove files from the watch list if a fatal error is 
> encountered?

As Joshua noted, you could test for the same condition when processing
the configuration before you add the file to the watch list, and issue
an error or warning at that time rather than waiting until you try to
restore the file's context.  Just do an open+fgetfilecon followed by a
fsetfilecon to the same context to check for any errors (not just
EOPNOTSUPP) before adding to the watch list.  Only corner case is ENOENT
if you want to allow the watch list to include files that may not yet
exist; I suppose you could ignore that one at config processing time.

> 
> Karl
> 
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/restorecond/restorecond.c policycoreutils-1.33.5/restorecond/restorecond.c
> > --- nsapolicycoreutils/restorecond/restorecond.c	2006-11-16 17:14:28.000000000 -0500
> > +++ policycoreutils-1.33.5/restorecond/restorecond.c	2006-11-29 12:44:06.000000000 -0500
> > @@ -210,9 +210,10 @@
> >  			}
> >  
> >  			if (fsetfilecon(fd, scontext) < 0) {
> > -				syslog(LOG_ERR,
> > -				       "set context %s->%s failed:'%s'\n",
> > -				       filename, scontext, strerror(errno));
> > +				if (errno != EOPNOTSUPP) 
> > +					syslog(LOG_ERR,
> > +					       "set context %s->%s failed:'%s'\n",
> > +					       filename, scontext, strerror(errno));
> >  				if (retcontext >= 0)
> >  					free(prev_context);
> >  				free(scontext);
> > @@ -225,8 +226,9 @@
> >  		if (retcontext >= 0)
> >  			free(prev_context);
> >  	} else {
> > -		syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> > -		       filename, strerror(errno));
> > +		if (errno != EOPNOTSUPP) 
> > +			syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> > +			       filename, strerror(errno));
> >  	}
> >  	free(scontext);
> >  	close(fd);
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
