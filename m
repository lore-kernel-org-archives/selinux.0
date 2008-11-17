Subject: Re: [PATCH] semanage:  Use semanage_mls_enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <491DF8F6.70907@redhat.com>
References: <1226349176.8814.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1226501006.21407.9.camel@moss-spartans.epoch.ncsc.mil>
	 <491DF8F6.70907@redhat.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 08:54:34 -0500
Message-Id: <1226930074.25156.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-11-14 at 17:17 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > Change semanage/seobject to use semanage_mls_enabled() rather than
> > is_selinux_mls_enabled().  I dropped the mls enabled tests altogether
> > from the semanage front-end script since setting up a handle is done by
> > seobject.py; if those checks are actually important, we could move them
> > inside of the seobject methods, but I'm not clear on the real benefit of
> > those checks.  In seobject.py, I moved the setting of the is_mls_enabled
> > variable inside of get_handle(store) after the connect.  I also dropped
> > the is_mls_enabled test from setransRecords since no handle/connection
> > exists there (since translations are not managed via libsemanage), and
> > again I'm not clear that the check there was overly important/useful.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
> > index c34e594..eb0ac34 100644
> > --- a/policycoreutils/semanage/semanage
> > +++ b/policycoreutils/semanage/semanage
> > @@ -38,8 +38,6 @@ except IOError:
> >         import __builtin__
> >         __builtin__.__dict__['_'] = unicode
> >  
> > -is_mls_enabled=selinux.is_selinux_mls_enabled()
> > -
> >  if __name__ == '__main__':
> >  
> >  	def usage(message = ""):
> > @@ -270,16 +268,12 @@ Object-specific Options (see above):
> >  				store = a
> >  
> >  			if o == "-r" or o == '--range':
> > -				if is_mls_enabled == 0:
> > -                                       raise ValueError(_("range not supported on Non MLS machines"))
> >  				serange = a
> >  
> >  			if o == "-l" or o == "--list":
> >  				list = True
> >  
> >  			if o == "-L" or o == '--level':
> > -				if is_mls_enabled == 0:
> > -                                       raise ValueError(_("range not supported on Non MLS machines"))
> >  				selevel = a
> >  
> >  			if o == "-p" or o == '--proto':
> > diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> > index c5379ac..8bf188a 100644
> > --- a/policycoreutils/semanage/seobject.py
> > +++ b/policycoreutils/semanage/seobject.py
> > @@ -35,14 +35,13 @@ except IOError:
> >         import __builtin__
> >         __builtin__.__dict__['_'] = unicode
> >  
> > -is_mls_enabled = selinux.is_selinux_mls_enabled()
> > -
> >  import syslog
> >  
> >  handle = None
> >  
> >  def get_handle(store):
> >         global handle
> > +       global is_mls_enabled
> >  
> >         handle = semanage_handle_create()
> >         if not handle:
> > @@ -63,7 +62,13 @@ def get_handle(store):
> >         rc = semanage_connect(handle)
> >         if rc < 0:
> >                semanage_handle_destroy(handle)
> > -              raise ValueError(_("Could not establish semanage connection"))       
> > +              raise ValueError(_("Could not establish semanage connection"))
> > +
> > +       is_mls_enabled = semanage_mls_enabled(handle)
> > +       if is_mls_enabled < 0:
> > +              semanage_handle_destroy(handle)
> > +              raise ValueError(_("Could not test MLS enabled status"))
> > +
> >         return handle
> >  
> >  file_types = {}
> > @@ -192,8 +197,6 @@ def untranslate(trans, prepend = 1):
> >  	
> >  class setransRecords:
> >  	def __init__(self):
> > -		if not is_mls_enabled:
> > -			raise ValueError(_("translations not supported on non-MLS machines"))			
> >  		self.filename = selinux.selinux_translations_path()
> >  		try:
> >  			fd = open(self.filename, "r")
> > 
> Why did you remove all the checking from the patch?

As I explained in the patch description, I removed mls enabled checks
where no handle was available as I could not convert those calls to
using the new handle-based semanage_mls_enabled() interface.  This
included the checks in the semanage front-end script, and the check in
setransRecords as no handle was available in either location.  If those
checks are important (and it wasn't clear to me that they were doing
anything crucial, just providing some extra sanity checking against
accidental invocation of semanage with MLS-related options or commands
on a non-MLS host), then they need to be restored within the seobject
methods at a point where we have a handle, or in the case of setrans, we
need to get a handle for this purpose even though we aren't using it for
anything else.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
