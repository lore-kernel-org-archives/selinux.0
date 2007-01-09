MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] allow semodule -i to accept list of modules
Date: Tue, 9 Jan 2007 16:53:34 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015886CA5C6@exchange.columbia.tresys.com>
In-Reply-To: <1168375433.7993.157.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Tue, 2007-01-09 at 15:17 -0500, Stephen Smalley wrote:
> > On Tue, 2007-01-09 at 11:17 -0500, Joshua Brindle wrote:
> > > Karl MacMillan wrote:
> > > > The following patch allows semodule to handle a list of modules 
> > > > for installation (i.e., semodule -i *.pp now works).
> > > >
> > > > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > > >
> > > >   
> > > Acked-By: Joshua Brindle <jbrindle@tresys.com>
> > 
> > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > This means we can also update the semodule man page to remove the 
> > gross hack we came up with to workaround the absence of 
> such support,
> >        # Replace all modules with the ones in the current directory
> >        $ semodule -b base.pp 'semodule -l | awk '{print "-i " $1 
> > ".pp"}''
> 
> BTW, any reason we wouldn't support the same thing for -u or -r?
> 

-r wouldn't work well because it wants the name of the module (eg.,
apache) instead of the filename (apache.pp)

> > 
> > > > diff -r e37f9d8d6611 policycoreutils/semodule/semodule.c
> > > > --- a/policycoreutils/semodule/semodule.c	Mon Jan 
> 08 15:00:14 2007 -0500
> > > > +++ b/policycoreutils/semodule/semodule.c	Mon Jan 
> 08 16:37:23 2007 -0500
> > > > @@ -225,15 +225,6 @@ static void parse_command_line(int argc,
> > > >  			}
> > > >  		}
> > > >  	}
> > > > -	if (optind < argc) {
> > > > -		fprintf(stderr, "Extraneous arguments:  ");
> > > > -		while (optind < argc)
> > > > -			fprintf(stderr, "%s", argv[optind++]);
> > > > -		fprintf(stderr, "\n");
> > > > -		usage(argv[0]);
> > > > -		cleanup();
> > > > -		exit(1);
> > > > -	}
> > > >  	if ((build || reload) && num_commands) {
> > > >  		fprintf(stderr,
> > > >  			"build or reload should not be 
> used with other commands\n"); 
> > > > @@ -244,6 +235,24 @@ static void parse_command_line(int argc,
> > > >  		fprintf(stderr, "At least one mode must 
> be specified.\n");
> > > >  		usage(argv[0]);
> > > >  		exit(1);
> > > > +	}
> > > > +
> > > > +	if (optind < argc) {
> > > > +		/* if -i was the last command treat any 
> remaining
> > > > +		 * arguments as modules to allow 
> 'semodule -i *.pp' to
> > > > +		 * work as expected.
> > > > +		 */
> > > > +		if (commands[num_commands - 1].mode == 
> INSTALL_M) {
> > > > +			while (optind < argc)
> > > > +				set_mode(INSTALL_M, 
> argv[optind++]);
> > > > +		} else {
> > > > +			fprintf(stderr, "unknown 
> additional arguments:\n");
> > > > +			while (optind < argc)
> > > > +				fprintf(stderr, " %s", 
> argv[optind++]);
> > > > +			fprintf(stderr, "\n\n");
> > > > +			usage(argv[0]);
> > > > +			exit(1);
> > > > +		}
> > > >  	}
> > > >  }
> > > >  
> > > >
> > > >
> > > >
> > 
> --
> Stephen Smalley
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
