Message-ID: <3F4BD194.9030406@redhat.com>
Date: Tue, 26 Aug 2003 17:31:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: first pass at pam_selinux.so 
Content-Type: multipart/mixed;
 boundary="------------030902070507020502000207"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030902070507020502000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a session only pam file.  IE you should add the following line 
to your login programs /etc/pam.d/FILE

session    required     pam_selinux.so debug verbose multiple

This should allow you to use the standard login program.   You might be 
able to use this to eliminate most of the modifications to any package 
that uses pam.

This will only work with the 2.6 code.  I do not believe you can do this 
with the 2.4 selinux because you don't have a command similar to setexeccon.

I am updateing the pam src rpm on people

ftp://people.redhat.com/dwalsh/SELinux/packages/pam-0.77-4.src.rpm

Dan

--------------030902070507020502000207
Content-Type: text/plain;
 name="pam_selinux.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pam_selinux.c"

/******************************************************************************
 * A module for Linux-PAM that will set the default security context after login 
 * via PAM.
 *
 * Copyright (c) 2003 Red Hat, Inc.
 * Written by Dan Walsh <dwalsh@redhat.com>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, and the entire permission notice in its entirety,
 *    including the disclaimer of warranties.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * ALTERNATIVELY, this product may be distributed under the terms of
 * the GNU Public License, in which case the provisions of the GPL are
 * required INSTEAD OF the above restrictions.  (This clause is
 * necessary due to a potential bad interaction between the GPL and
 * the restrictions contained in a BSD-style copyright.)
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#define PAM_SM_AUTH
#define PAM_SM_SESSION

#include "../../_pam_aconf.h"

#include <errno.h>
#include <limits.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../../_pam_aconf.h"
#include <security/pam_modules.h>
#include <security/_pam_macros.h>
#include <security/_pam_modutil.h>

#include <libintl.h>
#define _(x) gettext(x)

#ifndef PAM_SELINUX_MAIN
#define MODULE "pam_selinux"

#include <selinux/selinux.h>
#include <selinux/get_context_list.h>
#include <selinux/flask.h>
#include <selinux/selinux.h>
/* Validate a tty pathname as actually belonging to a tty, and return its base
 * name if it's valid. */
static const char *
check_tty(const char *tty)
{
	/* Check that we're not being set up to take a fall. */
	if ((tty == NULL) || (strlen(tty) == 0)) {
		return NULL;
	}
	/* Pull out the meaningful part of the tty's name. */
	if (strchr(tty, '/') != NULL) {
		if (strncmp(tty, "/dev/", 5) != 0) {
			/* Make sure the device node is actually in /dev/,
			 * noted by Michal Zalewski. */
			return NULL;
		}
		tty = strrchr(tty, '/') + 1;
	}
	/* Make sure the tty wasn't actually a directory (no basename). */
	if (strlen(tty) == 0) {
		return NULL;
	}
	return tty;
}

/* Validate a tty pathname as actually belonging to a tty, and return its base
 * name if it's valid. */
static int send_text(  struct pam_conv *conv, const char *text, int debug) {
  struct pam_message message;
  const struct pam_message *messages[] = {&message};
  struct pam_response *responses;
  memset(&message, 0, sizeof(message));
  message.msg_style = PAM_TEXT_INFO;
  message.msg = text;
  if (debug)
    syslog(LOG_DEBUG, MODULE ": %s", message.msg);
  return conv->conv(1, messages, &responses, conv->appdata_ptr);
}
static int query_response(  struct pam_conv *conv, const char *text,struct pam_response **responses, int debug) {
  struct pam_message message;
  const struct pam_message *messages[] = {&message};
  memset(&message, 0, sizeof(message));
  message.msg_style = PAM_PROMPT_ECHO_ON;
  message.msg = text;
  if (debug)
    syslog(LOG_DEBUG, MODULE ": %s", message.msg);
  return conv->conv(1, messages, responses, conv->appdata_ptr);
}
static const security_context_t 
select_context( pam_handle_t *pamh, security_context_t* contextlist, security_context_t *user_context,int debug)
{
  struct pam_conv *conv;
  if (pam_get_item(pamh, PAM_CONV, (const void**) &conv) == PAM_SUCCESS) {
    if (conv->conv != NULL) {
      struct pam_response *responses;
      char text[PATH_MAX];
      snprintf(text, sizeof(text),
	       _("Your default context is %s. \n"), contextlist[0]);
      send_text(conv,text,debug);
      query_response(conv,_("Do you want to choose a different one? [n]"),&responses,debug);
      if ((responses[0].resp[0] == 'y') || (responses[0].resp[0] == 'Y'))
	{
	  int choice=0;
	  int i;
	  for (i = 0; contextlist[i]; i++) {
	    snprintf(text, sizeof(text),
		     "[%d] %s", i+1, contextlist[i]);
	    send_text (conv,text,debug);
	  }
	  while ((choice < 1) || (choice > i)) {
	    query_response(conv,_("Enter number of choice: "),&responses,debug);
	    choice = strtol (responses[0].resp, NULL, 10);
	  }
	  return (security_context_t) strdup(contextlist[choice-1]);  
	}
    } else {
      if (debug)
	syslog(LOG_DEBUG, _("%s: bogus conversation function"),MODULE);
    }
  } else {
    if (debug)
      syslog(LOG_DEBUG, _("%s: no conversation function"),MODULE);
  }
  return (security_context_t) strdup(contextlist[0]);  
}

static void security_restorelabel_tty(char *tty,security_context_t context) {
  if (context==NULL)
    return;

  if (setfilecon(tty,context)) 
    {
      syslog(LOG_NOTICE, _("Warning!  Could not relabel %s with %s, not relabeling.\n"), tty,context);
    }
  freecon(context);
  return;
}
static security_context_t security_label_tty(char *tty, security_context_t usercon) {
  security_context_t newdev_context=NULL; /* The new context of a device */
  security_context_t prev_context=NULL; /* The new context of a device */
  if (getfilecon(tty, &prev_context) < 0) 
    {
      syslog(LOG_NOTICE, _("Warning!  Could not get current context for %s, not relabeling.\n"), tty);
      return NULL;
    }	
  if( security_compute_relabel(usercon,prev_context,SECCLASS_CHR_FILE,&newdev_context)!=0) {
    syslog(LOG_NOTICE, _("Warning!  Could not get new context for %s, not relabeling.\n"), tty);
      return NULL;
  }
  if (setfilecon(tty,newdev_context)) 
    {
      syslog(LOG_NOTICE, _("Warning!  Could not relabel %s with %s, not relabeling.\n"), tty,newdev_context);
      return NULL;
    }
  freecon(newdev_context);
  return prev_context;
}

static security_context_t user_context=NULL;
static security_context_t prev_user_context=NULL;
static security_context_t ttyn_context=NULL;  /* The current context of ttyn device */
static int selinux_enabled=0;
static char *ttyn=NULL;

/* Tell the user that access has been granted. */
static void
verbose_success(pam_handle_t *pamh, int debug)
{
  struct pam_conv *conv;
  struct pam_message message;
  const struct pam_message *messages[] = {&message};
  struct pam_response *responses;
  if (pam_get_item(pamh, PAM_CONV, (const void**) &conv) == PAM_SUCCESS) {
    if (conv->conv != NULL) {
      char text[PATH_MAX];
      memset(&message, 0, sizeof(message));
      message.msg_style = PAM_TEXT_INFO;
      snprintf(text, sizeof(text),
	       _("Security Context %s Assigned"), user_context);
      message.msg = text;
      if (debug)
	syslog(LOG_DEBUG, MODULE ": %s", message.msg);
      conv->conv(1, messages, &responses, conv->appdata_ptr);
    } else {
      if (debug)
	syslog(LOG_DEBUG, _("%s: bogus conversation function"),MODULE);
    }
  } else {
    if (debug)
      syslog(LOG_DEBUG,_("%s: no conversation function"),MODULE);
  }
}

PAM_EXTERN int
pam_sm_authenticate(pam_handle_t *pamh, int flags, int argc, const char **argv)
{
	/* Fail by default. */
	return PAM_AUTH_ERR;
}

PAM_EXTERN int
pam_sm_setcred(pam_handle_t *pamh, int flags, int argc, const char **argv)
{
	return PAM_SUCCESS;
}

PAM_EXTERN int
pam_sm_open_session(pam_handle_t *pamh, int flags, int argc, const char **argv)
{
  int i, debug = 0, ttys=1,verbose=0,multiple=0;
  char *tty=NULL;
  int ret=0;
  security_context_t* contextlist=NULL;
  int num_contexts = 0;
  char *username=NULL;
  /* Parse arguments. */
  if (!(selinux_enabled = is_selinux_enabled()) )
    {
      return PAM_SUCCESS;
    }
  for (i = 0; i < argc; i++) {
    if (strcmp(argv[i], "debug") == 0) {
      debug = 1;
    }
    if (strcmp(argv[i], "nottys") == 0) {
      ttys = 0;
    }
    if (strcmp(argv[i], "verbose") == 0) {
      verbose = 1;
    }
    if (strcmp(argv[i], "multiple") == 0) {
      multiple = 1;
    }
  }

  if (ttys) {
    /* Get the name of the terminal. */
    if (pam_get_item(pamh, PAM_TTY, (const void**)&tty) != PAM_SUCCESS) {
      tty = NULL;
    }
    if ((tty == NULL) || (strlen(tty) == 0)) {
      tty = ttyname(STDIN_FILENO);
      if ((tty == NULL)
 || (strlen(tty) == 0)) {
	tty = ttyname(STDOUT_FILENO);
      }
      if ((tty == NULL) || (strlen(tty) == 0)) {
	tty = ttyname(STDERR_FILENO);
      }
    }
    ttyn = strdup(check_tty(tty));
    ttyn_context=security_label_tty(ttyn,user_context);
  }
  if (pam_get_item(pamh, PAM_USER, (const void**)&username) != PAM_SUCCESS) {
    return PAM_AUTH_ERR;
  }
  num_contexts = get_ordered_context_list(username, 0, &contextlist);
  if (num_contexts > 0) {
    if (multiple) {
      user_context = select_context(pamh,contextlist, &user_context,debug);
      freeconary(contextlist);
      if (ret < 0) {
	syslog (LOG_ERR,  _("%s:  query_user_context failed\n"), argv[0]);
	return PAM_AUTH_ERR;
      }
    } else {
      user_context = (security_context_t) strdup(contextlist[0]);
      freeconary(contextlist);
    }
  } else {
    ret = manual_user_enter_context(username, &user_context);
    if (ret < 0) {
      syslog (LOG_ERR, _("Unable to get valid context for %s"), username);
      return PAM_AUTH_ERR;
    }
  }
  if (getexeccon(&prev_user_context)<0) {
    prev_user_context=NULL;
  }
  ret = setexeccon(user_context);
  if (ret==0 && verbose) {
    verbose_success(pamh, debug);
  }
  freecon(user_context);
  if (ret) {
    syslog(LOG_ERR, _("Error!  Unable to set %s executable context %s.\n"),username, user_context);
    return PAM_AUTH_ERR;
  } else {
    if (debug)
      syslog(LOG_DEBUG, _("%s: set %s security context to %s"),MODULE, username, user_context);
  }

  return PAM_SUCCESS;
}

PAM_EXTERN int
pam_sm_close_session(pam_handle_t *pamh, int flags, int argc, const char **argv)
{
  int i, debug = 0;
  if (! (selinux_enabled ))
    {
      return PAM_SUCCESS;
    }
  /* Parse arguments. */
  for (i = 0; i < argc; i++) {
    if (strcmp(argv[i], "debug") == 0) {
      debug = 1;
    }
  }

  if (ttyn) {
    security_restorelabel_tty(ttyn,ttyn_context);
    free(ttyn);
    ttyn=NULL;
  }
  if (setexeccon(prev_user_context)) {
    syslog(LOG_ERR, _("Error!  Unable to set executable context %s.\n"), prev_user_context);
    return PAM_AUTH_ERR;
  }

  if (debug)
    syslog(LOG_DEBUG, _("%s: setcontext back to orginal"),MODULE);

  return PAM_SUCCESS;
}

#else /* PAM_SELINUX_MAIN */

/************************************************************************
 *
 * All PAM code goes in this section.
 *
 ************************************************************************/

#include <unistd.h>               /* for getuid(), exit(), getopt() */
#include <signal.h>
#include <sys/wait.h>		  /* for wait() */

#include <security/pam_appl.h>    /* for PAM functions */
#include <security/pam_misc.h>    /* for misc_conv PAM utility function */

#define SERVICE_NAME "pam_selinux_check"   /* the name of this program for PAM */
				  /* The file containing the context to run 
				   * the scripts under.                     */
#define _(x) x
int authenticate_via_pam( const char *user ,   pam_handle_t **pamh);

/* authenticate_via_pam()
 *
 * in:     user
 * out:    nothing
 * return: value   condition
 *         -----   ---------
 *           1     pam thinks that the user authenticated themselves properly
 *           0     otherwise
 *
 * this function uses pam to authenticate the user running this
 * program.  this is the only function in this program that makes pam
 * calls.
 *
 */

int authenticate_via_pam( const char *user ,   pam_handle_t **pamh) {

  struct pam_conv *conv;
  int result = 0;    /* our result, set to 0 (not authenticated) by default */

  /* this is a jump table of functions for pam to use when it wants to *
   * communicate with the user.  we'll be using misc_conv(), which is  *
   * provided for us via pam_misc.h.                                   */
  struct pam_conv pam_conversation = {
    misc_conv,
    NULL
  };
  conv = &pam_conversation;


  /* make `p_pam_handle' a valid pam handle so we can use it when *
   * calling pam functions.                                       */
  if( PAM_SUCCESS != pam_start( SERVICE_NAME,
				user,
				conv,
				pamh ) ) {
    fprintf( stderr, _("failed to initialize PAM\n") );
    exit( -1 );
  }

  if( PAM_SUCCESS != pam_set_item(*pamh, PAM_RUSER, user))
    {
      fprintf( stderr, _("failed to pam_set_item()\n") );
      exit( -1 );
    }

  /* Ask PAM to authenticate the user running this program */
  if( PAM_SUCCESS == pam_authenticate(*pamh,0) ) {
    result = 1;  /* user authenticated OK! */
  }
  pam_open_session(*pamh, 0);
  return( result );

} /* authenticate_via_pam() */

int main(int argc, char **argv) {
  pam_handle_t *pamh;
  int childPid;
  if (!authenticate_via_pam(argv[1],&pamh))
    exit(-1);

  childPid = fork();
  if (childPid < 0) {
    int errsv = errno;
       /* error in fork() */
    fprintf(stderr, _("login: failure forking: %s"), strerror(errsv));
    pam_close_session(pamh, 0);
    /* We're done with PAM.  Free `pam_handle'. */
    pam_end( pamh, PAM_SUCCESS );
    exit(0);
  }
  if (childPid) {
    close(0); close(1); close(2); 
    struct sigaction sa;
    memset(&sa,0,sizeof(sa));
    sa.sa_handler = SIG_IGN;
    sigaction(SIGQUIT, &sa, NULL);
    sigaction(SIGINT, &sa, NULL);
    while(wait(NULL) == -1 && errno == EINTR) /**/ ;
    openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
    pam_close_session(pamh, 0);
    /* We're done with PAM.  Free `pam_handle'. */
    pam_end( pamh, PAM_SUCCESS );
    exit(0);
  }
  argv[0]="/bin/tcsh";
  argv[1]=NULL;
  execv("/bin/tcsh",argv);
  fprintf(stderr,"Failure\n");
  return 0;
}
#endif

--------------030902070507020502000207--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
