Subject: Re: adding LANG and XMODIFIER to newrole minimal environment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <cadfc0e40903151003l367d0f73j8a45e3332fe44763@mail.gmail.com>
References: <cadfc0e40903140914n681c634fw5945242dab71f139@mail.gmail.com>
	 <cadfc0e40903151003l367d0f73j8a45e3332fe44763@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 11:27:30 -0400
Message-Id: <1237390050.12822.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-03-15 at 17:03 +0000, Xavier Toth wrote:
> On Sat, Mar 14, 2009 at 4:14 PM, Xavier Toth <txtoth@gmail.com> wrote:
> > Stephan,
> > What would you think of adding LANG and XMODIFIER to newroles minimal
> > environment for internationalization support? Alternatively maybe
> > newrole could support an option which is a list of env variables to
> > maintain.
> >
> > Ted
> >
> 
> Possible patch:

A few comments below on the code.  As for the approach, I'd be more
inclined to read the set of minimal environment variables from a config
file than to make it a command-line option.

I'm also unclear on why newrole even provides this minimal environment
vs. having the caller handle it, given that the caller is already free
to change its environment at will and then use -p to preserve it for the
new shell.  I suppose it is just a convenience.  Whether or not newrole
ought to allow the caller to convey arbitrary environment to the
newrole'd shell seems more questionable.  Of course there is the glibc
sanitization upon transitioning to newrole_t, but that only affects a
small set of variables.


> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> --- policycoreutils-2.0.57/newrole/newrole.c.orig	2009-03-15
> 16:53:09.000000000 +0000
> +++ policycoreutils-2.0.57/newrole/newrole.c	2009-03-15 16:53:15.000000000 +0000
> @@ -10,7 +10,7 @@
>   *
>   * USAGE:
>   *
> - * newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]
> + * newrole [-e environment variables ] [ -r role ] [ -t type ] [ -l
> level ] [ -V ] [ -- args ]
>   *
>   * BUILD OPTIONS:
>   *
> @@ -91,7 +91,7 @@
>  #endif
> 
>  /* USAGE_STRING describes the command-line args of this program. */
> -#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l
> level ] [ -p ] [ -V ] [ -- args ]"
> +#define USAGE_STRING "USAGE: newrole [-e environment variables ] [ -r
> role ] [ -t type ] [ -l level ] [ -p ] [ -V ] [ -- args ]"
> 
>  #ifdef USE_PAM
>  #define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf";
> @@ -102,6 +102,11 @@
> 
>  extern char **environ;
> 
> +typedef struct {
> +	char *name;
> +	char *value;
> +}  env_vars_type;
> +
>  /**
>   * Construct from the current range and specified desired level a resulting
>   * range. If the specified level is a range, return that. If it is not, then
> @@ -472,7 +477,7 @@
>   * Returns zero on success, non-zero otherwise
>   */
>  static int restore_environment(int preserve_environment,
> -			       char **old_environ, const struct passwd *pw)
> +			       char **old_environ, const struct passwd *pw, char *env_vars)
>  {
>  	char const *term_env;
>  	char const *display_env;
> @@ -481,6 +486,8 @@
>  	char *display = NULL;	/* temporary container */
>  	char *xauthority = NULL;	/* temporary container */
>  	int rc;
> +	env_vars_type *evars = NULL;
> +	env_vars_type *evars_ptr = NULL;
> 
>  	environ = old_environ;
> 
> @@ -491,6 +498,29 @@
>  	display_env = getenv("DISPLAY");
>  	xauthority_env = getenv("XAUTHORITY");
> 
> +	if (env_vars != NULL) {
> +		int index = 0;
> +		int size = 0;
> +		char * tok = strtok(env_vars, ",");
> +		while (tok != NULL) {
> +			if (getenv(tok) != NULL) {
> +				size += sizeof(env_vars_type);
> +				evars = (char*)realloc((char*)evars, size)

Unnecessary type cast (realloc returns void*), and wrong anyway (evars
isn't a char*).

And realloc() can fail.

> ;
> +				evars_ptr = evars + index;
> +				evars_ptr->name = strdup(tok);
> +				evars_ptr->value = strdup(getenv(tok));

getenv() might fail, and strdup() can fail.

> +				index++;
> +			}
> +			tok = strtok(NULL,",");
> +		}
> +		size += sizeof(env_vars_type);
> +		evars = (char*)realloc((char*)evars, size);

Same as above.

> +		evars_ptr = evars + index;
> +		evars_ptr->name = NULL;
> +		evars_ptr->value = NULL;
> +		free(env_vars);
> +	}
> +	
>  	/* Save the variable values we want */
>  	if (term_env)
>  		term = strdup(term_env);
> @@ -522,6 +552,13 @@
>  	rc |= setenv("USER", pw->pw_name, 1);
>  	rc |= setenv("LOGNAME", pw->pw_name, 1);
>  	rc |= setenv("PATH", DEFAULT_PATH, 1);
> +
> +	if (evars != NULL) {
> +		for (evars_ptr = evars; evars_ptr->name != NULL;  evars_ptr++) {
> +			rc |= setenv(evars_ptr->name, evars_ptr->value, 1);
> +		}
> +		free(evars);
> +	}
>        out:
>  	free(term);
>  	free(display);
> @@ -859,7 +896,8 @@
>  static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
>  					security_context_t old_context,
>  					security_context_t * new_context,
> -					int *preserve_environment)
> +					int *preserve_environment,
> +					char **env_vars)
>  {
>  	int flag_index;		/* flag index in argv[] */
>  	int clflag;		/* holds codes for command line flags */
> @@ -877,12 +915,13 @@
>  		{"level", 1, 0, 'l'},
>  		{"preserve-environment", 0, 0, 'p'},
>  		{"version", 0, 0, 'V'},
> +		{"environment-variables", 1, 0, 'e'},
>  		{NULL, 0, 0, 0}
>  	};
> 
>  	*preserve_environment = 0;
>  	while (1) {
> -		clflag = getopt_long(argc, argv, "r:t:l:pV", long_options,
> +		clflag = getopt_long(argc, argv, "r:t:l:pVe:", long_options,
>  				     &flag_index);
>  		if (clflag == -1)
>  			break;
> @@ -895,6 +934,14 @@
>  		case 'p':
>  			*preserve_environment = 1;
>  			break;
> +		case 'e':
> +			if (*env_vars) {
> +				fprintf(stderr,
> +					_("Error: multiple environment variable lists specified\n"));
> +				return -1;
> +			}
> +			*env_vars = strdup(optarg);
> +			break;
>  		case 'r':
>  			if (role_s) {
>  				fprintf(stderr,
> @@ -939,11 +986,16 @@
>  			level_s = optarg;
>  			break;
>  		default:
> -			fprintf(stderr, "%s\n", USAGE_STRING);
> +		        fprintf(stderr, "%s\n", USAGE_STRING);
>  			return -1;
>  		}
>  	}
> 
> +	if (*preserve_environment && *env_vars) {
> +	        free(*env_vars);
> +		*env_vars = NULL;
> +	}
> +
>  	/* Verify that the combination of command-line arguments are viable */
>  	if (!(role_s || type_s || level_s)) {
>  		fprintf(stderr, "%s\n", USAGE_STRING);
> @@ -1076,6 +1128,7 @@
>  	int fd;
>  	pid_t childPid = 0;
>  	char *shell_argv0 = NULL;
> +	char *env_vars = NULL;
> 
>  #ifdef USE_PAM
>  	int rc;
> @@ -1141,7 +1194,7 @@
>  	}
> 
>  	if (parse_command_line_arguments(argc, argv, ttyn, old_context,
> -					 &new_context, &preserve_environment))
> +					 &new_context, &preserve_environment, &env_vars))
>  		return -1;
> 
>  	/*
> @@ -1342,7 +1395,7 @@
>  	freecon(new_context);
> 
>  	/* Handle environment changes */
> -	if (restore_environment(preserve_environment, old_environ, &pw)) {
> +	if (restore_environment(preserve_environment, old_environ, &pw, env_vars)) {
>  		fprintf(stderr, _("Unable to restore the environment, "
>  				  "aborting\n"));
>  		goto err_close_pam_session;
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
