Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40705021442jc055137rd11f1d70330d4b16@mail.gmail.com>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705021442jc055137rd11f1d70330d4b16@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 08:35:35 -0400
Message-Id: <1178195735.3443.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 16:42 -0500, Xavier Toth wrote:
> On 5/2/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2007-05-02 at 10:49 -0500, Xavier Toth wrote:
> > > Stephen.
> > > I'd appreciate you reviewing this proposed patch.
> > >
> > > Ted
> >
> > A few initial comments after a quick look (not a full review yet)
> >
> > --- policycoreutils-1.33.12/newrole/newrole.c   2007-05-02 10:45:14.000000000 -0500
> > +++ policycoreutils-1.33.12.new/newrole/newrole.c       2007-05-02 10:45:05.000000000 -0500
> > @@ -54,6 +54,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>            /* for malloc(), realloc(), free() */
> >  #include <pwd.h>               /* for getpwuid() */
> > +#include <ctype.h>
> >  #include <sys/types.h>         /* to make getuid() and getpwuid() happy */
> >  #include <sys/wait.h>          /* for wait() */
> >  #include <getopt.h>            /* for getopt_long() form of getopt() */
> > @@ -85,6 +86,8 @@
> >  #define PACKAGE "policycoreutils"      /* the name of this package lang translation */
> >  #endif
> >
> > +#include <sepol/policydb/hashtab.h>
> >
> > We don't want newrole to link with the static libsepol, so if you want
> > to use the libsepol hashtab (and symtab) support, copy it into the
> > newrole directory.
> >
> > +static void process_config(FILE * cfg)
> > +{
> > +       char *line_buf = NULL;
> > +       size_t len = 0;
> > +       size_t current_size = 0;
> > +       char *app = NULL;
> > +       char *service = NULL;
> > +       int ret;
> > +       char *local_app = NULL;
> > +       char *local_service_name = NULL;
> > +
> > +       while (getline(&line_buf, &len, cfg) > 0) {
> > +         char *buffer = line_buf;
> > +         while (isspace(*buffer))
> > +           buffer++;
> > +         if (buffer[0] == '#')
> > +           continue;
> > +         int l = strlen(buffer) - 1;
> > +         if (l <= 0)
> > +           continue;
> > +         buffer[l] = 0;
> > +         if (local_app == NULL) {
> > +           current_size = len;
> > +           local_app = malloc(current_size);
> > +           local_service_name = malloc(current_size);
> >
> > General comment:  Always check for failure on function calls, and handle errors.
> >
> > +         sscanf(buffer, "%s %s", local_app, local_service_name);
> >
> > You could just strtok() the buffer or similar to avoid making copies.
> > Or if you need a copy, you can use the %as format to have glibc allocate the memory
> > for you automatically.
> >
> > +/*
> > +   Read config file ignoring comment lines.
> > +   Files specified one per line executable with a corresponding
> > +   pam service name.
> > +*/
> > +
> > +static void read_config()
> > +{
> > +       char *config_file_path = "/etc/selinux/newrole.conf";
> > +       app_service_names = hashtab_create(reqsymhash, reqsymcmp, 64);
> >
> > Check for failure.
> >
> > +static void free_hashtab(hashtab_t req)
> > +{
> > +       unsigned int i;
> > +       hashtab_ptr_t cur;
> > +
> > +       for (i = 0; i < req->size; i++) {
> > +               cur = req->htable[i];
> > +               while (cur != NULL) {
> > +                 free(cur->datum);
> > +                 free(cur->key);
> > +                 cur = cur->next;
> > +               }
> > +       }
> > +       hashtab_destroy(req);
> > +}
> >
> > Breaks the "abstraction".  Normally this would be done as a
> > hashtab_map() to free the keys and datum followed by a hashtab_destroy()
> > to free the table.  Or if you want a unified form, you could do
> > something like hashtab_map_remove_on_error() except always doing the
> > removal, but put it in your copy of the hashtab code.
> >
> > @@ -1025,7 +1166,27 @@
> >
> >         printf(_("Authenticating %s.\n"), pw.pw_name);
> >  #ifdef USE_PAM
> > -       pam_status = pam_start(SERVICE_NAME, pw.pw_name, &pam_conversation,
> > +       /*
> > +         Are we being asked to execute a process in a new context?
> > +       */
> > +       if (optind < argc) {
> > +         /*
> > +           Get the executable from the command line.
> > +         */
> > +         char *cmd = (char *)malloc(strlen(argv[optind+1]));
> >
> > argv[optind+1] or argv[optind]?  And you'd need to add 1 to the length (not optind) for terminating NUL.
> >
> > +         sscanf(argv[optind+1], "%s", cmd);
> >
> > Pointless, argument vector has already been parsed by the shell.
> > Just use argv[optind] directly, no copy required.
> >
> > +         /*
> > +           See if there is a pam configuration specific to the executable.
> > +         */
> > +         char* app_service_name =
> > +           (char *) hashtab_search(app_service_names, cmd);
> >
> > I think you want to qualify these with a prefix so that if <app> also
> > uses pam, then there is no ambiguity between the pam configuration for
> > the <app> itself vs. the pam configuration used by newrole when
> > launching the <app>.  e.g. prefix them with "newrole_".
> 
> Are you talking about something more than a convention? Like the code
> enforcing this somehow?

Since you are putting the service names into a config file, it can just
be a convention, but it is important to note.  Otherwise, someone might
just use the application name as the pam service name, which could lead
to problems if the application already has a pam config of its own.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
