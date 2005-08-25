Date: Thu, 25 Aug 2005 10:18:03 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: avoid NULL deref
Message-ID: <20050825151803.GA16541@sergelap.austin.ibm.com>
References: <20050824182822.GB7291@sergelap.austin.ibm.com> <1124982509.3873.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124982509.3873.74.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2005-08-24 at 13:28 -0500, serue@us.ibm.com wrote:
> > This patch fixes a bug found by Coverity in setsetbool.c.
> > 
> > After these two patches I sent today, the only bugs I'm finding are
> > 1 false positive in libsemanage, and 22 unchecked in libsepol.
> > 
> > thanks,
> > -serge
> > 
> > --- utils/setsebool.c.orig	2005-08-24 17:24:32.278258504 -0500
> > +++ utils/setsebool.c	2005-08-24 17:30:37.914673320 -0500
> > @@ -154,6 +154,13 @@ int setbool(char **list, size_t start, s
> >  		   this above and aborted if something went wrong. */
> >  		name = list[i];
> >  		value_ptr = strchr(name, '=');
> > +		if (!value_ptr) {
> > +			syslog(LOG_NOTICE,
> > +				"Malformed entry for boolean %s\n",
> > +				name);
> > +			i++;
> > +			continue;
> > +		}
> >  		*value_ptr = 0;
> >  		value_ptr++;
> >  		if (pwd && pwd->pw_name)
> 
> The immediately preceding comment says:
>        /* Error checking shouldn't be needed since we just did
>           this above and aborted if something went wrong. */
> And looking at the code flow, it would have bailed prior to reaching
> this code if the strchr had failed at all on the first pass, right?

Oh, that's right.  That's why I had ignored it in previous runs!

Please disregard...

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
