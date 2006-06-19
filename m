Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while
	polyinstantiating /tmp
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: dwalsh@redhat.com, sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov, russell@coker.com.au,
        selinux@tycho.nsa.gov
In-Reply-To: <1150479483.10368.11.camel@localhost.localdomain>
References: <1150426606.12904.3.camel@localhost.localdomain>
	 <1150479483.10368.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 20:01:56 -0400
Message-Id: <1150675316.6410.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-16 at 12:38 -0500, Timothy R. Chavez wrote:
> On Thu, 2006-06-15 at 22:56 -0400, Janak Desai wrote:
> > This patch updates pam_namespace to allow the use of graphical display
> > manager while polyinstantiating /tmp. It applies on top of the 06/15/06
> > version of pam_namespace in rawhide. 
> > 
> > Changes since the last version:
> >     - Execute instance initialization script at each instance setup
> >     - Properly obtain exit status from a child process that executes
> >       the instance initialization script
> >     - Example script for using X while polyinstantiating /tmp
> >     - Update Makefile.am to make sure that the instance initialization script
> >       gets installed with execute permission
> >     - Update man pages and README to reflect above changes
> > 
> > Signed-off-by: Janak Desai <janak@us.ibm.com>
> 
> Hi Janak,
> 
> Just some nits...
> 
> > 
> > ---
> > 
> >  Makefile.am          |    3 ++-
> >  README               |    2 +-
> >  namespace.conf.5.xml |    2 +-
> >  namespace.init       |   21 +++++++++++++++++++++
> >  pam_namespace.8.xml  |   36 ++++++++++++++++++++++++------------
> >  pam_namespace.c      |   32 ++++++++++++++++++++++++--------
> >  6 files changed, 73 insertions(+), 23 deletions(-)
> > 
> > diff -Naurp pam_namespace0615/modules/pam_namespace/Makefile.am pam_namespace0615+patch/modules/pam_namespace/Makefile.am
> > --- pam_namespace0615/modules/pam_namespace/Makefile.am	2006-06-16 02:07:24.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/Makefile.am	2006-06-16 01:18:16.000000000 +0000
> > @@ -33,5 +33,6 @@ if HAVE_UNSHARE
> >  securelib_LTLIBRARIES = pam_namespace.la
> >  pam_namespace_la_SOURCES = pam_namespace.c md5.c md5.h
> >  
> > -secureconf_DATA = namespace.conf namespace.init
> > +secureconf_DATA = namespace.conf
> > +secureconf_SCRIPT = namespace.init
> >  endif
> > diff -Naurp pam_namespace0615/modules/pam_namespace/README pam_namespace0615+patch/modules/pam_namespace/README
> > --- pam_namespace0615/modules/pam_namespace/README	2006-06-16 02:13:11.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/README	2006-06-16 02:12:26.000000000 +0000
> > @@ -11,7 +11,7 @@ and users' home directory.
> >  
> >  If an executable script /etc/security/namespace.init exists, it
> >  is used to initialize the namespace every time a new instance directory
> > -is created. The script receives the polyinstantiated directory path
> > +is setup. The script receives the polyinstantiated directory path
> >  and the instance directory path as its arguments.
> >  
> >  Each line in namespace.conf describes a limit for a user in the form:
> > diff -Naurp pam_namespace0615/modules/pam_namespace/namespace.conf.5.xml pam_namespace0615+patch/modules/pam_namespace/namespace.conf.5.xml
> > --- pam_namespace0615/modules/pam_namespace/namespace.conf.5.xml	2006-06-16 02:07:24.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/namespace.conf.5.xml	2006-06-16 01:34:24.000000000 +0000
> > @@ -25,7 +25,7 @@
> >        or, in the case of SELinux, user name, security context or both.  If an
> >        executable script <filename>/etc/security/namespace.init</filename>
> >        exists, it is used to initialize the namespace every time a new instance
> > -      directory is created. The script receives the polyinstantiated
> > +      directory is setup. The script receives the polyinstantiated
> >        directory path and the instance directory path as its arguments.
> >      </para>
> >  
> > diff -Naurp pam_namespace0615/modules/pam_namespace/namespace.init pam_namespace0615+patch/modules/pam_namespace/namespace.init
> > --- pam_namespace0615/modules/pam_namespace/namespace.init	2006-06-16 02:07:24.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/namespace.init	2006-06-16 01:30:53.000000000 +0000
> > @@ -1,3 +1,24 @@
> >  #!/bin/sh
> >  # This is only a boilerplate for the instance initialization script.
> >  # It receives polydir path as $1 and the instance path as $2.
> > +#
> > +# If you intend to polyinstantiate /tmp and you also want to use the X windows
> > +# environment, you will have to use this script to bind mount the socket that
> > +# is used by the X server to communicate with its clients. X server places
> > +# this socket in /tmp/.X11-unix directory, which will get obscured by
> > +# polyinstantiation. Uncommenting the following lines will bind mount
> > +# relevant the directory at an alternative location (/.tmp/.X11-unix) such
> 
> The use of the word "relevant" here makes the sentence awkward...  If
> this was intended, perhaps:
> 
> Uncommenting the following lines will bind mount, relevant the
> directory, at an alternative location... 
> 
> Not sure.
> 
> [..]
> > +# that the X server, window manager and X clients, can still find the
> > +# socket X0 at the polyinstanted /tmp/.X11-unix.
> > +#
> > +#if [ $1 = /tmp ]; then
> > +#	if [ ! -f /.tmp/.X11-unix ]; then
> > +#		mkdir -p /.tmp/.X11-unix
> > +#	fi
> > +#	mount --bind /tmp/.X11-unix /.tmp/.X11-unix
> > +#	cp -fp /tmp/.X0-lock $2/.X0-lock
> > +#	mkdir $2/.X11-unix
> > +#	ln -fs /.tmp/.X11-unix/X0 $2/.X11-unix/X0
> > +#fi
> > +
> > +exit 0
> 
> Should you not check arguments?  For instance,
> 
> if [ ! -d $2 ]; then
> 	echo "$2 is not a directory."
> 	exit 1
> fi
> 
> [..]
> > diff -Naurp pam_namespace0615/modules/pam_namespace/pam_namespace.8.xml pam_namespace0615+patch/modules/pam_namespace/pam_namespace.8.xml
> > --- pam_namespace0615/modules/pam_namespace/pam_namespace.8.xml	2006-06-16 02:07:24.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/pam_namespace.8.xml	2006-06-16 02:24:44.000000000 +0000
> > @@ -56,7 +56,7 @@
> >        using SELinux, user name, security context or both.  If an executable
> >        script <filename>/etc/security/namespace.init</filename> exists, it
> >        is used to initialize the namespace every time a new instance
> > -      directory is created. The script receives the polyinstantiated
> > +      directory is setup. The script receives the polyinstantiated
> >        directory path and the instance directory path as its arguments.
> >      </para>
> >  
> > @@ -255,22 +255,34 @@
> >  
> >      <para>
> >        This allows gdm to restart after each session and appropriately adjust
> > -      namesapces of display manager and the X server. If polyinstantiation of
> > -      /tmp is desired along with the graphical environment, then addtional
> > +      namesapces of display manager and the X server. If polyinstantiation
> 
> Probably a good idea to just correct this spelling error, since you're
> changing the line anyway and you fixed "additional" below.
> 
> [..]
> > +      of /tmp is desired along with the graphical environment, then additional
> >        configuration changes are needed to address the interaction of X server
> > -      and font server namespaces with their use of /tmp to create communication
> > -      sockets. Perform the following changes to use graphical environment
> > -      with polyinstantiation of /tmp:
> > +      and font server namespaces with their use of /tmp to create
> > +      communication sockets. Please use the initialization script
> > +      <filename>/etc/security/namespace.init</filename> to ensure that
> > +      the X server and its clients can appropirately access the
> 
> Another spelling error.  It should be "appropriately".
> 
> [..]
> > +      communication socket X0. Please refer to the sample instructions
> > +      provided in the comment section of the instance initalization script
> 
> Another spelling error.  It should be "initialization".
> 
> [..]
> > +      <filename>/etc/security/namespace.init</filename>. In addition,
> > +      perform the following changes to use graphical environment with
> > +      polyinstantiation of /tmp:
> >      </para>
> >  
> >      <para>
> >      <literallayout>
> > -      1. Setup default init state to 3, by modifying /etc/inittab
> > -      2. Disable the use of font server by commenting out "FontPath"
> > -         line in /etc/X11/xorg.conf.
> > -      3. Ensure that the login service is setup to use pam_namespace,
> > -         as described above, by modifying /etc/pam.d/login.
> > -      4. Use the "startx" command after a successful terminal login.
> > +      1. Disable the use of font server by commenting out "FontPath"
> > +         line in /etc/X11/xorg.conf. If you do want to use the font server
> > +         then you will have to augment the instance initialization
> > +         script to appropriately provide /tmp/.font-unix from the
> > +         polyinstantiated /tmp.
> > +      2. Ensure that the gdm service is setup to use pam_namespace,
> > +         as described above, by modifying /etc/pam.d/gdm.
> > +      3. Ensure that the display manager is configured to restart X server
> > +         with each new session. This default setup can be verified by
> > +         making sure that /usr/share/gdm/defaults.conf contains
> > +         "AlwaysRestartServer=true", and it is not overriden by
> > +         /etc/gdm/custom.conf.
> >      </literallayout>
> >      </para>
> >  
> > diff -Naurp pam_namespace0615/modules/pam_namespace/pam_namespace.c pam_namespace0615+patch/modules/pam_namespace/pam_namespace.c
> > --- pam_namespace0615/modules/pam_namespace/pam_namespace.c	2006-06-16 02:07:24.000000000 +0000
> > +++ pam_namespace0615+patch/modules/pam_namespace/pam_namespace.c	2006-06-16 02:05:38.000000000 +0000
> > @@ -632,8 +632,10 @@ static int create_dirs(const struct poly
> >  #endif
> >  {
> >      struct stat statbuf, newstatbuf, instpbuf;
> > -    int fd, pid, status;
> > +    int fd, status;
> >      char *inst_parent, *trailing_slash;
> > +    pid_t rc, pid;
> > +    sighandler_t osighand = NULL;
> >  
> >      /*
> >       * stat the directory to polyinstantiate, so its owner-group-mode
> > @@ -705,7 +707,7 @@ static int create_dirs(const struct poly
> >       */
> >      if (mkdir(ipath, S_IRUSR) < 0) {
> >          if (errno == EEXIST)
> > -            return PAM_SUCCESS;
> > +            goto inst_init;
> >          else {
> >              pam_syslog(idata->pamh, LOG_ERR, "Error creating %s, %m",
> >  			ipath);
> > @@ -776,12 +778,19 @@ static int create_dirs(const struct poly
> >       * directory as arguments.
> >       */
> >  
> > +inst_init:
> > +    osighand = signal(SIGCHLD, SIG_DFL);
> > +    if (osighand == NULL) {
> > +        pam_syslog(idata->pamh, LOG_ERR, "Cannot set signal value");
> > +        return PAM_SESSION_ERR;
> > +    }
> > +
> >      if (access(NAMESPACE_INIT_SCRIPT, F_OK) == 0) {
> >          if (access(NAMESPACE_INIT_SCRIPT, X_OK) < 0) {
> >              if (idata->flags & PAMNS_DEBUG)
> >                  pam_syslog(idata->pamh, LOG_ERR,
> >                             "Namespace init script not executable");
> > -	    rmdir(ipath);
> > +            (void) signal(SIGCHLD, osighand);
> >              return PAM_SESSION_ERR;
> >          } else {
> >              pid = fork();
> > @@ -796,22 +805,29 @@ static int create_dirs(const struct poly
> >  		          polyptr->dir, ipath, (char *)NULL) < 0)
> >  		    exit(1);
> >              } else if (pid > 0) {
> > -	        while (waitpid (pid, &status, 0) != pid);
> > -	        if (!WIFEXITED(status) || WEXITSTATUS(status) > 0) {
> > +                while (((rc = waitpid(pid, &status, 0)) == (pid_t)-1) &&
> > +                       (errno == EINTR));
> > +                if (rc == (pid_t)-1) {
> > +                    pam_syslog(idata->pamh, LOG_ERR, "waitpid failed- %m");
> > +                    (void) signal(SIGCHLD, osighand);
> > +                    return PAM_SESSION_ERR;
> > +		}
> 
> White-space pollution?  I see tabs for this closing bracket, but spaces
> for everything else?? Things aren't aligning correctly here... not
> familiar with this code though.
> 
> [..]
> > +	        if (!WIFEXITED(status) || WIFSIGNALED(status) > 0) {
> >                      pam_syslog(idata->pamh, LOG_ERR,
> >                                 "Error initializing instance");
> > -		    rmdir(ipath);
> > +                    (void) signal(SIGCHLD, osighand);
> >                      return PAM_SESSION_ERR;
> >                  }
> >  	    } else if (pid < 0) {
> >                  pam_syslog(idata->pamh, LOG_ERR,
> >                             "Cannot fork to run namespace init script, %m");
> > -		rmdir(ipath);
> > +                (void) signal(SIGCHLD, osighand);
> >                  return PAM_SESSION_ERR;
> >  	    }
> >          }
> >      }
> >  
> > +    (void) signal(SIGCHLD, osighand);
> >      return PAM_SUCCESS;
> >  }
> >  
> > @@ -894,7 +910,7 @@ static int ns_setup(const struct polydir
> >  #ifdef WITH_SELINUX
> >          if ((idata->flags & PAMNS_DEBUG) &&
> >              (idata->flags & PAMNS_SELINUX_ENABLED))
> > -            pam_syslog(idata->pamh, LOG_DEBUG, "Inst context %s Orig context %s",
> > +            pam_syslog(idata->pamh, LOG_DEBUG, "Inst ctxt %s Orig ctxt %s",
> >  		 instcontext, origcontext);
> >  #endif
> >      }
> > 
> 
> 

Tim,

I have made above changes in the patch that I just posted. I did not
include the argument checking in the script example, because the
script will be called from the namespace module with two existing
directories as arguments.

-Janak

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
