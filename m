Subject: Re: installation from scratch problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1169472989.8180.9.camel@moss-spartans.epoch.ncsc.mil>
References: <1169207960.8700.19.camel@zeroKnowledge>
	 <1169210930.22731.478.camel@moss-spartans.epoch.ncsc.mil>
	 <1169243300.26086.5.camel@zeroKnowledge>
	 <1169472989.8180.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 11:41:48 -0500
Message-Id: <1169484108.8180.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-22 at 08:36 -0500, Stephen Smalley wrote:
> On Fri, 2007-01-19 at 22:48 +0100, Vincenzo Ciaglia wrote:
> > Il giorno ven, 19/01/2007 alle 07.48 -0500, Stephen Smalley ha scritto:
> > 
> > > The current libselinux depends on thread local storage (tls) support,
> > > which exists in glibc 2.4.  See the link below for a workaround patch
> > > used by the Debian folks:
> > > http://marc.theaimsgroup.com/?l=selinux&m=115807948020898&w=2
> > > 
> > > Also, I would tend to suggest updating to stable branch that we just
> > > created in the sourceforge svn repo, as that will be the basis for the
> > > next nsa.gov/selinux stable release.  But that won't change the
> > > situation wrt to tls support.  
> > > 
> > > $ svn co https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0 selinux-stable
> > 
> > Thank you! I solved the problems. I used the debian's patch, recompiled
> > gcc and glibc with tls support and i used the userland packages from the
> > svn repo.
> > 
> > Now i can install libselinux, libsemanage, libsepol and checkpolicy but
> > i get this error with the latest package to compile: policycoreutils
> > 
> > Here the output:
> > 
> > **********************************************
> > # cd policycoreutils/
> > # make
> > make[1]: Entering directory
> > `/root/selinux-stable/policycoreutils/setfiles'
> > make[1]: Nothing to be done for `all'.
> > make[1]: Leaving directory
> > `/root/selinux-stable/policycoreutils/setfiles'
> > make[1]: Entering directory
> > `/root/selinux-stable/policycoreutils/semanage'
> > make[1]: Nothing to be done for `all'.
> > make[1]: Leaving directory
> > `/root/selinux-stable/policycoreutils/semanage'
> > make[1]: Entering directory
> > `/root/selinux-stable/policycoreutils/load_policy'
> > make[1]: Nothing to be done for `all'.
> > make[1]: Leaving directory
> > `/root/selinux-stable/policycoreutils/load_policy'
> > make[1]: Entering directory
> > `/root/selinux-stable/policycoreutils/newrole'
> > cc -Werror -Wall -W -DVERSION=\"1.34.0\"  -I/usr/include -DUSE_NLS
> > -DLOCALEDIR="\"/usr/share/locale\"" -DPACKAGE="\"policycoreutils\""
> > -D_XOPEN_SOURCE=500    newrole.c  -lselinux -lsepol -L/usr/lib -lcrypt
> > -o newrole
> > cc1: warnings being treated as errors
> > newrole.c: In function 'main':
> > newrole.c:947: warning: unused variable 'rc'
> > make[1]: *** [newrole] Error 1
> > make[1]: Leaving directory
> > `/root/selinux-stable/policycoreutils/newrole'
> > make: *** [all] Error 1
> > **********************************************
> > 
> > What is going wrong ?
> 
> Looks like your system doesn't have the pam library installed.  Best
> option is to install the pam library (e.g. look for a pam-devel package)
> and then build it.  Otherwise, if you truly aren't using pam on that
> system, then you could remove that variable declaration as it is then
> unnecessary.  We can fix that upstream as well, but AFAIK, everyone
> using selinux has pam these days.

Trivial diff below.

Index: policycoreutils/newrole/newrole.c
===================================================================
--- policycoreutils/newrole/newrole.c	(revision 2198)
+++ policycoreutils/newrole/newrole.c	(working copy)
@@ -944,11 +944,11 @@
 	int preserve_environment;
 
 	int fd;
-	int rc;
 	pid_t childPid = 0;
 	char *shell_argv0 = NULL;
 
 #ifdef USE_PAM
+	int rc;
 	int pam_status;		   /* pam return code */
 	pam_handle_t *pam_handle;  /* opaque handle used by all PAM functions */
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
