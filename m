Subject: Re: [PATCH] python: Fix some typos
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1480961028-26715-1-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c7452eba-1b83-5669-817f-0c1bb64dee5b@tycho.nsa.gov>
Date: Mon, 5 Dec 2016 15:12:21 -0500
MIME-Version: 1.0
In-Reply-To: <1480961028-26715-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/05/2016 01:03 PM, Vit Mojzis wrote:
> Aside from typos, change the way markup is applied to a tooltip
> in sepolicy/gui so that the text can be translated.
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.

> ---
>  python/semanage/seobject.py             |  6 +++---
>  python/sepolicy/sepolicy/gui.py         | 12 ++++++------
>  python/sepolicy/sepolicy/sepolicy.glade |  6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 5f5fdec..c836cc5 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -386,7 +386,7 @@ class moduleRecords(semanageRecords):
>  
>      def add(self, file, priority):
>          if not os.path.exists(file):
> -            raise ValueError(_("Module does not exists %s ") % file)
> +            raise ValueError(_("Module does not exist: %s ") % file)
>  
>          rc = semanage_set_default_priority(self.sh, priority)
>          if rc < 0:
> @@ -492,7 +492,7 @@ class permissiveRecords(semanageRecords):
>          try:
>              import sepolgen.module as module
>          except ImportError:
> -            raise ValueError(_("The sepolgen python module is required to setup permissive domains.\nIn some distributions it is included in the policycoreutils-devel patckage.\n# yum install policycoreutils-devel\nOr similar for your distro."))
> +            raise ValueError(_("The sepolgen python module is required to setup permissive domains.\nIn some distributions it is included in the policycoreutils-devel package.\n# yum install policycoreutils-devel\nOr similar for your distro."))
>  
>          name = "permissive_%s" % type
>          modtxt = "(typepermissive %s)" % type
> @@ -1823,7 +1823,7 @@ class fcontextRecords(semanageRecords):
>      def modify_equal(self, target, substitute):
>          self.begin()
>          if target not in self.equiv.keys():
> -            raise ValueError(_("Equivalence class for %s does not exists") % target)
> +            raise ValueError(_("Equivalence class for %s does not exist") % target)
>          self.equiv[target] = substitute
>          self.equal_ind = True
>  
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 814ad9a..518fd01 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -1068,9 +1068,9 @@ class SELinuxGui():
>          self.transitions_into_tab.set_label(_("Application Transitions Into '%s'" % app))
>          self.transitions_from_tab.set_label(_("Application Transitions From '%s'" % app))
>          self.transitions_file_tab.set_label(_("File Transitions From '%s'" % app))
> -        self.transitions_into_tab.set_tooltip_text(_("Executables which will transition to the '%s', when executing a selected domains entrypoint.") % app)
> -        self.transitions_from_tab.set_tooltip_text(_("Executables which will transition to a different domain, when the '%s' executes them.") % app)
> -        self.transitions_file_tab.set_tooltip_text(_("Files by '%s' will transitions to a different label." % app))
> +        self.transitions_into_tab.set_tooltip_text(_("Executables which will transition to '%s', when executing selected domains entrypoint.") % app)
> +        self.transitions_from_tab.set_tooltip_text(_("Executables which will transition to a different domain, when '%s' executes them.") % app)
> +        self.transitions_file_tab.set_tooltip_text(_("Files by '%s' with transitions to a different label." % app))
>          self.transitions_radio_button.set_tooltip_text(_("Display applications that can transition into or out of the '%s'." % app))
>  
>          self.application = app
> @@ -1292,11 +1292,11 @@ class SELinuxGui():
>              niter = self.transitions_from_treestore.append(iter)
>              # active[0][1] is either T or F (enabled is all the way at the top)
>              self.transitions_from_treestore.set_value(iter, 0, enabled[active[0][1]])
> -            markup = '<span foreground="blue"><u>%s</u></span>'
> +            markup = ('<span foreground="blue"><u>','</u></span>')
>              if active[0][1]:
> -                self.transitions_from_treestore.set_value(niter, 2, (_("To disable this transition, go to the " + markup % _("Boolean section."))))
> +                self.transitions_from_treestore.set_value(niter, 2, (_("To disable this transition, go to the %sBoolean section%s.") % markup))
>              else:
> -                self.transitions_from_treestore.set_value(niter, 2, (_("To enable this transition, go to the " + markup % _("Boolean section."))))
> +                self.transitions_from_treestore.set_value(niter, 2, (_("To enable this transition, go to the %sBoolean section%s.") % markup))
>  
>              # active[0][0] is the Bool Name
>              self.transitions_from_treestore.set_value(niter, 1, active[0][0])
> diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
> index 1275c7f..00905e0 100644
> --- a/python/sepolicy/sepolicy/sepolicy.glade
> +++ b/python/sepolicy/sepolicy/sepolicy.glade
> @@ -3909,7 +3909,7 @@ allow alternative access control.</property>
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">True</property>
>                                          <property name="receives_default">False</property>
> -                                        <property name="tooltip_text" translatable="yes">An permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
> +                                        <property name="tooltip_text" translatable="yes">A permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
>                                          <property name="xalign">0</property>
>                                          <property name="draw_indicator">True</property>
>                                          <property name="group">enable_permissive</property>
> @@ -3926,7 +3926,7 @@ allow alternative access control.</property>
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">True</property>
>                                          <property name="receives_default">False</property>
> -                                        <property name="tooltip_text" translatable="yes">An permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
> +                                        <property name="tooltip_text" translatable="yes">A permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
>                                          <property name="xalign">0</property>
>                                          <property name="active">True</property>
>                                          <property name="draw_indicator">True</property>
> @@ -3989,7 +3989,7 @@ allow alternative access control.</property>
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">True</property>
>                                          <property name="receives_default">False</property>
> -                                        <property name="tooltip_text" translatable="yes">An permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
> +                                        <property name="tooltip_text" translatable="yes">A permissive domain is a process label that allows the process to do what it wants, with SELinux only logging the denials, but not enforcing them.  Usually permissive domains indicate experimental policy, disabling the module could cause SELinux to deny access to a domain, that should be allowed.</property>
>                                          <property name="xalign">0</property>
>                                          <property name="active">True</property>
>                                          <property name="draw_indicator">True</property>
> 
