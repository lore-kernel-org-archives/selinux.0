Subject: RE: Patch for restorecond to not report an error if filesystem
	does not support XATTR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C80CA@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C80CA@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 14:02:09 -0500
Message-Id: <1164913329.23019.978.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-30 at 13:15 -0500, Joshua Brindle wrote:
> > From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> > 
> > Joshua Brindle wrote:
> > > Daniel J Walsh wrote:
> > >> Caused by NFS Home directories.
> > >>
> > ---------------------------------------------------------------------
> > >> ---
> > >>
> > >> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
> > >> --exclude='*.pot' -N -u -r
> > >> nsapolicycoreutils/restorecond/restorecond.c
> > >> policycoreutils-1.33.5/restorecond/restorecond.c
> > >> --- nsapolicycoreutils/restorecond/restorecond.c    2006-11-16 
> > >> 17:14:28.000000000 -0500
> > >> +++ policycoreutils-1.33.5/restorecond/restorecond.c    2006-11-29 
> > >> 12:44:06.000000000 -0500
> > >> @@ -210,9 +210,10 @@
> > >>              }
> > >>  
> > >>              if (fsetfilecon(fd, scontext) < 0) {
> > >> -                syslog(LOG_ERR,
> > >> -                       "set context %s->%s failed:'%s'\n",
> > >> -                       filename, scontext, strerror(errno));
> > >> +                if (errno != EOPNOTSUPP) +                    
> > >> syslog(LOG_ERR,
> > >> +                           "set context %s->%s failed:'%s'\n",
> > >> +                           filename, scontext, strerror(errno));
> > >>                  if (retcontext >= 0)
> > >>                      free(prev_context);
> > >>                  free(scontext);
> > >> @@ -225,8 +226,9 @@
> > >>          if (retcontext >= 0)
> > >>              free(prev_context);
> > >>      } else {
> > >> -        syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> > >> -               filename, strerror(errno));
> > >> +        if (errno != EOPNOTSUPP) +            
> > syslog(LOG_ERR, "get 
> > >> context on %s failed: '%s'\n",
> > >> +                   filename, strerror(errno));
> > >>      }
> > >>      free(scontext);
> > >>      close(fd);
> > >
> > > It sounds like this is caused by configuration errors, why 
> > wouldn't it 
> > > check that the files/dirs being watched have xattr support before 
> > > adding them to the watch list?
> > >
> > I guess we can check before we add the directory to watch.  
> > How do you check if a directory supports file_context without 
> > setting the file context?
> > 
> 
> Good question, this may be yet-another-thing messed up by the
> canonicalized selinux contexts since getxattr will return the actual
> label and not necessarilly the one on disk (or an error if the
> filesystem doesn't support it).
> 
> Stephen might know a better way to figure out if a filesystem supports
> xattr labeling from userland, otherwise I guess the above patch is
> better than flooding the logs (though it won't give the user an
> indication why restorecond isn't doing what he thinks it should be), I'd
> really rather us figure out a way to report a configuration error to the
> user than hide the problem.

Interesting question...the policy Makefile and the fixfiles script have
always just used a hardcoded list of filesystem types known to support
file security labeling.  And the policy configuration explicitly
specifies the filesystem types for which SELinux tries to use xattrs, as
the mere presence of an xattr handler has never been a sufficient test.
Possibly we should be extracting that list from policy and making it
available for programs that need to know it.

Even testing the result of setxattr for EOPNOTSUPP is not 100%, as
setxattr will also fall back to setting the incore value if a) you pass
permission checks and b) the filesystem provides no setxattr method at
all (NFS happens to provide one, but it only supports ACLs).  So it
could succeed (e.g. devpts nodes) or fail with -EACCES (e.g. proc).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
