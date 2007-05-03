Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
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
Content-Type: text/plain
Date: Thu, 03 May 2007 09:40:53 -0400
Message-Id: <1178199653.3443.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 08:11 -0500, Xavier Toth wrote:
> On 5/2/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2007-05-02 at 10:49 -0500, Xavier Toth wrote:
> > +#include <sepol/policydb/hashtab.h>
> >
> > We don't want newrole to link with the static libsepol, so if you want
> > to use the libsepol hashtab (and symtab) support, copy it into the
> > newrole directory.
> >
> 
> I'd prefer it if this was in a shared library.

It isn't adequately encapsulated for that.

> > Breaks the "abstraction".  Normally this would be done as a
> > hashtab_map() to free the keys and datum followed by a hashtab_destroy()
> > to free the table.  Or if you want a unified form, you could do
> > something like hashtab_map_remove_on_error() except always doing the
> > removal, but put it in your copy of the hashtab code.
> >
> 
> Hmmm, I pretty much copied this code from semodule_deps.c

...which does require static libsepol and is a developer tool rather
than a production system tool.

> > +         char *cmd = (char *)malloc(strlen(argv[optind+1]));
> >
> > argv[optind+1] or argv[optind]?  And you'd need to add 1 to the length (not optind) for terminating NUL.
> >
> > +         sscanf(argv[optind+1], "%s", cmd);
> >
> > Pointless, argument vector has already been parsed by the shell.
> > Just use argv[optind] directly, no copy required.
> >
> 
> Using 'newrole -l s2-s2 -- -c "/usr/bin/gnome-terminal --disable-factory"'
> agrv[optind] is '-c'
> argv[optind+1] is '/usr/bin/gnome-terminal --disable-factory'

I see, although you aren't explicitly checking that a "-c" was
specified, so it seems prone to error.   That form of usage seems
unpleasant, but it is consistent with su.  Might be nice if newrole
would just directly invoke the command if specified, but that could
cause problems with domain transitions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
