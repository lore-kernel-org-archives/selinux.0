Message-ID: <1485365934.15074.64.camel@tycho.nsa.gov>
Subject: Re: pam_selinux: add new option to select from default_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Date: Wed, 25 Jan 2017 12:38:54 -0500
In-Reply-To: <CAJ2a_DePfW-F9Y48mr33XDg1s4RJE9-M_OToTpREQEaCP2DZnw@mail.gmail.com>
References: <CAJ2a_DePfW-F9Y48mr33XDg1s4RJE9-M_OToTpREQEaCP2DZnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-25 at 18:26 +0100, cgzones wrote:
> Hi list,
> I created patch against pam_selinux, which is reported here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=852540
> Laurent suggested to post it also on this ML for discussion.
> 
> 
> When an SELinux unaware login application, like sddm, tries to set up
> sessions via pam, it is not possible to set the new SELinux context
> accordingly.
> 
> This patch adds an option to pam_selinux.so, so that via different
> pam
> configurations, like sddm does it
> https://github.com/sddm/sddm/blob/develop/src/helper/backend/PamBacke
> nd.cpp#L220,
> different contexts can be assigned.

Why do you need to use a context other than the first one, which is
supposed to be the highest priority/preferred context based on the
global and per-user configuration files?  I don't understand the use
case.

Even with a use case, this approach seems very brittle; you are relying
on a fixed order beyond just the fact that the first one is the highest
priority/preferred default value.

> 
> From: cgzones <cgzones@googlemail.com>
> Date: Tue, 3 Jan 2017 12:04:20 +0100
> Subject: [PATCH] pam_selinux: add select_default_context option
> 
> ---
> modules/pam_selinux/README            | 11 +++++++++
> modules/pam_selinux/pam_selinux.8     | 11 ++++++++-
> modules/pam_selinux/pam_selinux.8.xml | 19 +++++++++++++++
> modules/pam_selinux/pam_selinux.c     | 46
> ++++++++++++++++++++++++++++++-----
> 4 files changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/modules/pam_selinux/README b/modules/pam_selinux/README
> index fb4d449..b1b6be2 100644
> --- a/modules/pam_selinux/README
> +++ b/modules/pam_selinux/README
> @@ -72,6 +72,17 @@ use_current_range
>     instead of the default level. Also suppresses asking of the
> sensitivity
>     level from the user or obtaining it from PAM environment.
> 
> +select_default_context=
> +
> +    Select a specific context from the list of default contexts for
> the login
> +    user returned by SELinux. By default the first entry is taken.
> +    Valid values are 'last' or positiv numbers, to select a
> different context.
> +    The list of available contexts can be viewed by 'compute_user
> src_context seuser'.
> +
> +    Usage:
> +        select_default_context=2
> +        select_default_context=last
> +
> EXAMPLES
> 
> auth     required  pam_unix.so
> diff --git a/modules/pam_selinux/pam_selinux.8
> b/modules/pam_selinux/pam_selinux.8
> index acd4f0d..d936cb9 100644
> --- a/modules/pam_selinux/pam_selinux.8
> +++ b/modules/pam_selinux/pam_selinux.8
> @@ -31,7 +31,7 @@
> pam_selinux \- PAM module to set the default security context
> .SH "SYNOPSIS"
> .HP \w'\fBpam_selinux\&.so\fR\ 'u
> -\fBpam_selinux\&.so\fR [open] [close] [restore] [nottys] [debug]
> [verbose] [select_context] [env_params] [use_current_range]
> +\fBpam_selinux\&.so\fR [open] [close] [restore] [nottys] [debug]
> [verbose] [select_context] [env_params] [use_current_range]
> [select_default_context=\fIlast|context_number\fR]
> .SH "DESCRIPTION"
> .PP
> pam_selinux is a PAM module that sets up the default SELinux security
> context for the next executed process\&.
> @@ -99,6 +99,15 @@ Attempt to obtain a custom security context role
> from PAM environment\&. If MLS
> .RS 4
> Use the sensitivity level of the current process for the user context
> instead of the default level\&. Also suppresses asking of the
> sensitivity level from the user or obtaining it from PAM
> environment\&.
> .RE
> +.PP
> +\fBselect_default_context\fR
> +.RS 4
> +Select a specific context from the list of default contexts for the
> login user returned by SELinux\&. By default the first entry is
> taken\&. Valid values are 'last' or positiv numbers, to select a
> different context\&. The list of a
> vailable contexts can be viewed by 'compute_user src_context
> seuser'\&.
> +.RS 2
> +Usage:
> +.RS 2
> +select_default_context=2
> +.RE
> .SH "MODULE TYPES PROVIDED"
> .PP
> Only the
> diff --git a/modules/pam_selinux/pam_selinux.8.xml
> b/modules/pam_selinux/pam_selinux.8.xml
> index 28d465f..210e262 100644
> --- a/modules/pam_selinux/pam_selinux.8.xml
> +++ b/modules/pam_selinux/pam_selinux.8.xml
> @@ -45,6 +45,9 @@
>       <arg choice="opt">
>        use_current_range
>       </arg>
> +      <arg choice="opt">
> +        select_default_context=<replaceable>conf-file</replaceable>
> +      <arg>
>     </cmdsynopsis>
>   </refsynopsisdiv>
> 
> @@ -188,6 +191,22 @@
>           </para>
>         </listitem>
>       </varlistentry>
> +      <varlistentry>
> +        <term>
> +          <option>select_default_context=<replaceable>last|context_n
> umber</replaceable></option>
> +        </term>
> +        <listitem>
> +          <para>
> +            Select a specific context from the list of default
> contexts for the login
> +            user returned by SELinux. By default the first entry is
> taken.
> +            Valid values are 'last' or positiv numbers, to select a
> different context.
> +            The list of available contexts can be viewed by
> 'compute_user src_context seuser'.
> +            Usage:
> +              select_default_context=2
> +              select_default_context=last
> +          </para>
> +        </listitem>
> +      </varlistentry>
>     </variablelist>
>   </refsect1>
> 
> diff --git a/modules/pam_selinux/pam_selinux.c
> b/modules/pam_selinux/pam_selinux.c
> index b96cc23..446b4fb 100644
> --- a/modules/pam_selinux/pam_selinux.c
> +++ b/modules/pam_selinux/pam_selinux.c
> @@ -63,8 +63,6 @@
> 
> #include <selinux/selinux.h>
> #include <selinux/get_context_list.h>
> -#include <selinux/flask.h>
> -#include <selinux/av_permissions.h>
> #include <selinux/selinux.h>
> #include <selinux/context.h>
> #include <selinux/get_default_type.h>
> @@ -480,7 +478,8 @@ set_file_context(const pam_handle_t *pamh,
> security_context_t context,
> static int
> compute_exec_context(pam_handle_t *pamh, module_data_t *data,
>                     int select_context, int use_current_range,
> -                    int env_params, int debug)
> +                    int env_params, int debug,
> +                    const char *select_default_context)
> {
>   const char *username;
> 
> @@ -491,6 +490,7 @@ compute_exec_context(pam_handle_t *pamh,
> module_data_t *data,
>   char *level = NULL;
>   security_context_t *contextlist = NULL;
>   int num_contexts = 0;
> +  int selected_context;
> 
>   if (!(username = get_item(pamh, PAM_USER))) {
>     pam_syslog(pamh, LOG_ERR, "Cannot obtain the user name");
> @@ -516,7 +516,27 @@ compute_exec_context(pam_handle_t *pamh,
> module_data_t *data,
>   }
>   if (num_contexts > 0) {
>     free(seuser);
> -    data->default_user_context = strdup(contextlist[0]);
> +    if (select_default_context) {
> +      pam_syslog(pamh, LOG_DEBUG,
> +                  "Selecting default context based on %s from %d
> contexts",
> +                  select_default_context, num_contexts);
> +      if (num_contexts == 1) {
> +        data->default_user_context = strdup(contextlist[0]);
> +      } else if (strcmp(select_default_context, "last") == 0) {
> +        data->default_user_context = strdup(contextlist[num_contexts
> - 1]);
> +      } else {
> +        selected_context = atoi(select_default_context);
> +        if (selected_context <= 0 || selected_context >
> num_contexts) {
> +          pam_syslog(pamh, LOG_ERR,
> +                "Invalid select option %s for %d contexts, fallback
> to default",
> +                select_default_context, num_contexts);
> +          selected_context = 1;
> +        }
> +        data->default_user_context =
> strdup(contextlist[selected_context - 1]);
> +      }
> +    } else {
> +      data->default_user_context = strdup(contextlist[0]);
> +    }
>      freeconary(contextlist);
>     if (!data->default_user_context) {
>       pam_syslog(pamh, LOG_ERR, "Out of memory");
> @@ -549,6 +569,7 @@ static int
> compute_tty_context(const pam_handle_t *pamh, module_data_t *data)
> {
>   const char *tty = get_item(pamh, PAM_TTY);
> +  security_class_t tclass;
> 
>   if (!tty || !*tty || !strcmp(tty, "ssh") || !strncmp(tty, "NODEV",
> 5)) {
>     tty = ttyname(STDIN_FILENO);
> @@ -584,8 +605,13 @@ compute_tty_context(const pam_handle_t *pamh,
> module_data_t *data)
>     return (security_getenforce() == 1) ? PAM_SESSION_ERR :
> PAM_SUCCESS;
>   }
> 
> +  tclass = string_to_security_class("chr_file");
> +  if (!tclass) {
> +    pam_syslog(pamh, LOG_ERR, "Failed to translate security class
> context. %m");
> +    return PAM_SESSION_ERR;
> +  }
>   if (security_compute_relabel(data->exec_context, data-
> >prev_tty_context,
> -                              SECCLASS_CHR_FILE, &data-
> >tty_context)) {
> +                              tclass, &data->tty_context)) {
>     data->tty_context = NULL;
>     pam_syslog(pamh, LOG_ERR, "Failed to compute new context for %s:
> %m",
>               data->tty_path);
> @@ -691,6 +717,9 @@ create_context(pam_handle_t *pamh, int argc,
> const
> char **argv,
>   int select_context = 0;
>   int use_current_range = 0;
>   int env_params = 0;
> +  const char *select_default_context = NULL;
> +  const char *select_default_context_str = "select_default_context";
> +  const size_t select_default_context_len =
> strlen(select_default_context_str);
>   module_data_t *data;
> 
>   /* Parse arguments. */
> @@ -707,6 +736,11 @@ create_context(pam_handle_t *pamh, int argc,
> const char **argv,
>     if (strcmp(argv[i], "env_params") == 0) {
>       env_params = 1;
>     }
> +    if (strncmp(argv[i], select_default_context_str,
> +          select_default_context_len) == 0
> +        && argv[i][select_default_context_len] == '=') {
> +      select_default_context = argv[i] + select_default_context_len
> + 1;
> +    }
>   }
> 
>   if (is_selinux_enabled() <= 0) {
> @@ -727,7 +761,7 @@ create_context(pam_handle_t *pamh, int argc,
> const
> char **argv,
>   }
> 
>   i = compute_exec_context(pamh, data, select_context,
> use_current_range,
> -                          env_params, debug);
> +                          env_params, debug,
> select_default_context);
>   if (i != PAM_SUCCESS) {
>     free_module_data(data);
>     return i;
> --
> 2.11.0
> 
> 
> 
> Best Regards,
>        Christian Göttsche
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
