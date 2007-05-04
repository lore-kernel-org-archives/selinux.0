Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <463B81F3.7030802@gmail.com>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
	 <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
	 <463B81F3.7030802@gmail.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 15:23:49 -0400
Message-Id: <1178306629.677.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 13:56 -0500, Ted X Toth wrote:
> Stephen Smalley wrote:
> > How about the revised patch below (only including the newrole.c and
> > Makefile diffs since the hashtab code is unchanged)?  The changes from
> > your patch are:
> > - Make sure everything is properly enabled/disabled by USE_PAM and move
> > the code into the existing USE_PAM block where appropriate.
> > - Call the config file newrole_pam.conf since there could be other
> > newrole config files in the future.
> > - Distinguish missing config file (ok) from errors during parsing of the
> > config file (should abort).
> > - Remove the Authenticating <username> message since it could be
> > confusing in the case where you are using a pam config that doesn't
> > require it and it doesn't really provide any benefit.
> > - Improve error checking and handling.
> > - Coding style cleanups (indentation, comment style, etc).
> >
> > To test, I created a /etc/pam.d/newrole-noauth config that had
> > pam_permit.so for its auth module and created
> > a /etc/selinux/newrole_pam.conf that mapped one program to
> > newrole-noauth.
> >
> > The alternative model would be to eliminate /etc/selnux/newrole_pam.conf
> > entirely from the equation, and just have newrole look for (test via
> > access()) a /etc/pam.d/newrole_<appname> config and use
> > newrole_<appname> as the service name if present.
> >   
> 
> I like it but one thing I had thought about was that if the current 
> patch were to check for the existence of the pam configuration file 
> (service name) and the file was missing the user could be warned of 
> that. Of course there is no help in the event that newrole_pam.conf is 
> misconfigured.

Sorry, are you suggesting eliminating the need for newrole_pam.conf
altogether (as I described above as an alternative, implicitly mapping
each app to a newrole_<app> service name if present) or retaining it but
just adding a test for the presence of the pam config for error
reporting purposes?

I'll incorporate Darrel's suggestion about using the basename() of the
command in the next version of the patch.


> > Index: policycoreutils/newrole/newrole.c
> > ===================================================================
> > --- policycoreutils/newrole/newrole.c	(revision 2422)
> > +++ policycoreutils/newrole/newrole.c	(working copy)
> > @@ -58,6 +58,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>		/* for malloc(), realloc(), free() */
> >  #include <pwd.h>		/* for getpwuid() */
> > +#include <ctype.h>
> >  #include <sys/types.h>		/* to make getuid() and getpwuid() happy */
> >  #include <sys/wait.h>		/* for wait() */
> >  #include <getopt.h>		/* for getopt_long() form of getopt() */
> > @@ -92,6 +93,10 @@
> >  /* USAGE_STRING describes the command-line args of this program. */
> >  #define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -p ] [ -V ] [ -- args ]"
> >  
> > +#ifdef USE_PAM
> > +#define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf";
> > +#endif
> > +
> >  #define DEFAULT_PATH "/usr/bin:/bin"
> >  #define DEFAULT_CONTEXT_SIZE 255	/* first guess at context size */
> >  
> > @@ -159,7 +164,7 @@
> >  #include <security/pam_appl.h>	/* for PAM functions */
> >  #include <security/pam_misc.h>	/* for misc_conv PAM utility function */
> >  
> > -#define SERVICE_NAME "newrole"	/* the name of this program for PAM */
> > +char *service_name = "newrole";
> >  
> >  /* authenticate_via_pam()
> >   *
> > @@ -209,6 +214,113 @@
> >  	return result;
> >  }				/* authenticate_via_pam() */
> >  
> > +#include "hashtab.h"
> > +
> > +static int free_hashtab_entry(hashtab_key_t key, hashtab_datum_t d, 
> > +			      void *args __attribute__ ((unused)) )
> > +{
> > +	free(key);
> > +	free(d);
> > +	return 0;
> > +}
> > +
> > +static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
> > +{
> > +	char *p, *keyp;
> > +	size_t size;
> > +	unsigned int val;
> > +
> > +	val = 0;
> > +	keyp = (char *)key;
> > +	size = strlen(keyp);
> > +	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
> > +		val =
> > +		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
> > +	return val & (h->size - 1);
> > +}
> > +
> > +static int reqsymcmp(hashtab_t h
> > +		     __attribute__ ((unused)), hashtab_key_t key1,
> > +		     hashtab_key_t key2)
> > +{
> > +	char *keyp1, *keyp2;
> > +
> > +	keyp1 = (char *)key1;
> > +	keyp2 = (char *)key2;
> > +	return strcmp(keyp1, keyp2);
> > +}
> > +
> > +static hashtab_t app_service_names = NULL;
> > +#define PAM_SERVICE_SLOTS 64
> > +
> > +static int process_pam_config(FILE * cfg)
> > +{
> > +	const char *config_file_path = PAM_SERVICE_CONFIG;
> > +	char *line_buf = NULL;
> > +	unsigned long lineno = 0;
> > +	size_t len = 0;
> > +	char *app = NULL;
> > +	char *service = NULL;
> > +	int ret;
> > +
> > +	while (getline(&line_buf, &len, cfg) > 0) {
> > +		char *buffer = line_buf;
> > +		lineno++;
> > +		while (isspace(*buffer))
> > +			buffer++;
> > +		if (buffer[0] == '#')
> > +			continue;
> > +		if (buffer[0] == '\n' || buffer[0] == '\0')
> > +			continue;
> > +
> > +		app = service = NULL;
> > +		ret = sscanf(buffer, "%as %as\n", &app, &service);
> > +		if (ret < 2 || !app || !service)
> > +			goto err;
> > +
> > +		ret = hashtab_insert(app_service_names, app, service);
> > +		if (ret == HASHTAB_OVERFLOW) {
> > +			fprintf(stderr,
> > +				_("newrole: service name configuration hashtable overflow\n"));
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	free(line_buf);
> > +	return 0;
> > +      err:
> > +	free(app);
> > +	free(service);
> > +	fprintf(stderr,	_("newrole:  %s:  error on line %lu.\n"), config_file_path, lineno);
> > +	free(line_buf);
> > +	return -1;
> > +}
> > +
> > +/* 
> > + *  Read config file ignoring comment lines.
> > + *  Files specified one per line executable with a corresponding
> > + *  pam service name.
> > + */
> > +static int read_pam_config()
> > +{
> > +	const char *config_file_path = PAM_SERVICE_CONFIG;
> > +	FILE *cfg = NULL;
> > +	cfg = fopen(config_file_path, "r");
> > +	if (!cfg)
> > +		return 0;	/* This configuration is optional. */
> > +	app_service_names =
> > +	    hashtab_create(reqsymhash, reqsymcmp, PAM_SERVICE_SLOTS);
> > +	if (!app_service_names)
> > +		goto err;
> > +	if (process_pam_config(cfg))
> > +		goto err;
> > +	fclose(cfg);
> > +	return 0;
> > +      err:
> > +	fclose(cfg);
> > +	return -1;
> > +}
> > +
> >  #else				/* else !USE_PAM */
> >  
> >  /************************************************************************
> > @@ -1027,9 +1139,33 @@
> >  	if (extract_pw_data(&pw))
> >  		goto err_free;
> >  
> > -	printf(_("Authenticating %s.\n"), pw.pw_name);
> >  #ifdef USE_PAM
> > -	pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
> > +	if (read_pam_config()) {
> > +		fprintf(stderr, _("error on reading PAM service configuration.\n"));
> > +		goto err_free;
> > +	}
> > +
> > +	if (app_service_names != NULL && optind < argc) {
> > +		if (strcmp(argv[optind], "-c") == 0 && optind < (argc - 1)) {
> > +			/*
> > +			 * Check for a separate pam service name for the command when
> > +			 * invoked by newrole.
> > +			 */
> > +			char *cmd = NULL;
> > +			rc = sscanf(argv[optind + 1], "%as", &cmd);
> > +			if (rc != EOF && cmd != NULL) {
> > +				char *app_service_name =
> > +				    (char *)hashtab_search(app_service_names,
> > +							   cmd);
> > +				free(cmd);
> > +				if (app_service_name != NULL) {
> > +					service_name = app_service_name;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	pam_status = pam_start(service_name, pw.pw_name, &pam_conversation,
> >  			       &pam_handle);
> >  	if (pam_status != PAM_SUCCESS) {
> >  		fprintf(stderr, _("failed to initialize PAM\n"));
> > @@ -1118,6 +1254,8 @@
> >  				pam_strerror(pam_handle, rc));
> >  			exit_code = -1;
> >  		}
> > +		hashtab_map(app_service_names, free_hashtab_entry, NULL);
> > +		hashtab_destroy(app_service_names);
> >  #endif
> >  		free(pw.pw_name);
> >  		free(pw.pw_dir);
> > @@ -1223,5 +1361,11 @@
> >  	free(pw.pw_dir);
> >  	free(pw.pw_shell);
> >  	free(shell_argv0);
> > +#ifdef USE_PAM
> > +	if (app_service_names) {
> > +		hashtab_map(app_service_names, free_hashtab_entry, NULL);
> > +		hashtab_destroy(app_service_names);
> > +	}
> > +#endif
> >  	return -1;
> >  }				/* main() */
> > Index: policycoreutils/newrole/Makefile
> > ===================================================================
> > --- policycoreutils/newrole/Makefile	(revision 2422)
> > +++ policycoreutils/newrole/Makefile	(working copy)
> > @@ -21,10 +21,12 @@
> >  VERSION = $(shell cat ../VERSION)
> >  
> >  CFLAGS ?= -Werror -Wall -W
> > +EXTRA_OBJS =
> >  override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> >  LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
> >  ifeq (${PAMH}, /usr/include/security/pam_appl.h)
> >  	override CFLAGS += -DUSE_PAM
> > +	EXTRA_OBJS += hashtab.o
> >  	LDLIBS += -lpam -lpam_misc
> >  else
> >  	override CFLAGS += -D_XOPEN_SOURCE=500
> > @@ -53,9 +55,10 @@
> >  	MODE := 0555
> >  endif
> >  
> > -TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> > +all: newrole
> >  
> > -all: $(TARGETS)
> > +newrole: newrole.o $(EXTRA_OBJS)
> > +	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >  
> >  install: all
> >  	test -d $(BINDIR)      || install -m 755 -d $(BINDIR)
> >
> >   
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
