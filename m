Subject: Re: [PATCH] sandbox: Use GObject introspection binding instead of
 pygtk2
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20160918154609.8168-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6ef6230-c1c6-448e-2952-ac038a5a3fda@tycho.nsa.gov>
Date: Mon, 19 Sep 2016 10:58:10 -0400
MIME-Version: 1.0
In-Reply-To: <20160918154609.8168-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/18/2016 11:46 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> sandbox command is also now using GTK 3.0
> 
> This patch comes from Fedora patch set

Need a Signed-off-by.  If you can extract the actual original patch with
its author and signed-off-by, that's preferable.

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
> 
