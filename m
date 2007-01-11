Subject: Re: [PATCH] allow semodule -i to accept list of modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1168436803.7993.183.camel@moss-spartans.epoch.ncsc.mil>
References: <1168292627.14203.2.camel@localhost.localdomain>
	 <45A3C035.5020203@tresys.com>
	 <1168373874.7993.152.camel@moss-spartans.epoch.ncsc.mil>
	 <1168375433.7993.157.camel@moss-spartans.epoch.ncsc.mil>
	 <1168379560.4983.19.camel@localhost.localdomain>
	 <1168436803.7993.183.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8
Date: Thu, 11 Jan 2007 12:36:45 -0500
Message-Id: <1168537005.7993.378.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-10 at 08:46 -0500, Stephen Smalley wrote:
> On Tue, 2007-01-09 at 16:52 -0500, Karl MacMillan wrote:
> > On Tue, 2007-01-09 at 15:43 -0500, Stephen Smalley wrote:
> > > On Tue, 2007-01-09 at 15:17 -0500, Stephen Smalley wrote:
> > > > On Tue, 2007-01-09 at 11:17 -0500, Joshua Brindle wrote:
> > > > > Karl MacMillan wrote:
> > > > > > The following patch allows semodule to handle a list of modules for
> > > > > > installation (i.e., semodule -i *.pp now works).
> > > > > >
> > > > > > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > > > > >
> > > > > >   
> > > > > Acked-By: Joshua Brindle <jbrindle@tresys.com>
> > > > 
> > > > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > > > 
> > > > This means we can also update the semodule man page to remove the gross
> > > > hack we came up with to workaround the absence of such support,
> > > >        # Replace all modules with the ones in the current directory
> > > >        $ semodule -b base.pp ‘semodule -l | awk ’{print "-i " $1
> > > > ".pp"}’‘
> > > 
> > > BTW, any reason we wouldn't support the same thing for -u or -r?
> > > 
> > 
> > Patch below. It is less useful for -r, but still potentially easier. As
> > for the man page, that is updated but the command for updating
> > from /usr/share/selinux/policyname still sucks. I came up with:
> > 
> > ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule
> > -i
> 
> That has a different effect.  The original command replaces the base
> module and any already installed module (semodule -l output) with ones
> from the current directory as a single transaction without installing
> any new modules, while your command would replace any non-base modules
> and install any new ones, without updating the base module (which could
> very well fail due to dependencies on the base).  Both actually seem
> wrong to me - we do want to install all of the non-base modules from the
> directory as per your command but we need to include the base in the
> same transaction.
> 
> > Gets rid of awk (so it is potentially easier for many), but it is
> > longer. At some point someone should make semodule just do the right
> > thing for a mixed list of modules and base modules. Of course, even that
> > wouldn't work for the /usr/share/selinux directories because of
> > enableaudit, so I give up.
> > 
> > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> > 
> > diff -r a70fbd24a437 policycoreutils/semodule/semodule.8
> > --- a/policycoreutils/semodule/semodule.8	Tue Jan 09 16:21:10 2007 -0500
> > +++ b/policycoreutils/semodule/semodule.8	Tue Jan 09 16:46:35 2007 -0500
> > @@ -59,7 +59,10 @@ be verbose
> >  # List non-base modules.
> >  $ semodule -l
> >  # Replace all modules with the ones in the current directory
> > -$ semodule -b base.pp `semodule -l | awk '{print "-i " $1 ".pp"}'`
> > +$ semodule -i *.pp
> > +# Replace all modules with the ones in the current directory
> > +# excluding base.pp and enableaudit.pp
> > +$ ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -i
> >  .fi
> >  
> >  .SH SEE ALSO
> > diff -r a70fbd24a437 policycoreutils/semodule/semodule.c
> > --- a/policycoreutils/semodule/semodule.c	Tue Jan 09 16:21:10 2007 -0500
> > +++ b/policycoreutils/semodule/semodule.c	Tue Jan 09 16:46:35 2007 -0500
> > @@ -238,13 +238,17 @@ static void parse_command_line(int argc,
> >  	}
> >  
> >  	if (optind < argc) {
> > -		/* if -i was the last command treat any remaining
> > -		 * arguments as modules to allow 'semodule -i *.pp' to
> > +		int mode;
> > +		/* if -i/u/r was the last command treat any remaining
> > +		 * arguments as args. Will allow 'semodule -i *.pp' to
> >  		 * work as expected.
> >  		 */
> >  		if (commands[num_commands - 1].mode == INSTALL_M) {
> > -			while (optind < argc)
> > -				set_mode(INSTALL_M, argv[optind++]);
> > +			mode = INSTALL_M;
> > +		} else if (commands[num_commands - 1].mode == UPGRADE_M) {
> > +			mode = UPGRADE_M;
> > +		} else if (commands[num_commands - 1].mode == REMOVE_M) {
> > +			mode = REMOVE_M;
> >  		} else {
> >  			fprintf(stderr, "unknown additional arguments:\n");
> >  			while (optind < argc)
> > @@ -253,6 +257,8 @@ static void parse_command_line(int argc,
> >  			usage(argv[0]);
> >  			exit(1);
> >  		}
> > +		while (optind < argc)
> > +			set_mode(mode, argv[optind++]);
> >  	}
> >  }
> >  

Merged with some changes to the man page in policycoreutils 1.33.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
