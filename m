Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8JC9dx0008916
 for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2016 08:09:39 -0400
Date: Mon, 19 Sep 2016 14:09:32 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] sandbox: Use GObject introspection binding instead of
 pygtk2
Message-ID: <20160919120929.yqqoxjte5bi76sxn@rhel-at-redhat.localdomain>
References: <20160918154609.8168-1-bigon@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160918154609.8168-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Sep 18, 2016 at 05:46:09PM +0200, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> sandbox command is also now using GTK 3.0
> 
> This patch comes from Fedora patch set

Works for me on Fedora with python 3 and on latest RHEL-7 with python 2 as well.

Note: the original patchset is based on suggestions from
https://wiki.gnome.org/action/show/Projects/PyGObject/IntrospectionPorting#Porting_from_PyGTK_2_to_PyGI_GTK_3

and created by the referenced script
http://git.gnome.org/browse/pygobject/tree/pygi-convert.sh


Petr


> ---
>  policycoreutils/sandbox/sandbox | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index 9f200d5..726ba9b 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -111,16 +111,18 @@ def copyfile(file, srcdir, dest):
>  def savefile(new, orig, X_ind):
>      copy = False
>      if(X_ind):
> -        import gtk
> -        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
> -                                gtk.BUTTONS_YES_NO,
> +        import gi
> +        gi.require_version('Gtk', '3.0')
> +        from gi.repository import Gtk
> +        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
> +                                Gtk.ButtonsType.YES_NO,
>                                  _("Do you want to save changes to '%s' (Y/N): ") % orig)
>          dlg.set_title(_("Sandbox Message"))
> -        dlg.set_position(gtk.WIN_POS_MOUSE)
> +        dlg.set_position(Gtk.WindowPosition.MOUSE)
>          dlg.show_all()
>          rc = dlg.run()
>          dlg.destroy()
> -        if rc == gtk.RESPONSE_YES:
> +        if rc == Gtk.ResponseType.YES:
>              copy = True
>      else:
>          try:
> @@ -452,8 +454,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>                      if self.__options.dpi:
>                          dpi = self.__options.dpi
>                      else:
> -                        import gtk
> -                        dpi = str(gtk.settings_get_default().props.gtk_xft_dpi / 1024)
> +                        import gi
> +                        gi.require_version('Gtk', '3.0')
> +                        from gi.repository import Gtk
> +                        dpi = str(Gtk.Settings.get_default().props.gtk_xft_dpi / 1024)
>  
>                      xmodmapfile = self.__homedir + "/.xmodmap"
>                      xd = open(xmodmapfile, "w")
> -- 
> 2.9.3
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
Petr Lautrbach
