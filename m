MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 14/15] [src-policy] semodule: user message support
Date: Mon, 1 Feb 2010 12:00:38 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E0199EF92@exchange2.columbia.tresys.com>
In-Reply-To: <1265037112.2128.4.camel@localhost>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com> <1264543701-20638-2-git-send-email-ccase@tresys.com> <1264543701-20638-3-git-send-email-ccase@tresys.com> <1264543701-20638-4-git-send-email-ccase@tresys.com> <1264543701-20638-5-git-send-email-ccase@tresys.com> <1264543701-20638-6-git-send-email-ccase@tresys.com> <1264543701-20638-7-git-send-email-ccase@tresys.com> <1264543701-20638-8-git-send-email-ccase@tresys.com> <1264543701-20638-9-git-send-email-ccase@tresys.com> <1264543701-20638-10-git-send-email-ccase@tresys.com> <1264543701-20638-11-git-send-email-ccase@tresys.com> <1264543701-20638-12-git-send-email-ccase@tresys.com> <1264543701-20638-13-git-send-email-ccase@tresys.com> <1264543701-20638-14-git-send-email-ccase@tresys.com> <1264543701-20638-15-git-send-email-ccase@tresys.com> <1265037112.2128.4.camel@localhost>
From: "Caleb Case" <ccase@tresys.com>
To: <jwcart2@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Sellers" <csellers@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>,
        "Joshua Brindle" <jbrindle@tresys.com>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: James Carter [mailto:jwcart2@tycho.nsa.gov]
> Sent: Monday, February 01, 2010 10:12 AM
> To: Caleb Case
> Cc: selinux@tycho.nsa.gov; Chad Sellers; Karl MacMillan; Joshua
Brindle;
> sds@tycho.nsa.gov
> Subject: Re: [PATCH 14/15] [src-policy] semodule: user message support
> 
> On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> > This adds the -m,--message option to semodule so that users can
specify
> > a message for the ChangeLog.
> >
> 
> Is there plans to add user message support to semanage?
Unfortunately,
> in semanage "-m" is already in use.

Yes, maybe -M is better so we can use the same flag in both tools?

> 
> >   -m,--message=MSG user message for the ChangeLog
> >
> > Example:
> >
> > # semodule -E alsa -m "Allow alsa to execute cowsay."
> > ---
> >  policycoreutils/semodule/semodule.8 |    3 +++
> >  policycoreutils/semodule/semodule.c |   24 +++++++++++++++++++++++-
> >  2 files changed, 26 insertions(+), 1 deletions(-)
> >
> > diff --git a/policycoreutils/semodule/semodule.8
> b/policycoreutils/semodule/semodule.8
> > index 8baad8b..97d31dd 100644
> > --- a/policycoreutils/semodule/semodule.8
> > +++ b/policycoreutils/semodule/semodule.8
> > @@ -87,6 +87,9 @@ prints help message and quit
> >  .TP
> >  .B  \-v,\-\-verbose
> >  be verbose
> > +.TP
> > +.B  \-m,\-\-message=MSG
> > +user message for the ChangeLog
> >
> >  .SH EXAMPLE
> >  .nf
> > diff --git a/policycoreutils/semodule/semodule.c
> b/policycoreutils/semodule/semodule.c
> > index 3536253..c8bf986 100644
> > --- a/policycoreutils/semodule/semodule.c
> > +++ b/policycoreutils/semodule/semodule.c
> > @@ -58,6 +58,7 @@ static int create_store;
> >  static int build;
> >  static int disable_dontaudit;
> >  static uint16_t priority;
> > +static char *message = NULL;
> >
> >  static semanage_handle_t *sh = NULL;
> >  static char *store;
> > @@ -72,6 +73,8 @@ static void cleanup(void)
> >  		free(commands[num_commands].output);
> >  	}
> >  	free(commands);
> > +
> > +	free(message);
> >  }
> >
> >  /* Signal handlers. */
> > @@ -134,6 +137,7 @@ static void usage(char *progname)
> >  	printf("  -h,--help        print this message and quit\n");
> >  	printf("  -v,--verbose     be verbose\n");
> >  	printf("  -D,--disable_dontaudit	Remove dontaudits from
> policy\n");
> > +	printf("  -m,--message=MSG user message for the ChangeLog\n");
> >  }
> >
> >  /* Sets the global mode variable to new_mode, but only if no other
> > @@ -186,6 +190,7 @@ static void parse_command_line(int argc, char
> **argv)
> >  		{"output", required_argument, NULL, 'o'},
> >  		{"cil", 0, NULL, 'c'},
> >  		{"edit", required_argument, NULL, 'E'},
> > +		{"message", required_argument, NULL, 'm'},
> >  		{NULL, 0, NULL, 0}
> >  	};
> >  	int i;
> > @@ -195,7 +200,7 @@ static void parse_command_line(int argc, char
> **argv)
> >  	create_store = 0;
> >  	priority = 400;
> >  	while ((i =
> > -		getopt_long(argc, argv,
"s:b:hi:l::vqr:u:RnBDp:e:d:g:o:cE:",
> opts,
> > +		getopt_long(argc, argv,
"s:b:hi:l::vqr:u:RnBDp:e:d:g:o:cE:m:",
> opts,
> >  			    NULL)) != -1) {
> >  		switch (i) {
> >  		case 'b':
> > @@ -294,6 +299,13 @@ static void parse_command_line(int argc, char
> **argv)
> >  		case 'E':
> >  			set_mode(EDIT_M, optarg);
> >  			break;
> > +		case 'm':
> > +			message = strdup(optarg);
> > +			if (message == NULL) {
> > +				fprintf(stderr, "Failed to set message
(out of
> memory).");
> > +				exit(1);
> > +			}
> > +			break;
> >  		case '?':
> >  		default:{
> >  				usage(argv[0]);
> > @@ -414,6 +426,16 @@ int main(int argc, char *argv[])
> >  		goto cleanup;
> >  	}
> >
> > +	if (message) {
> > +		result = semanage_set_log_message(sh, message);
> > +		if (result != 0) {
> > +			fprintf(stderr,
> > +				"%s: Failed to set ChangeLog message.",
> > +				argv[0]);
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> >  	for (i = 0; i < num_commands; i++) {
> >  		enum client_modes mode = commands[i].mode;
> >  		char *mode_arg = commands[i].arg;
> 
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
