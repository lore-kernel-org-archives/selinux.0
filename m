Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
In-Reply-To: <452566B2.7040003@us.ibm.com>
References: <452432FA.1060009@us.ibm.com>
	 <1160059227.2132.88.camel@moss-spartans.epoch.ncsc.mil>
	 <452566B2.7040003@us.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:24:53 -0400
Message-Id: <1160079893.2132.246.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 15:10 -0500, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > On Wed, 2006-10-04 at 17:17 -0500, Michael C Thompson wrote:
> >>  From what I have seen, the points of possible attack (i.e. input) to 
> >> newrole include:
> >> * command line options
> >> * reading the password from stdin
> >> * reading the contents of /etc/passwd and /etc/shell
> >>
> >> I doubt this is an exhaustive list. Since /etc/passwd and /etc/shell are 
> >> restricted to root-only write, I've discounted these. Since we require 
> >> PAM to do namespaces, which will cause PAM to handle the password check, 
> >> we should be able to defer any vulnerabilities to PAM, and I would hope 
> >> that PAM is secure.
> >>
> >> This leaves command line options. These are parsed with getopt_long, and 
> >> are currently passed into libselinux without any scrubbing. Since 
> >> SELinux doesn't apply a limit on the length of its context strings, is 
> >> there any checks that need to be done before handing these strings into 
> >> libselinux?
> > 
> > I don't think so.  The larger concern is not the command line arguments
> > but the environment.  glibc does some automatic sanitization of the
> > environment for setuid programs, but is limited in what it can do.
> > You likely want to save the environment or portions of it for
> > propagation to the newrole'd shell, reset the environment to a clean
> > state for newrole itself, and then invoke the user shell with the
> > previously saved environment.  Look at other setuid programs, like su
> > and sudo, as possible examples.   Also see:
> > http://www.dwheeler.com/secure-programs/Secure-Programs-HOWTO/environment-variables.html
> 
> Working towards this now. I am mimicing the behavior of su. By the time 
> we invoke pam_namespace, the environment will be scrubbed clean and will 
> contain a limited set of values (stardard shell related HOME, PATH, 
> TERM, etc). PATH will be set to a set of trusted paths like 
> /bin:/usr/bin, etc.

Ok.  Are you restoring the original environment or some portion of it
for the newrole'd shell?  su has different options there for handling
environment depending on how it is called.

> > Since pam_namespace further executes a script (namespace.init), the
> > environment is especially critical, and you need to consider the
> > implications of how the shell handles setuid execution.  For example,
> > unless namespace.init invokes /bin/sh with the -p option (privileged
> > mode), bash will reset the effective identities to the real identities
> > during startup, such that the script itself will run in the caller's
> > identity (and thus likely fail if it tries to do its job, like bind
> > mounting the .X11-unix directory into the member directory, as well as
> > creating any files or directories in the caller's uid).  If you change
> > namespace.init to use the -p option, then bash will leave the effective
> > identities alone, and will ignore certain aspects of the environment
> > that would normally affect it.  One might argue that pam_namespace
> > itself should do some environment cleansing, since it executes a script
> > and this won't be immediately obvious to all potential users of
> > pam_namespace.
> 
> So I take it changing namespace.init is an acceptable solution?

Yes, I think so.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
