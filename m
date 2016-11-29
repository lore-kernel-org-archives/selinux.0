Subject: Re: [PATCH] policycoreutils/sepolicy/gui: fix current selinux state
 radiobutton
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1480410540-5192-1-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c878032-bddc-2a83-2eec-818a6769a8ad@tycho.nsa.gov>
Date: Tue, 29 Nov 2016 09:02:38 -0500
MIME-Version: 1.0
In-Reply-To: <1480410540-5192-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/29/2016 04:09 AM, Vit Mojzis wrote:
> Radiobutton was always set to "Permissive" and couldn't be switched.
> Update radiobutton together with status text in bottom left corner.
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.  However, sepolicy gui doesn't work for me (before or
after this change):
$ cd selinux
$ sudo make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
$ sepolicy gui
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 699, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 327, in gui_run
    sepolicy.gui.SELinuxGui(args.domain, args.test)
  File "/usr/lib/python2.7/site-packages/sepolicy/gui.py", line 135, in
__init__
    builder.add_from_file(glade_file)
GLib.Error: g-file-error-quark: Failed to open file
'/usr/lib64/python2.7/site-packages/sepolicy/sepolicy.glade': No such
file or directory (4)

Are we failing to install the glade file properly in the Makefiles?
And does python/sepolicy/sepolicy/sepolicy.glade belong under gui/ instead?

> ---
>  python/sepolicy/sepolicy/gui.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index ee78e0c..3c5a9d2 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -2609,9 +2609,10 @@ class SELinuxGui():
>      def set_enforce_text(self, value):
>          if value:
>              self.status_bar.push(self.context_id, _("System Status: Enforcing"))
> +            self.current_status_enforcing.set_active(True)
>          else:
>              self.status_bar.push(self.context_id, _("System Status: Permissive"))
> -        self.current_status_permissive.set_active(True)
> +            self.current_status_permissive.set_active(True)
>  
>      def set_enforce(self, button):
>          self.dbus.setenforce(button.get_active())
> 
