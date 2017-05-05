Message-ID: <1494003975.5745.10.camel@tycho.nsa.gov>
Subject: Re: [PATCH 19/19] sepolicy/gui: Update text strings to use better
 gettext templates
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 13:06:15 -0400
In-Reply-To: <20170503103036.17514-20-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
 <20170503103036.17514-20-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-03 at 12:30 +0200, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied all 19 patches.

> ---
>  python/sepolicy/sepolicy/gui.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/gui.py
> b/python/sepolicy/sepolicy/gui.py
> index 7f84b6f9..007c94a7 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -1378,8 +1378,8 @@ class SELinuxGui():
>                  self.treeview = self.network_in_treeview
>                  category = _("listen for inbound connections")
>  
> -            self.add_button.set_tooltip_text(_("Add new port
> definition to which the '%(APP)s' domain is allowed to %s.") %
> {"APP": self.application, "PERM": category})
> -            self.delete_button.set_tooltip_text(_("Delete modified
> port definitions to which the '%(APP)s' domain is allowed to %s.") %
> {"APP": self.application, "PERM": category})
> +            self.add_button.set_tooltip_text(_("Add new port
> definition to which the '%(APP)s' domain is allowed to %(PERM)s.") %
> {"APP": self.application, "PERM": category})
> +            self.delete_button.set_tooltip_text(_("Delete modified
> port definitions to which the '%(APP)s' domain is allowed to
> %(PERM)s.") % {"APP": self.application, "PERM": category})
>              self.modify_button.set_tooltip_text(_("Modify port
> definitions to which the '%(APP)s' domain is allowed to %(PERM)s.") %
> {"APP": self.application, "PERM": category})
>  
>          if self.transitions_radio_button.get_active():
> @@ -1599,8 +1599,8 @@ class SELinuxGui():
>              self.show_popup(self.login_popup_window)
>  
>          if self.opage == FILE_EQUIV_PAGE:
> -            self.file_equiv_source_entry.set_text(self.file_equiv_li
> ststore.get_value(iter, 0))
> -            self.file_equiv_dest_entry.set_text(self.file_equiv_list
> store.get_value(iter, 1))
> +            self.file_equiv_source_entry.set_text(self.unmarkup(self
> .file_equiv_liststore.get_value(iter, 0)))
> +            self.file_equiv_dest_entry.set_text(self.unmarkup(self.f
> ile_equiv_liststore.get_value(iter, 1)))
>              self.file_equiv_label.set_text((_("Modify File
> Equivalency Mapping. Mapping will be created when update is
> applied.")))
>              self.file_equiv_popup_window.set_title(_("Modify SELinux
> File Equivalency"))
>              self.clear_entry = True
