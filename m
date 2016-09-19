Date: Mon, 19 Sep 2016 18:12:04 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] sandbox: Use GObject introspection binding instead of
 pygtk2
Message-ID: <20160919161203.dh37imuq6ihde4ss@rhel-at-redhat.localdomain>
References: <20160918154609.8168-1-bigon@debian.org>
 <d6ef6230-c1c6-448e-2952-ac038a5a3fda@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6ef6230-c1c6-448e-2952-ac038a5a3fda@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 19, 2016 at 10:58:10AM -0400, Stephen Smalley wrote:
> On 09/18/2016 11:46 AM, Laurent Bigonville wrote:
> > From: Laurent Bigonville <bigon@bigon.be>
> > 
> > sandbox command is also now using GTK 3.0
> > 
> > This patch comes from Fedora patch set
> 
> Need a Signed-off-by.  If you can extract the actual original patch with
> its author and signed-off-by, that's preferable.

I'm the author of the original patches. However I consider the new patch
better and we'll adopt it in Fedora as soon as it's pushed upstream.

I'm completely fine with Laurent resend this patch again with his
Signed-Off-By


Petr

> 
> > ---
> >  policycoreutils/sandbox/sandbox | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> > index 9f200d5..726ba9b 100644
> > --- a/policycoreutils/sandbox/sandbox
> > +++ b/policycoreutils/sandbox/sandbox
> > @@ -111,16 +111,18 @@ def copyfile(file, srcdir, dest):
> >  def savefile(new, orig, X_ind):
> >      copy = False
> >      if(X_ind):
> > -        import gtk
> > -        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
> > -                                gtk.BUTTONS_YES_NO,
> > +        import gi
> > +        gi.require_version('Gtk', '3.0')
> > +        from gi.repository import Gtk
> > +        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
> > +                                Gtk.ButtonsType.YES_NO,
> >                                  _("Do you want to save changes to '%s' (Y/N): ") % orig)
> >          dlg.set_title(_("Sandbox Message"))
> > -        dlg.set_position(gtk.WIN_POS_MOUSE)
> > +        dlg.set_position(Gtk.WindowPosition.MOUSE)
> >          dlg.show_all()
> >          rc = dlg.run()
> >          dlg.destroy()
> > -        if rc == gtk.RESPONSE_YES:
> > +        if rc == Gtk.ResponseType.YES:
> >              copy = True
> >      else:
> >          try:
> > @@ -452,8 +454,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
> >                      if self.__options.dpi:
> >                          dpi = self.__options.dpi
> >                      else:
> > -                        import gtk
> > -                        dpi = str(gtk.settings_get_default().props.gtk_xft_dpi / 1024)
> > +                        import gi
> > +                        gi.require_version('Gtk', '3.0')
> > +                        from gi.repository import Gtk
> > +                        dpi = str(Gtk.Settings.get_default().props.gtk_xft_dpi / 1024)
> >  
> >                      xmodmapfile = self.__homedir + "/.xmodmap"
> >                      xd = open(xmodmapfile, "w")
> > 
> 

-- 
Petr Lautrbach
