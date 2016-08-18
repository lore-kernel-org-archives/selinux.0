Subject: Re: [PATCH 08/12] policycoreutils: import sepolicy directly
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
 <1470335645-24224-9-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <eba4ee4d-2769-0e1b-4c92-f37a183690da@tycho.nsa.gov>
Date: Thu, 18 Aug 2016 12:21:56 -0400
MIME-Version: 1.0
In-Reply-To: <1470335645-24224-9-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/04/2016 02:34 PM, Jason Zaman wrote:
> instead of from sepolicy import foo. Makes it easier to grep for
> consumers that still need to be fixed.

I think this broke audit2why.

$ cd policycoreutils/audit2allow
$ make test
test_audit2why (__main__.Audit2allowTests)
Verify audit2why works ... Traceback (most recent call last):
  File "/bin/audit2why", line 365, in <module>
    app.main()
  File "/bin/audit2why", line 353, in main
    self.__output()
  File "/bin/audit2why", line 295, in __output
    return self.__output_audit2why()
  File "/bin/audit2why", line 263, in __output_audit2why
    print("\tDescription:\n\t%s\n" % seobject.boolean_desc(b[0]))
AttributeError: 'module' object has no attribute 'boolean_desc'
FAIL


> ---
>  policycoreutils/gui/domainsPage.py   |  4 +--
>  policycoreutils/gui/polgengui.py     | 58 ++++++++++++++++++------------------
>  policycoreutils/semanage/seobject.py |  7 ++---
>  3 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/policycoreutils/gui/domainsPage.py b/policycoreutils/gui/domainsPage.py
> index 56c66fe..9992d00 100644
> --- a/policycoreutils/gui/domainsPage.py
> +++ b/policycoreutils/gui/domainsPage.py
> @@ -25,8 +25,8 @@ import gobject
>  import sys
>  import seobject
>  import selinux
> +import sepolicy
>  from semanagePage import *
> -from sepolicy import get_all_entrypoint_domains
>  
>  ##
>  ## I18N
> @@ -70,7 +70,7 @@ class domainsPage(semanagePage):
>          self.permissive_button = xml.get_widget("permissiveButton")
>          self.enforcing_button = xml.get_widget("enforcingButton")
>  
> -        self.domains = get_all_entrypoint_domains()
> +        self.domains = sepolicy.get_all_entrypoint_domains()
>          self.load()
>  
>      def get_modules(self):
> diff --git a/policycoreutils/gui/polgengui.py b/policycoreutils/gui/polgengui.py
> index 0a153c6..1c349a7 100644
> --- a/policycoreutils/gui/polgengui.py
> +++ b/policycoreutils/gui/polgengui.py
> @@ -29,7 +29,7 @@ import gobject
>  import gnome
>  import sys
>  try:
> -    from sepolicy import generate
> +    import sepolicy
>  except ValueError, e:
>      sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
>      sys.exit(1)
> @@ -194,10 +194,10 @@ class childWindow:
>          self.tooltip_dict[label] = label.get_tooltip_text()
>  
>          try:
> -            self.all_types = generate.get_all_types()
> +            self.all_types = sepolicy.generate.get_all_types()
>              self.all_modules = get_all_modules()
> -            self.all_roles = generate.get_all_roles()
> -            self.all_users = generate.get_all_users()
> +            self.all_roles = sepolicy.generate.get_all_roles()
> +            self.all_users = sepolicy.generate.get_all_users()
>          except RuntimeError, e:
>              self.all_types = []
>              self.all_modules = []
> @@ -225,16 +225,16 @@ class childWindow:
>          self.boolean_description_entry = xml.get_widget("boolean_description_entry")
>  
>          self.pages = {}
> -        for i in generate.USERS:
> +        for i in sepolicy.generate.USERS:
>              self.pages[i] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.TRANSITION_PAGE, self.ROLE_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> -        self.pages[generate.RUSER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.ADMIN_PAGE, self.USER_TRANSITION_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> -        self.pages[generate.LUSER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.TRANSITION_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> -        self.pages[generate.SANDBOX] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> -        self.pages[generate.EUSER] = [self.SELECT_TYPE_PAGE, self.EXISTING_USER_PAGE, self.TRANSITION_PAGE, self.ROLE_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> +        self.pages[sepolicy.generate.RUSER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.ADMIN_PAGE, self.USER_TRANSITION_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> +        self.pages[sepolicy.generate.LUSER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.TRANSITION_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> +        self.pages[sepolicy.generate.SANDBOX] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> +        self.pages[sepolicy.generate.EUSER] = [self.SELECT_TYPE_PAGE, self.EXISTING_USER_PAGE, self.TRANSITION_PAGE, self.ROLE_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
>  
> -        for i in generate.APPLICATIONS:
> +        for i in sepolicy.generate.APPLICATIONS:
>              self.pages[i] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.COMMON_APPS_PAGE, self.FILES_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> -        self.pages[generate.USER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.USER_TRANSITION_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.COMMON_APPS_PAGE, self.FILES_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
> +        self.pages[sepolicy.generate.USER] = [self.SELECT_TYPE_PAGE, self.APP_PAGE, self.USER_TRANSITION_PAGE, self.IN_NET_PAGE, self.OUT_NET_PAGE, self.COMMON_APPS_PAGE, self.FILES_PAGE, self.BOOLEAN_PAGE, self.SELECT_DIR_PAGE]
>  
>          self.current_page = 0
>          self.back_button.set_sensitive(0)
> @@ -340,7 +340,7 @@ class childWindow:
>              self.error(e.message)
>  
>      def confine_application(self):
> -        return self.get_type() in generate.APPLICATIONS
> +        return self.get_type() in sepolicy.generate.APPLICATIONS
>  
>      def forward(self, arg):
>          type = self.get_type()
> @@ -437,41 +437,41 @@ class childWindow:
>  
>      def get_type(self):
>          if self.sandbox_radiobutton.get_active():
> -            return generate.SANDBOX
> +            return sepolicy.generate.SANDBOX
>          if self.cgi_radiobutton.get_active():
> -            return generate.CGI
> +            return sepolicy.generate.CGI
>          if self.user_radiobutton.get_active():
> -            return generate.USER
> +            return sepolicy.generate.USER
>          if self.init_radiobutton.get_active():
> -            return generate.DAEMON
> +            return sepolicy.generate.DAEMON
>          if self.dbus_radiobutton.get_active():
> -            return generate.DBUS
> +            return sepolicy.generate.DBUS
>          if self.inetd_radiobutton.get_active():
> -            return generate.INETD
> +            return sepolicy.generate.INETD
>          if self.login_user_radiobutton.get_active():
> -            return generate.LUSER
> +            return sepolicy.generate.LUSER
>          if self.admin_user_radiobutton.get_active():
> -            return generate.AUSER
> +            return sepolicy.generate.AUSER
>          if self.xwindows_user_radiobutton.get_active():
> -            return generate.XUSER
> +            return sepolicy.generate.XUSER
>          if self.terminal_user_radiobutton.get_active():
> -            return generate.TUSER
> +            return sepolicy.generate.TUSER
>          if self.root_user_radiobutton.get_active():
> -            return generate.RUSER
> +            return sepolicy.generate.RUSER
>          if self.existing_user_radiobutton.get_active():
> -            return generate.EUSER
> +            return sepolicy.generate.EUSER
>  
>      def generate_policy(self, *args):
>          outputdir = self.output_entry.get_text()
>          try:
> -            my_policy = generate.policy(self.get_name(), self.get_type())
> +            my_policy = sepolicy.generate.policy(self.get_name(), self.get_type())
>  
>              iter = self.boolean_store.get_iter_first()
>              while(iter):
>                  my_policy.add_boolean(self.boolean_store.get_value(iter, 0), self.boolean_store.get_value(iter, 1))
>                  iter = self.boolean_store.iter_next(iter)
>  
> -            if self.get_type() in generate.APPLICATIONS:
> +            if self.get_type() in sepolicy.generate.APPLICATIONS:
>                  my_policy.set_program(self.exec_entry.get_text())
>                  my_policy.gen_symbols()
>  
> @@ -484,14 +484,14 @@ class childWindow:
>                  my_policy.set_use_audit(self.audit_checkbutton.get_active() == 1)
>                  my_policy.set_use_terminal(self.terminal_checkbutton.get_active() == 1)
>                  my_policy.set_use_mail(self.mail_checkbutton.get_active() == 1)
> -                if self.get_type() is generate.DAEMON:
> +                if self.get_type() is sepolicy.generate.DAEMON:
>                      my_policy.set_init_script(self.init_script_entry.get_text())
> -                if self.get_type() == generate.USER:
> +                if self.get_type() == sepolicy.generate.USER:
>                      selected = []
>                      self.user_transition_treeview.get_selection().selected_foreach(foreach, selected)
>                      my_policy.set_transition_users(selected)
>              else:
> -                if self.get_type() == generate.RUSER:
> +                if self.get_type() == sepolicy.generate.RUSER:
>                      selected = []
>                      self.admin_treeview.get_selection().selected_foreach(foreach, selected)
>                      my_policy.set_admin_domains(selected)
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index 5100720..2cc56d9 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -31,8 +31,7 @@ import stat
>  from semanage import *
>  PROGNAME = "policycoreutils"
>  import sepolicy
> -from sepolicy import boolean_desc, boolean_category, gen_bool_dict
> -gen_bool_dict()
> +sepolicy.gen_bool_dict()
>  from IPy import IP
>  
>  import gettext
> @@ -2189,11 +2188,11 @@ class booleanRecords(semanageRecords):
>  
>      def get_desc(self, name):
>          name = selinux.selinux_boolean_sub(name)
> -        return boolean_desc(name)
> +        return sepolicy.boolean_desc(name)
>  
>      def get_category(self, name):
>          name = selinux.selinux_boolean_sub(name)
> -        return boolean_category(name)
> +        return sepolicy.boolean_category(name)
>  
>      def customized(self):
>          l = []
> 
