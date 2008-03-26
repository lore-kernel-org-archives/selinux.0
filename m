Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2QGIKgo018462
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 12:18:20 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2QGIC15019741
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 16:18:13 GMT
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and
	fifos
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080321073158.GA12456@bobek.pm.i.cz>
References: <200803062346.58639.russell@coker.com.au>
	 <20080305152322.GA9988@bobek.pm.i.cz>
	 <1204734268.12784.124.camel@hepcat.vitavonni.de>
	 <200803062117.20441.russell@coker.com.au>
	 <1204805640.5885.4.camel@hepcat.vitavonni.de>
	 <20080305152322.GA9988@bobek.pm.i.cz>
	 <1204734268.12784.124.camel@hepcat.vitavonni.de>
	 <200803062117.20441.russell@coker.com.au>
	 <20080305152322.GA9988@bobek.pm.i.cz>
	 <1204734268.12784.124.camel@hepcat.vitavonni.de>
	 <20080321073158.GA12456@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 26 Mar 2008 11:57:09 -0400
Message-Id: <1206547029.16113.272.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-21 at 08:31 +0100, Václav Ovsík wrote:
> Hi,
> sorry for a delay. Beforehand thanks for all worth reactions. I'm very
> thankful for these.
> 
> BTW: I found, that dpkg passes (and should not) to child processes
> a file descriptor of apt pipe:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=471488
> The access to apts fifo should not be needed for dpkg scripts.

> On Thu, Mar 06, 2008 at 11:46:54PM +1100, Russell Coker wrote:
> > On Thursday 06 March 2008 23:13, Erich Schubert <erich@debian.org> wrote:
> > > > > It would definitely help to have separate apt_t and apt_script_t
> > > > > domains, though, to be able to differentiate access for installation
> > > > > scripts and the package manager itself.
> > > >
> > > > What meaningful restrictions can be applied to one but not the other?
> > >
> > > I agree with you that we would currently have to allow pretty much any
> > > access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
> > > again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
> > > obviously.
> > > No, I can't really think of ways to restrict dpkg_script_t apart from
> > > not messing with the dpkg_t state files. Maybe we could make some policy
> > 
> > But given that dpkg_script_t can make all manner of other changes (including 
> > loading a SE Linux policy) it seems rather minor to restrict access to dpkg 
> > state files.
> > 
> > > that /usr is to be modified by dpkg_t only whereas dynamically generated
> > > files have to reside in /var, but I doubt this would currently hold.
> > 
> > It's a standard practice to convert the data files under /var in an upgrade.
> > 
> > > And after all, dpkg_script_t needs to be able to even add users
> > > to /etc/passwd (although through the helper applications, not directly).
> > 
> > Yes.
> > 
> > In fact while we have unconfined_t, the benefit of having a separate dpkg_t 
> > instead of using unconfined_t for installing packages doesn't seem 
> > significant.

> Seems to me dpkg_script_t is not used now really.  Should be removed
> dpkg_script_t from the refpolicy?  A part of rules should be moved from
> the domain dpkg_script_t to the domain dpkg_t probably if such a removal
> will take place.

As I recall it was a work in progress by either Erich or Manoj.  If it
was never finished or abandoned, then it should probably be removed.


> On Mon, Mar 10, 2008 at 01:39:49PM -0400, Christopher J. PeBenito wrote:
> > On Fri, 2008-03-07 at 22:23 +0100, Stefan Schulze Frielinghaus wrote:
> > > On Wed, 2008-03-05 at 16:23 +0100, Václav Ovsík wrote:
> > > > Hi,
> > > > running Debian Sid with HEAD refpolicy...
> > > > I tried to install bind9 and got some further denials for access to pty
> > > > and pipe of apt_t domain. This is a continuation of the patch from
> > > > Martin Orr in thread "refpolicy: patch for ldconfig from glibc 2.7...",
> > > > witch was about apt finally.
> > > > 
> > > > ...
> > > > 
> > > > Attached patch solves the most of this denials, but I doubt this is the
> > > > right way.  Should be used some attribute for this?  I noticed attribute
> > > > privfd and macro domain_interactive_fd(), what about it?  Rpm already
> > > > has such macro calls
> > > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_t)
> > > > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_script_t)
> > > > 
> > > > I tried to use this macro for apt_t, and all use fd denials above are
> > > > solved with it. Should be things done in this way?
> > > > 
> > > > Thanks for comments.
> > > 
> > > I think it is not really nice to have all these allow rules directly in
> > > the modules. A similar discussion can be found here:
> > > http://marc.info/?l=selinux&m=118707242005853&w=2
> > > 
> > > Especially the first replay of Stephen Smalley pointing out how rpm
> > > solves this via domain.if: rpm_use_fds($1) and rpm_read_pipes($1)
> > > 
> > > If I had to choose between the several fixes for every module or the
> > > "rpm-way" to allow all usage of file descriptors and read permissions
> > > then I would vote for the latter.
> > 
> > A better option might be to mimic the inheritance of fds and pipes.
> 
> I'm not certain I understood this correctly.  I understood `to mimic the
> inheritance', that for all domains runnable from dpkg scripts should be
> inserted appropriate rules for access explicitly.  If I'm wrong, please
> explain it a bit further.  Sorry for my English.

No thats not what I mean.  If you do that, then it means each module has
to know about domains that indirectly execute it.  My suggestion is if
you have a chain of execs like this:

user -> foo -> bar -> yar

then you would want yar to inherit and use user's fds so that it can
write out to the user's terminal.  So it seems best to structure the
policy so that at each run interface call you put in your own fd and
pipes and also the pipes and fds that you've inherited.  So that results
in:

foo inherits user fds/pipes
bar inherits user and foo fds/pipes
yar inherits user, bar, and foo pipes

I managed to partially do this with roles and terminals, in run
interfaces.  My initial idea is for each domain to keep an attribute of
fds and redirections that it inherits.  Unfortunately this turns run
interfaces ugly due to fds possibly opened to a file, pipe, or terminal
(I suppose there could be other redirections but these are by far the
common ones).  For example (in pseudo-policy)

interface foo_run
	foo_domtrans($domain)
	roleattribute foo_inherited_roles $role;
	typeattribute foo_inherited_fds $inherit_fds;
	typeattribute foo_inherited_terms $inherit_terms;
	typeattribute foo_inherited_pipes $inherit_pipes;

Then in foo.te we have

role foo_inherited_roles types foo_t;
allow foo_t foo_inh_fds:fd use;
allow foo_t foo_inh_files:file rw_file_perms;
allow foo_t foo_inh_terms:chr_file rw_chr_file_perms;
allow foo_t foo_inh_pipes:fifo_file rw_fifo_file_perms;

bar_run(foo_t,
	foo_inh_roles,
	{ foo_t foo_inh_fds },
	{ foo_t foo_inh_pipes },
	foo_inh_files,
	foo_inh_terms
	)

if foo opens up a pty for its call to bar then we could break most of
the inheritance

bar_run(foo_t,foo_inh_roles,foo_t,,,foo_pty_t)

The problem is that not all of the constructs I used in my example are
available in the current language, and optional parameters on interfaces
are not currently allowed.

Its not so pretty, but thats my idea.  I'm certainly open to suggestions
for something better.  In the mean time I suppose we just have to
continue adding rules to the individual modules.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
