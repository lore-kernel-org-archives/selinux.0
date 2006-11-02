Subject: Re: [PATCH 0/4] newrole suid functionality (take 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <454A2867.7090401@us.ibm.com>
References: <45351FC9.2080204@us.ibm.com>
	 <1161629771.3316.119.camel@moss-spartans.epoch.ncsc.mil>
	 <454A2867.7090401@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 13:21:20 -0500
Message-Id: <1162491680.5519.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 11:18 -0600, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > On Tue, 2006-10-17 at 13:24 -0500, Michael C Thompson wrote:
> >> This is the intro to a set of four patches.
> >>
> >> These patches are an attempt to make newrole be an acceptably secure 
> >> suid root program, to provide it with the capabilities to generate audit 
> >> records (existing) and handle polyinstatiation (new).
> >>
> >> The 4 patches are as follows:
> >> 1) New functions introduced to newrole.c, new and existing functionality
> >> 2) Changes to existing functions in newrole.c
> >> 3) Updates to main in newrole.c to use the aforementioned changes
> >> 4) Changes to the Makefile to allow building of newrole with the
> >>     changes and introduction of newrole-lspp.pamd
> >>
> >> Note: This is an atomically applicable patch set. Applying a subset of 
> >> these patches will break the build.
> >>
> >> The comments from the previous send of these patches have been integrated.
> > 
> > diff -Naur policycoreutils-1.30.30.orig/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> > --- policycoreutils-1.30.30.orig/newrole/newrole.c	2006-10-17 13:11:41.000000000 -0500
> > +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-17 13:12:29.000000000 -0500
> > @@ -87,6 +87,7 @@
> >  /* USAGE_STRING describes the command-line args of this program. */
> >  #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]"
> >  
> > +#define DEFAULT_PATH "/bin:/usr/bin:/usr/local/bin"
> > 
> > Where does this particular path come from?  Why /usr/local/bin at all?
> > Why doesn't /usr/bin come before /bin?  
> 
> So would "/usr/bin:/bin" be sufficent? Not sure if it is desirable to 
> add sbin paths or not.

I'd expect newrole and any code it executes to use fully specified paths
anyway, so I'm not sure it makes a difference.  Since newrole and pam is
often called by non-root users, that code cannot assume that sbin is in
the path, nor would it want to rely on the path.  And for the newrole'd
shell, the path is going to be customized by the user's dotfiles
typically.  So /usr/bin:/bin is likely fine.  Not sure what value login
uses as the initial state for PATH for login sessions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
