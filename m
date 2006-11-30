MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Patch for restorecond to not report an error if filesystem does not support XATTR
Date: Thu, 30 Nov 2006 13:15:28 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C80CA@exchange.columbia.tresys.com>
In-Reply-To: <456F0F81.2000609@redhat.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> 
> Joshua Brindle wrote:
> > Daniel J Walsh wrote:
> >> Caused by NFS Home directories.
> >>
> ---------------------------------------------------------------------
> >> ---
> >>
> >> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
> >> --exclude='*.pot' -N -u -r
> >> nsapolicycoreutils/restorecond/restorecond.c
> >> policycoreutils-1.33.5/restorecond/restorecond.c
> >> --- nsapolicycoreutils/restorecond/restorecond.c    2006-11-16 
> >> 17:14:28.000000000 -0500
> >> +++ policycoreutils-1.33.5/restorecond/restorecond.c    2006-11-29 
> >> 12:44:06.000000000 -0500
> >> @@ -210,9 +210,10 @@
> >>              }
> >>  
> >>              if (fsetfilecon(fd, scontext) < 0) {
> >> -                syslog(LOG_ERR,
> >> -                       "set context %s->%s failed:'%s'\n",
> >> -                       filename, scontext, strerror(errno));
> >> +                if (errno != EOPNOTSUPP) +                    
> >> syslog(LOG_ERR,
> >> +                           "set context %s->%s failed:'%s'\n",
> >> +                           filename, scontext, strerror(errno));
> >>                  if (retcontext >= 0)
> >>                      free(prev_context);
> >>                  free(scontext);
> >> @@ -225,8 +226,9 @@
> >>          if (retcontext >= 0)
> >>              free(prev_context);
> >>      } else {
> >> -        syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> >> -               filename, strerror(errno));
> >> +        if (errno != EOPNOTSUPP) +            
> syslog(LOG_ERR, "get 
> >> context on %s failed: '%s'\n",
> >> +                   filename, strerror(errno));
> >>      }
> >>      free(scontext);
> >>      close(fd);
> >
> > It sounds like this is caused by configuration errors, why 
> wouldn't it 
> > check that the files/dirs being watched have xattr support before 
> > adding them to the watch list?
> >
> I guess we can check before we add the directory to watch.  
> How do you check if a directory supports file_context without 
> setting the file context?
> 

Good question, this may be yet-another-thing messed up by the
canonicalized selinux contexts since getxattr will return the actual
label and not necessarilly the one on disk (or an error if the
filesystem doesn't support it).

Stephen might know a better way to figure out if a filesystem supports
xattr labeling from userland, otherwise I guess the above patch is
better than flooding the logs (though it won't give the user an
indication why restorecond isn't doing what he thinks it should be), I'd
really rather us figure out a way to report a configuration error to the
user than hide the problem.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
