Subject: Re: [PATCH] allow semodule -i to accept list of modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <45A3C035.5020203@tresys.com>
References: <1168292627.14203.2.camel@localhost.localdomain>
	 <45A3C035.5020203@tresys.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 09 Jan 2007 15:17:54 -0500
Message-Id: <1168373874.7993.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 11:17 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > The following patch allows semodule to handle a list of modules for
> > installation (i.e., semodule -i *.pp now works).
> >
> > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> >
> >   
> Acked-By: Joshua Brindle <jbrindle@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

This means we can also update the semodule man page to remove the gross
hack we came up with to workaround the absence of such support,
       # Replace all modules with the ones in the current directory
       $ semodule -b base.pp ‘semodule -l | awk ’{print "-i " $1
".pp"}’‘


> > diff -r e37f9d8d6611 policycoreutils/semodule/semodule.c
> > --- a/policycoreutils/semodule/semodule.c	Mon Jan 08 15:00:14 2007 -0500
> > +++ b/policycoreutils/semodule/semodule.c	Mon Jan 08 16:37:23 2007 -0500
> > @@ -225,15 +225,6 @@ static void parse_command_line(int argc,
> >  			}
> >  		}
> >  	}
> > -	if (optind < argc) {
> > -		fprintf(stderr, "Extraneous arguments:  ");
> > -		while (optind < argc)
> > -			fprintf(stderr, "%s", argv[optind++]);
> > -		fprintf(stderr, "\n");
> > -		usage(argv[0]);
> > -		cleanup();
> > -		exit(1);
> > -	}
> >  	if ((build || reload) && num_commands) {
> >  		fprintf(stderr,
> >  			"build or reload should not be used with other commands\n");
> > @@ -244,6 +235,24 @@ static void parse_command_line(int argc,
> >  		fprintf(stderr, "At least one mode must be specified.\n");
> >  		usage(argv[0]);
> >  		exit(1);
> > +	}
> > +
> > +	if (optind < argc) {
> > +		/* if -i was the last command treat any remaining
> > +		 * arguments as modules to allow 'semodule -i *.pp' to
> > +		 * work as expected.
> > +		 */
> > +		if (commands[num_commands - 1].mode == INSTALL_M) {
> > +			while (optind < argc)
> > +				set_mode(INSTALL_M, argv[optind++]);
> > +		} else {
> > +			fprintf(stderr, "unknown additional arguments:\n");
> > +			while (optind < argc)
> > +				fprintf(stderr, " %s", argv[optind++]);
> > +			fprintf(stderr, "\n\n");
> > +			usage(argv[0]);
> > +			exit(1);
> > +		}
> >  	}
> >  }
> >  
> >
> >
> >

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
