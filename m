Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7IIhgEO019898
 for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2018 14:43:42 -0400
Received: by mail-oi0-f42.google.com with SMTP id 13-v6so19466303ois.1
 for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2018 11:43:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180818175033.13100-2-nicolas.iooss@m4x.org>
References: <20180818175033.13100-1-nicolas.iooss@m4x.org>
 <20180818175033.13100-2-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sat, 18 Aug 2018 11:43:31 -0700
Message-ID: <CAFftDdr5ZFUUXQZhVDDUTjVRJb6b_zZ4MxHRxTN2d2t5yXXOZA@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000008658b50573ba0df5"
Subject: Re: [PATCH 2/2] libsemanage: make pywrap-test.py compatible
 with Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000008658b50573ba0df5
Content-Type: text/plain; charset="UTF-8"

Im assuming with your attention on the python side of the house we're going
to see a lot of
formatting change patches heading the mailing list. I don't have any
problems with them.

Are you using some formatter for these, if so which one is it? Is it flake8
still?

We should probably document that patches should be sent formatted, ie if a
patch introduces a delta
after applying the patch and running <formatter>, it's an issue.

On Sat, Aug 18, 2018 at 10:50 AM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> This program can be useful in order to test the Python API of
> libsemanage. Make it usable in Python 3 using 2to3 and some tweaks.
>
> While at it, fix warnings reported by flake8 linter.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/pywrap-test.py | 680 ++++++++++++++++++---------------
>  1 file changed, 369 insertions(+), 311 deletions(-)
>
> diff --git a/libsemanage/src/pywrap-test.py b/libsemanage/src/pywrap-test.
> py
> index 326034947aa5..5ac48f408380 100644
> --- a/libsemanage/src/pywrap-test.py
> +++ b/libsemanage/src/pywrap-test.py
> @@ -1,8 +1,11 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python
> +from __future__ import print_function
> +
>  import sys
>  import getopt
>  import semanage
>
> +
>  usage = "\
>  Choose one of the following tests:\n\
>  -m for modules\n\
> @@ -27,21 +30,25 @@ Other options:\n\
>  -v for verbose output\
>  "
>
> +
>  class Usage(Exception):
>      def __init__(self, msg):
>          Exception.__init__(self)
>          self.msg = msg
>
> +
>  class Status(Exception):
>      def __init__(self, msg):
>          Exception.__init__(self)
>          self.msg = msg
>
> +
>  class Error(Exception):
>      def __init__(self, msg):
>          Exception.__init__(self)
>          self.msg = msg
>
> +
>  class Tests:
>      def __init__(self):
>          self.all = False
> @@ -65,146 +72,164 @@ class Tests:
>          self.verbose = False
>
>      def selected(self):
> -        return (self.all or self.users or self.modules or self.seusers or
> self.ports or self.fcontexts or self.interfaces or self.booleans or
> self.abooleans or self.writeuser or self.writeseuser or self.writeport or
> self.writefcontext or self.writeinterface or self.writeboolean or
> self.writeaboolean or self.nodes or self.writenode)
> +        return (
> +            self.all or
> +            self.users or
> +            self.modules or
> +            self.seusers or
> +            self.ports or
> +            self.fcontexts or
> +            self.interfaces or
> +            self.booleans or
> +            self.abooleans or
> +            self.writeuser or
> +            self.writeseuser or
> +            self.writeport or
> +            self.writefcontext or
> +            self.writeinterface or
> +            self.writeboolean or
> +            self.writeaboolean or
> +            self.nodes or
> +            self.writenode)
>
>      def run(self, handle):
> -        if (self.users or self.all):
> +        if self.users or self.all:
>              self.test_users(handle)
> -            print ""
> -        if (self.seusers or self.all):
> +            print("")
> +        if self.seusers or self.all:
>              self.test_seusers(handle)
> -            print ""
> -        if (self.ports or self.all):
> +            print("")
> +        if self.ports or self.all:
>              self.test_ports(handle)
> -            print ""
> -        if (self.modules or self.all):
> +            print("")
> +        if self.modules or self.all:
>              self.test_modules(handle)
> -            print ""
> -        if (self.fcontexts or self.all):
> +            print("")
> +        if self.fcontexts or self.all:
>              self.test_fcontexts(handle)
> -            print ""
> -        if (self.interfaces or self.all):
> +            print("")
> +        if self.interfaces or self.all:
>              self.test_interfaces(handle)
> -            print ""
> -        if (self.booleans or self.all):
> +            print("")
> +        if self.booleans or self.all:
>              self.test_booleans(handle)
> -            print ""
> -        if (self.abooleans or self.all):
> +            print("")
> +        if self.abooleans or self.all:
>              self.test_abooleans(handle)
> -            print ""
> -        if (self.nodes or self.all):
> +            print("")
> +        if self.nodes or self.all:
>              self.test_nodes(handle)
> -            print ""
> -        if (self.writeuser or self.all):
> +            print("")
> +        if self.writeuser or self.all:
>              self.test_writeuser(handle)
> -            print ""
> -        if (self.writeseuser or self.all):
> +            print("")
> +        if self.writeseuser or self.all:
>              self.test_writeseuser(handle)
> -            print ""
> -        if (self.writeport or self.all):
> +            print("")
> +        if self.writeport or self.all:
>              self.test_writeport(handle)
> -            print ""
> -        if (self.writefcontext or self.all):
> +            print("")
> +        if self.writefcontext or self.all:
>              self.test_writefcontext(handle)
> -            print ""
> -        if (self.writeinterface or self.all):
> +            print("")
> +        if self.writeinterface or self.all:
>              self.test_writeinterface(handle)
> -            print ""
> -        if (self.writeboolean or self.all):
> +            print("")
> +        if self.writeboolean or self.all:
>              self.test_writeboolean(handle)
> -            print ""
> -        if (self.writeaboolean or self.all):
> +            print("")
> +        if self.writeaboolean or self.all:
>              self.test_writeaboolean(handle)
> -            print ""
> -        if (self.writenode or self.all):
> +            print("")
> +        if self.writenode or self.all:
>              self.test_writenode(handle)
> -            print ""
> +            print("")
>
> -    def test_modules(self,sh):
> -        print "Testing modules..."
> +    def test_modules(self, sh):
> +        print("Testing modules...")
>
>          (trans_cnt, mlist, mlist_size) = semanage.semanage_module_list(
> sh)
>
> -        print "Transaction number: ", trans_cnt
> -        print "Module list size: ", mlist_size
> +        print("Transaction number: %s" % trans_cnt)
> +        print("Module list size: %s" % mlist_size)
>          if self.verbose:
> -            print "List reference: ", mlist
> +            print("List reference: %s" % mlist)
>
> -        if (mlist_size == 0):
> -            print "No modules installed!"
> -            print "This is not necessarily a test failure."
> +        if mlist_size == 0:
> +            print("No modules installed!")
> +            print("This is not necessarily a test failure.")
>              return
>          for idx in range(mlist_size):
>              module = semanage.semanage_module_list_nth(mlist, idx)
>              if self.verbose:
> -                print "Module reference: ", module
> -            print "Module name: ", semanage.semanage_module_get_
> name(module)
> +                print("Module reference: %s" % module)
> +            print("Module name: %s" % semanage.semanage_module_get_
> name(module))
>
> -    def test_seusers(self,sh):
> -        print "Testing seusers..."
> +    def test_seusers(self, sh):
> +        print("Testing seusers...")
>
>          (status, slist) = semanage.semanage_seuser_list(sh)
>          if status < 0:
>              raise Error("Could not list seusers")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if ( len(slist) == 0):
> -            print "No seusers found!"
> -            print "This is not necessarily a test failure."
> +        if len(slist) == 0:
> +            print("No seusers found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for seuser in slist:
>              if self.verbose:
> -                print "seseuser reference: ", seuser
> -            print "seuser name: ", semanage.semanage_seuser_get_
> name(seuser)
> -            print "   seuser mls range: ", semanage.semanage_seuser_get_
> mlsrange(seuser)
> -            print "   seuser sename: ", semanage.semanage_seuser_get_
> sename(seuser)
> +                print("seseuser reference: %s" % seuser)
> +            print("seuser name: %s" % semanage.semanage_seuser_get_
> name(seuser))
> +            print("   seuser mls range: %s" %
> semanage.semanage_seuser_get_mlsrange(seuser))
> +            print("   seuser sename: %s" % semanage.semanage_seuser_get_
> sename(seuser))
>              semanage.semanage_seuser_free(seuser)
>
> -    def test_users(self,sh):
> -        print "Testing users..."
> +    def test_users(self, sh):
> +        print("Testing users...")
>
>          (status, ulist) = semanage.semanage_user_list(sh)
>          if status < 0:
>              raise Error("Could not list users")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if ( len(ulist) == 0):
> -            print "No users found!"
> -            print "This is not necessarily a test failure."
> +        if len(ulist) == 0:
> +            print("No users found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for user in ulist:
>              if self.verbose:
> -                print "User reference: ", user
> -            print "User name: ", semanage.semanage_user_get_name(user)
> -            print "   User labeling prefix: ", semanage.semanage_user_get_
> prefix(user)
> -            print "   User mls level: ", semanage.semanage_user_get_
> mlslevel(user)
> -            print "   User mls range: ", semanage.semanage_user_get_
> mlsrange(user)
> -            print "   User number of roles: ", semanage.semanage_user_get_
> num_roles(user)
> -            print "   User roles: "
> +                print("User reference: %s" % user)
> +            print("User name: %s" % semanage.semanage_user_get_
> name(user))
> +            print("   User labeling prefix: %s" %
> semanage.semanage_user_get_prefix(user))
> +            print("   User mls level: %s" % semanage.semanage_user_get_
> mlslevel(user))
> +            print("   User mls range: %s" % semanage.semanage_user_get_
> mlsrange(user))
> +            print("   User number of roles: %s" %
> semanage.semanage_user_get_num_roles(user))
> +            print("   User roles: ")
>              (status, rlist) = semanage.semanage_user_get_roles(sh, user)
>              if status < 0:
>                  raise Error("Could not get user roles")
>
>              for role in rlist:
> -                print "      ", role
> +                print("      %s" % role)
>
>              semanage.semanage_user_free(user)
>
> -    def test_ports(self,sh):
> -        print "Testing ports..."
> +    def test_ports(self, sh):
> +        print("Testing ports...")
>
>          (status, plist) = semanage.semanage_port_list(sh)
>          if status < 0:
>              raise Error("Could not list ports")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if ( len(plist) == 0):
> -            print "No ports found!"
> -            print "This is not necessarily a test failure."
> +        if len(plist) == 0:
> +            print("No ports found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for port in plist:
>              if self.verbose:
> -                print "Port reference: ", port
> +                print("Port reference: %s" % port)
>              low = semanage.semanage_port_get_low(port)
>              high = semanage.semanage_port_get_high(port)
>              con = semanage.semanage_port_get_con(port)
> @@ -214,26 +239,27 @@ class Tests:
>                  range_str = str(low)
>              else:
>                  range_str = str(low) + "-" + str(high)
> -            (rc, con_str) = semanage.semanage_context_to_string(sh,con)
> -            if rc < 0: con_str = ""
> -            print "Port: ", range_str, " ", proto_str, " Context: ",
> con_str
> +            (rc, con_str) = semanage.semanage_context_to_string(sh, con)
> +            if rc < 0:
> +                con_str = ""
> +            print("Port: %s %s Context: %s" % (range_str, proto_str,
> con_str))
>              semanage.semanage_port_free(port)
>
> -    def test_fcontexts(self,sh):
> -        print "Testing file contexts..."
> +    def test_fcontexts(self, sh):
> +        print("Testing file contexts...")
>
>          (status, flist) = semanage.semanage_fcontext_list(sh)
>          if status < 0:
>              raise Error("Could not list file contexts")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if (len(flist) == 0):
> -            print "No file contexts found!"
> -            print "This is not necessarily a test failure."
> +        if len(flist) == 0:
> +            print("No file contexts found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for fcon in flist:
>              if self.verbose:
> -                print "File Context reference: ", fcon
> +                print("File Context reference: %s" % fcon)
>              expr = semanage.semanage_fcontext_get_expr(fcon)
>              type = semanage.semanage_fcontext_get_type(fcon)
>              type_str = semanage.semanage_fcontext_get_type_str(type)
> @@ -241,406 +267,413 @@ class Tests:
>              if not con:
>                  con_str = "<<none>>"
>              else:
> -                (rc, con_str) = semanage.semanage_context_to_
> string(sh,con)
> -                if rc < 0: con_str = ""
> -            print "File Expr: ", expr, " [", type_str, "] Context: ",
> con_str
> +                (rc, con_str) = semanage.semanage_context_to_string(sh,
> con)
> +                if rc < 0:
> +                    con_str = ""
> +            print("File Expr: %s [%s] Context: %s" % (expr, type_str,
> con_str))
>              semanage.semanage_fcontext_free(fcon)
>
> -    def test_interfaces(self,sh):
> -        print "Testing network interfaces..."
> +    def test_interfaces(self, sh):
> +        print("Testing network interfaces...")
>
>          (status, ilist) = semanage.semanage_iface_list(sh)
>          if status < 0:
>              raise Error("Could not list interfaces")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if (len(ilist) == 0):
> -            print "No network interfaces found!"
> -            print "This is not necessarily a test failure."
> +        if len(ilist) == 0:
> +            print("No network interfaces found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for iface in ilist:
>              if self.verbose:
> -                print "Interface reference: ", iface
> +                print("Interface reference: %s" % iface)
>              name = semanage.semanage_iface_get_name(iface)
>              msg_con = semanage.semanage_iface_get_msgcon(iface)
>              if_con = semanage.semanage_iface_get_ifcon(iface)
> -            (rc, msg_con_str) = semanage.semanage_context_to_
> string(sh,msg_con)
> -            if rc < 0: msg_con_str = ""
> +            (rc, msg_con_str) = semanage.semanage_context_to_string(sh,
> msg_con)
> +            if rc < 0:
> +                msg_con_str = ""
>              (rc, if_con_str) = semanage.semanage_context_to_string(sh,
> if_con)
> -            if rc < 0: if_con_str = ""
> -            print "Interface: ", name, " Context: ", if_con_str, "
> Message Context: ", msg_con_str
> +            if rc < 0:
> +                if_con_str = ""
> +            print("Interface: %s Context: %s Message Context: %s" %
> (name, if_con_str, msg_con_str))
>              semanage.semanage_iface_free(iface)
>
> -    def test_booleans(self,sh):
> -        print "Testing booleans..."
> +    def test_booleans(self, sh):
> +        print("Testing booleans...")
>
>          (status, blist) = semanage.semanage_bool_list(sh)
>          if status < 0:
>              raise Error("Could not list booleans")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if (len(blist) == 0):
> -            print "No booleans found!"
> -            print "This is not necessarily a test failure."
> +        if len(blist) == 0:
> +            print("No booleans found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for pbool in blist:
>              if self.verbose:
> -                print "Boolean reference: ", pbool
> +                print("Boolean reference: %s" % pbool)
>              name = semanage.semanage_bool_get_name(pbool)
>              value = semanage.semanage_bool_get_value(pbool)
> -            print "Boolean: ", name, " Value: ", value
> +            print("Boolean: %s Value: %s" % (name, value))
>              semanage.semanage_bool_free(pbool)
>
> -    def test_abooleans(self,sh):
> -        print "Testing active booleans..."
> +    def test_abooleans(self, sh):
> +        print("Testing active booleans...")
>
>          (status, ablist) = semanage.semanage_bool_list_active(sh)
>          if status < 0:
>              raise Error("Could not list active booleans")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if (len(ablist) == 0):
> -            print "No active booleans found!"
> -            print "This is not necessarily a test failure."
> +        if len(ablist) == 0:
> +            print("No active booleans found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for abool in ablist:
>              if self.verbose:
> -                print "Active boolean reference: ", abool
> +                print("Active boolean reference: %s" % abool)
>              name = semanage.semanage_bool_get_name(abool)
>              value = semanage.semanage_bool_get_value(abool)
> -            print "Active Boolean: ", name, " Value: ", value
> +            print("Active Boolean: %s Value: %s" % (name, value))
>              semanage.semanage_bool_free(abool)
>
> -    def test_nodes(self,sh):
> -        print "Testing network nodes..."
> +    def test_nodes(self, sh):
> +        print("Testing network nodes...")
>
>          (status, nlist) = semanage.semanage_node_list(sh)
>          if status < 0:
>              raise Error("Could not list network nodes")
> -        print "Query status (commit number): ", status
> +        print("Query status (commit number): %s" % status)
>
> -        if (len(nlist) == 0):
> -            print "No network nodes found!"
> -            print "This is not necessarily a test failure."
> +        if len(nlist) == 0:
> +            print("No network nodes found!")
> +            print("This is not necessarily a test failure.")
>              return
>          for node in nlist:
>              if self.verbose:
> -                print "Network node reference: ", node
> +                print("Network node reference: %s" % node)
>
>              (status, addr) = semanage.semanage_node_get_addr(sh, node)
> -            if status < 0: addr = ""
> +            if status < 0:
> +                addr = ""
>
>              (status, mask) = semanage.semanage_node_get_mask(sh, node)
> -            if status < 0: mask = ""
> +            if status < 0:
> +                mask = ""
>
>              proto = semanage.semanage_node_get_proto(node)
>              proto_str = semanage.semanage_node_get_proto_str(proto)
>              con = semanage.semanage_node_get_con(node)
>
>              (status, con_str) = semanage.semanage_context_to_string(sh,
> con)
> -            if status < 0: con_str = ""
> +            if status < 0:
> +                con_str = ""
>
> -            print "Network Node: ", addr, "/", mask, " (", proto_str,
> ")", "Context: ", con_str
> +            print("Network Node: %s/%s (%s) Context: %s" % (addr, mask,
> proto_str, con_str))
>              semanage.semanage_node_free(node)
>
> -    def test_writeuser(self,sh):
> -        print "Testing user write..."
> +    def test_writeuser(self, sh):
> +        print("Testing user write...")
>
>          (status, user) = semanage.semanage_user_create(sh)
>          if status < 0:
>              raise Error("Could not create user object")
>          if self.verbose:
> -            print "User object created"
> +            print("User object created")
>
> -        status = semanage.semanage_user_set_name(sh,user, "testPyUser")
> +        status = semanage.semanage_user_set_name(sh, user, "testPyUser")
>          if status < 0:
>              raise Error("Could not set user name")
>          if self.verbose:
> -            print "User name set: ", semanage.semanage_user_get_
> name(user)
> +            print("User name set: %s" % semanage.semanage_user_get_
> name(user))
>
>          status = semanage.semanage_user_add_role(sh, user, "user_r")
>          if status < 0:
>              raise Error("Could not add role")
>
> -        status = semanage.semanage_user_set_prefix(sh,user, "user")
> +        status = semanage.semanage_user_set_prefix(sh, user, "user")
>          if status < 0:
>              raise Error("Could not set labeling prefix")
>          if self.verbose:
> -            print "User prefix set: ", semanage.semanage_user_get_
> prefix(user)
> +            print("User prefix set: %s" % semanage.semanage_user_get_
> prefix(user))
>
>          status = semanage.semanage_user_set_mlsrange(sh, user, "s0")
>          if status < 0:
>              raise Error("Could not set MLS range")
>          if self.verbose:
> -            print "User mlsrange: ", semanage.semanage_user_get_
> mlsrange(user)
> +            print("User mlsrange: %s" % semanage.semanage_user_get_
> mlsrange(user))
>
>          status = semanage.semanage_user_set_mlslevel(sh, user, "s0")
>          if status < 0:
>              raise Error("Could not set MLS level")
>          if self.verbose:
> -            print "User mlslevel: ", semanage.semanage_user_get_
> mlslevel(user)
> +            print("User mlslevel: %s" % semanage.semanage_user_get_
> mlslevel(user))
>
> -        (status,key) = semanage.semanage_user_key_extract(sh,user)
> +        (status, key) = semanage.semanage_user_key_extract(sh, user)
>          if status < 0:
>              raise Error("Could not extract user key")
>          if self.verbose:
> -            print "User key extracted: ", key
> +            print("User key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_user_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_user_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if user exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_user) = semanage.semanage_user_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old user")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction.."
> +        print("Starting transaction..")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_user_modify_local(sh,key,user)
> +        status = semanage.semanage_user_modify_local(sh, key, user)
>          if status < 0:
>              raise Error("Could not modify user")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing user..."
> +            print("Removing user...")
>              status = semanage.semanage_user_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test user")
>              if self.verbose:
> -                print "User delete: ", status
> +                print("User delete: %s" % status)
>          else:
> -            print "Resetting user..."
> +            print("Resetting user...")
>              status = semanage.semanage_user_modify_local(sh, key,
> old_user)
>              if status < 0:
>                  raise Error("Could not reset test user")
>              if self.verbose:
> -                print "User modify: ", status
> +                print("User modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_user_key_free(key)
>          semanage.semanage_user_free(user)
> -        if exists: semanage.semanage_user_free(old_user)
> +        if exists:
> +            semanage.semanage_user_free(old_user)
>
> -    def test_writeseuser(self,sh):
> -        print "Testing seuser write..."
> +    def test_writeseuser(self, sh):
> +        print("Testing seuser write...")
>
>          (status, seuser) = semanage.semanage_seuser_create(sh)
>          if status < 0:
>              raise Error("Could not create SEUser object")
>          if self.verbose:
> -            print "SEUser object created."
> +            print("SEUser object created.")
>
> -        status = semanage.semanage_seuser_set_name(sh,seuser,
> "testPySEUser")
> +        status = semanage.semanage_seuser_set_name(sh, seuser,
> "testPySEUser")
>          if status < 0:
>              raise Error("Could not set name")
>          if self.verbose:
> -            print "SEUser name set: ", semanage.semanage_seuser_get_
> name(seuser)
> +            print("SEUser name set: %s" % semanage.semanage_seuser_get_
> name(seuser))
>
>          status = semanage.semanage_seuser_set_sename(sh, seuser, "root")
>          if status < 0:
>              raise Error("Could not set sename")
>          if self.verbose:
> -            print "SEUser seuser: ", semanage.semanage_seuser_get_
> sename(seuser)
> +            print("SEUser seuser: %s" % semanage.semanage_seuser_get_
> sename(seuser))
>
>          status = semanage.semanage_seuser_set_mlsrange(sh, seuser,
> "s0:c0.c255")
>          if status < 0:
>              raise Error("Could not set MLS range")
>          if self.verbose:
> -            print "SEUser mlsrange: ", semanage.semanage_seuser_get_
> mlsrange(seuser)
> +            print("SEUser mlsrange: %s" % semanage.semanage_seuser_get_
> mlsrange(seuser))
>
> -        (status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
> +        (status, key) = semanage.semanage_seuser_key_extract(sh, seuser)
>          if status < 0:
>              raise Error("Could not extract SEUser key")
>          if self.verbose:
> -            print "SEUser key extracted: ", key
> +            print("SEUser key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_seuser_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_seuser_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if SEUser exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_seuser) = semanage.semanage_seuser_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SEUser")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_seuser_modify_local(sh,key,seuser)
> +        status = semanage.semanage_seuser_modify_local(sh, key, seuser)
>          if status < 0:
>              raise Error("Could not modify SEUser")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing seuser..."
> +            print("Removing seuser...")
>              status = semanage.semanage_seuser_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SEUser")
>              if self.verbose:
> -                print "Seuser delete: ", status
> +                print("Seuser delete: %s" % status)
>          else:
> -            print "Resetting seuser..."
> +            print("Resetting seuser...")
>              status = semanage.semanage_seuser_modify_local(sh, key,
> old_seuser)
>              if status < 0:
>                  raise Error("Could not reset test SEUser")
>              if self.verbose:
> -                print "Seuser modify: ", status
> +                print("Seuser modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_seuser_key_free(key)
>          semanage.semanage_seuser_free(seuser)
>          if exists:
>              semanage.semanage_seuser_free(old_seuser)
>
> -    def test_writeport(self,sh):
> -        print "Testing port write..."
> +    def test_writeport(self, sh):
> +        print("Testing port write...")
>
>          (status, port) = semanage.semanage_port_create(sh)
>          if status < 0:
>              raise Error("Could not create SEPort object")
>          if self.verbose:
> -            print "SEPort object created."
> +            print("SEPort object created.")
>
> -        semanage.semanage_port_set_range(port,150,200)
> +        semanage.semanage_port_set_range(port, 150, 200)
>          low = semanage.semanage_port_get_low(port)
>          high = semanage.semanage_port_get_high(port)
>          if self.verbose:
> -            print "SEPort range set: ", low, "-", high
> +            print("SEPort range set: %s-%s" % (low, high))
>
>          semanage.semanage_port_set_proto(port,
> semanage.SEMANAGE_PROTO_TCP)
>          if self.verbose:
> -            print "SEPort protocol set: ", semanage.semanage_port_get_
> proto_str(semanage.SEMANAGE_PROTO_TCP)
> +            print("SEPort protocol set: %s" % semanage.semanage_port_get_
> proto_str(semanage.SEMANAGE_PROTO_TCP))
>
>          (status, con) = semanage.semanage_context_create(sh)
>          if status < 0:
>              raise Error("Could not create SEContext object")
>          if self.verbose:
> -            print "SEContext object created (for port)."
> +            print("SEContext object created (for port).")
>
>          status = semanage.semanage_context_set_user(sh, con, "system_u")
>          if status < 0:
>              raise Error("Could not set context user")
>          if self.verbose:
> -            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +            print("SEContext user: %s" % semanage.semanage_context_get_
> user(con))
>
>          status = semanage.semanage_context_set_role(sh, con, "object_r")
>          if status < 0:
>              raise Error("Could not set context role")
>          if self.verbose:
> -            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +            print("SEContext role: %s" % semanage.semanage_context_get_
> role(con))
>
>          status = semanage.semanage_context_set_type(sh, con,
> "http_port_t")
>          if status < 0:
>              raise Error("Could not set context type")
>          if self.verbose:
> -            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +            print("SEContext type: %s" % semanage.semanage_context_get_
> type(con))
>
>          status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
>          if status < 0:
>              raise Error("Could not set context MLS fields")
>          if self.verbose:
> -            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +            print("SEContext mls: %s" % semanage.semanage_context_get_
> mls(con))
>
>          status = semanage.semanage_port_set_con(sh, port, con)
>          if status < 0:
>              raise Error("Could not set SEPort context")
>          if self.verbose:
> -            print "SEPort context set: ", con
> +            print("SEPort context set: %s" % con)
>
> -        (status,key) = semanage.semanage_port_key_extract(sh,port)
> +        (status, key) = semanage.semanage_port_key_extract(sh, port)
>          if status < 0:
>              raise Error("Could not extract SEPort key")
>          if self.verbose:
> -            print "SEPort key extracted: ", key
> +            print("SEPort key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_port_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_port_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if SEPort exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_port) = semanage.semanage_port_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SEPort")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_port_modify_local(sh,key,port)
> +        status = semanage.semanage_port_modify_local(sh, key, port)
>          if status < 0:
>              raise Error("Could not modify SEPort")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing port range..."
> +            print("Removing port range...")
>              status = semanage.semanage_port_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SEPort")
>              if self.verbose:
> -                print "Port range delete: ", status
> +                print("Port range delete: %s" % status)
>          else:
> -            print "Resetting port range..."
> +            print("Resetting port range...")
>              status = semanage.semanage_port_modify_local(sh, key,
> old_port)
>              if status < 0:
>                  raise Error("Could not reset test SEPort")
>              if self.verbose:
> -                print "Port range modify: ", status
> +                print("Port range modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_context_free(con)
>          semanage.semanage_port_key_free(key)
> @@ -648,118 +681,118 @@ class Tests:
>          if exists:
>              semanage.semanage_port_free(old_port)
>
> -    def test_writefcontext(self,sh):
> -        print "Testing file context write..."
> +    def test_writefcontext(self, sh):
> +        print("Testing file context write...")
>
>          (status, fcon) = semanage.semanage_fcontext_create(sh)
>          if status < 0:
>              raise Error("Could not create SEFcontext object")
>          if self.verbose:
> -            print "SEFcontext object created."
> +            print("SEFcontext object created.")
>
>          status = semanage.semanage_fcontext_set_expr(sh, fcon,
> "/test/fcontext(/.*)?")
>          if status < 0:
>              raise Error("Could not set expression")
>          if self.verbose:
> -            print "SEFContext expr set: ", semanage.semanage_fcontext_
> get_expr(fcon)
> +            print("SEFContext expr set: %s" % semanage.semanage_fcontext_
> get_expr(fcon))
>
>          semanage.semanage_fcontext_set_type(fcon,
> semanage.SEMANAGE_FCONTEXT_REG)
>          if self.verbose:
>              ftype = semanage.semanage_fcontext_get_type(fcon)
> -            print "SEFContext type set: ", semanage.semanage_fcontext_
> get_type_str(ftype)
> +            print("SEFContext type set: %s" % semanage.semanage_fcontext_
> get_type_str(ftype))
>
>          (status, con) = semanage.semanage_context_create(sh)
>          if status < 0:
>              raise Error("Could not create SEContext object")
>          if self.verbose:
> -            print "SEContext object created (for file context)."
> +            print("SEContext object created (for file context).")
>
>          status = semanage.semanage_context_set_user(sh, con, "system_u")
>          if status < 0:
>              raise Error("Could not set context user")
>          if self.verbose:
> -            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +            print("SEContext user: %s" % semanage.semanage_context_get_
> user(con))
>
>          status = semanage.semanage_context_set_role(sh, con, "object_r")
>          if status < 0:
>              raise Error("Could not set context role")
>          if self.verbose:
> -            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +            print("SEContext role: %s" % semanage.semanage_context_get_
> role(con))
>
>          status = semanage.semanage_context_set_type(sh, con, "default_t")
>          if status < 0:
>              raise Error("Could not set context type")
>          if self.verbose:
> -            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +            print("SEContext type: %s" % semanage.semanage_context_get_
> type(con))
>
>          status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
>          if status < 0:
>              raise Error("Could not set context MLS fields")
>          if self.verbose:
> -            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +            print("SEContext mls: %s" % semanage.semanage_context_get_
> mls(con))
>
>          status = semanage.semanage_fcontext_set_con(sh, fcon, con)
>          if status < 0:
>              raise Error("Could not set SEFcontext context")
>          if self.verbose:
> -            print "SEFcontext context set: ", con
> +            print("SEFcontext context set: %s" % con)
>
> -        (status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
> +        (status, key) = semanage.semanage_fcontext_key_extract(sh, fcon)
>          if status < 0:
>              raise Error("Could not extract SEFcontext key")
>          if self.verbose:
> -            print "SEFcontext key extracted: ", key
> +            print("SEFcontext key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_fcontext_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_fcontext_exists_local(sh,
> key)
>          if status < 0:
>              raise Error("Could not check if SEFcontext exists")
>
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>          if exists:
>              (status, old_fcontext) = semanage.semanage_fcontext_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SEFcontext")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_fcontext_modify_local(sh,key,fcon)
> +        status = semanage.semanage_fcontext_modify_local(sh, key, fcon)
>          if status < 0:
>              raise Error("Could not modify SEFcontext")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing file context..."
> +            print("Removing file context...")
>              status = semanage.semanage_fcontext_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SEFcontext")
>              if self.verbose:
> -                print "File context delete: ", status
> +                print("File context delete: %s" % status)
>          else:
> -            print "Resetting file context..."
> +            print("Resetting file context...")
>              status = semanage.semanage_fcontext_modify_local(sh, key,
> old_fcontext)
>              if status < 0:
>                  raise Error("Could not reset test FContext")
>              if self.verbose:
> -                print "File context modify: ", status
> +                print("File context modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_context_free(con)
>          semanage.semanage_fcontext_key_free(key)
> @@ -767,119 +800,119 @@ class Tests:
>          if exists:
>              semanage.semanage_fcontext_free(old_fcontext)
>
> -    def test_writeinterface(self,sh):
> -        print "Testing network interface write..."
> +    def test_writeinterface(self, sh):
> +        print("Testing network interface write...")
>
>          (status, iface) = semanage.semanage_iface_create(sh)
>          if status < 0:
>              raise Error("Could not create SEIface object")
>          if self.verbose:
> -            print "SEIface object created."
> +            print("SEIface object created.")
>
>          status = semanage.semanage_iface_set_name(sh, iface,
> "test_iface")
>          if status < 0:
>              raise Error("Could not set SEIface name")
>          if self.verbose:
> -            print "SEIface name set: ", semanage.semanage_iface_get_
> name(iface)
> +            print("SEIface name set: %s" % semanage.semanage_iface_get_
> name(iface))
>
>          (status, con) = semanage.semanage_context_create(sh)
>          if status < 0:
>              raise Error("Could not create SEContext object")
>          if self.verbose:
> -            print "SEContext object created (for network interface)"
> +            print("SEContext object created (for network interface)")
>
>          status = semanage.semanage_context_set_user(sh, con, "system_u")
>          if status < 0:
>              raise Error("Could not set interface context user")
>          if self.verbose:
> -            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +            print("SEContext user: %s" % semanage.semanage_context_get_
> user(con))
>
>          status = semanage.semanage_context_set_role(sh, con, "object_r")
>          if status < 0:
>              raise Error("Could not set interface context role")
>          if self.verbose:
> -            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +            print("SEContext role: %s" % semanage.semanage_context_get_
> role(con))
>
>          status = semanage.semanage_context_set_type(sh, con, "default_t")
>          if status < 0:
>              raise Error("Could not set interface context type")
>          if self.verbose:
> -            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +            print("SEContext type: %s" % semanage.semanage_context_get_
> type(con))
>
>          status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
>          if status < 0:
>              raise Error("Could not set interface context MLS fields")
>          if self.verbose:
> -            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +            print("SEContext mls: %s" % semanage.semanage_context_get_
> mls(con))
>
>          status = semanage.semanage_iface_set_ifcon(sh, iface, con)
>          if status < 0:
>              raise Error("Could not set SEIface interface context")
>          if self.verbose:
> -            print "SEIface interface context set: ", con
> +            print("SEIface interface context set: %s" % con)
>
>          status = semanage.semanage_iface_set_msgcon(sh, iface, con)
>          if status < 0:
>              raise Error("Could not set SEIface message context")
>          if self.verbose:
> -            print "SEIface message context set: ", con
> +            print("SEIface message context set: %s" % con)
>
> -        (status,key) = semanage.semanage_iface_key_extract(sh,iface)
> +        (status, key) = semanage.semanage_iface_key_extract(sh, iface)
>          if status < 0:
>              raise Error("Could not extract SEIface key")
>          if self.verbose:
> -            print "SEIface key extracted: ", key
> +            print("SEIface key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_iface_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_iface_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if SEIface exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_iface) = semanage.semanage_iface_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SEIface")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not begin semanage transaction")
>
> -        status = semanage.semanage_iface_modify_local(sh,key,iface)
> +        status = semanage.semanage_iface_modify_local(sh, key, iface)
>          if status < 0:
>              raise Error("Could not modify SEIface")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not begin semanage transaction")
>
>          if not exists:
> -            print "Removing interface..."
> +            print("Removing interface...")
>              status = semanage.semanage_iface_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SEIface")
>              if self.verbose:
> -                print "Interface delete: ", status
> +                print("Interface delete: %s" % status)
>          else:
> -            print "Resetting interface..."
> +            print("Resetting interface...")
>              status = semanage.semanage_iface_modify_local(sh, key,
> old_iface)
>              if status < 0:
>                  raise Error("Could not reset test SEIface")
>              if self.verbose:
> -                print "Interface modify: ", status
> +                print("Interface modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_context_free(con)
>          semanage.semanage_iface_key_free(key)
> @@ -887,45 +920,45 @@ class Tests:
>          if exists:
>              semanage.semanage_iface_free(old_iface)
>
> -    def test_writeboolean(self,sh):
> -        print "Testing boolean write..."
> +    def test_writeboolean(self, sh):
> +        print("Testing boolean write...")
>
>          (status, pbool) = semanage.semanage_bool_create(sh)
>          if status < 0:
>              raise Error("Could not create SEBool object")
>          if self.verbose:
> -            print "SEBool object created."
> +            print("SEBool object created.")
>
>          status = semanage.semanage_bool_set_name(sh, pbool,
> "allow_execmem")
>          if status < 0:
>              raise Error("Could not set name")
>          if self.verbose:
> -            print "SEBool name set: ", semanage.semanage_bool_get_
> name(pbool)
> +            print("SEBool name set: %s" % semanage.semanage_bool_get_
> name(pbool))
>
>          semanage.semanage_bool_set_value(pbool, 0)
>          if self.verbose:
> -            print "SEbool value set: ", semanage.semanage_bool_get_
> value(pbool)
> +            print("SEbool value set: %s" % semanage.semanage_bool_get_
> value(pbool))
>
> -        (status,key) = semanage.semanage_bool_key_extract(sh, pbool)
> +        (status, key) = semanage.semanage_bool_key_extract(sh, pbool)
>          if status < 0:
>              raise Error("Could not extract SEBool key")
>          if self.verbose:
> -            print "SEBool key extracted: ", key
> +            print("SEBool key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_bool_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_bool_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if SEBool exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_bool) = semanage.semanage_bool_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SEBool")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
> @@ -938,110 +971,110 @@ class Tests:
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing boolean..."
> +            print("Removing boolean...")
>              status = semanage.semanage_bool_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SEBool")
>              if self.verbose:
> -                print "Boolean delete: ", status
> +                print("Boolean delete: %s" % status)
>          else:
> -            print "Resetting boolean..."
> +            print("Resetting boolean...")
>              status = semanage.semanage_bool_modify_local(sh, key,
> old_bool)
>              if status < 0:
>                  raise Error("Could not reset test SEBool")
>              if self.verbose:
> -                print "Boolean modify: ", status
> +                print("Boolean modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_bool_key_free(key)
>          semanage.semanage_bool_free(pbool)
> -        if exists: semanage.semanage_bool_free(old_bool)
> +        if exists:
> +            semanage.semanage_bool_free(old_bool)
>
> -    def test_writeaboolean(self,sh):
> -        print "Testing active boolean write..."
> +    def test_writeaboolean(self, sh):
> +        print("Testing active boolean write...")
>
>          (status, key) = semanage.semanage_bool_key_create(sh,
> "allow_execmem")
>          if status < 0:
>              raise Error("Could not create SEBool key")
>          if self.verbose:
> -            print "SEBool key created: ", key
> +            print("SEBool key created: %s" % key)
>
>          (status, old_bool) = semanage.semanage_bool_query_active(sh, key)
>          if status < 0:
>              raise Error("Could not query old SEBool")
>          if self.verbose:
> -            print "Query status (commit number): ", status
> +            print("Query status (commit number): %s" % status)
>
>          (status, abool) = semanage.semanage_bool_create(sh)
>          if status < 0:
>              raise Error("Could not create SEBool object")
>          if self.verbose:
> -            print "SEBool object created."
> +            print("SEBool object created.")
>
>          status = semanage.semanage_bool_set_name(sh, abool,
> "allow_execmem")
>          if status < 0:
>              raise Error("Could not set name")
>          if self.verbose:
> -            print "SEBool name set: ", semanage.semanage_bool_get_
> name(abool)
> +            print("SEBool name set: %s" % semanage.semanage_bool_get_
> name(abool))
>
>          semanage.semanage_bool_set_value(abool, 0)
>          if self.verbose:
> -            print "SEbool value set: ", semanage.semanage_bool_get_
> value(abool)
> +            print("SEbool value set: %s" % semanage.semanage_bool_get_
> value(abool))
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_bool_set_active(sh,key,abool)
> +        status = semanage.semanage_bool_set_active(sh, key, abool)
>          if status < 0:
>              raise Error("Could not modify SEBool")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
> -        print "Resetting old active boolean..."
> +        print("Resetting old active boolean...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_bool_set_active(sh, key,old_bool)
> +        status = semanage.semanage_bool_set_active(sh, key, old_bool)
>          if status < 0:
>              raise Error("Could not reset test SEBool")
>          if self.verbose:
> -            print "SEBool active reset: ", status
> +            print("SEBool active reset: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_bool_key_free(key)
>          semanage.semanage_bool_free(abool)
>          semanage.semanage_bool_free(old_bool)
>
> -
> -    def test_writenode(self,sh):
> -        print "Testing network node write..."
> +    def test_writenode(self, sh):
> +        print("Testing network node write...")
>
>          (status, node) = semanage.semanage_node_create(sh)
>          if status < 0:
>              raise Error("Could not create SENode object")
>          if self.verbose:
> -            print "SENode object created."
> +            print("SENode object created.")
>
>          status = semanage.semanage_node_set_addr(sh, node,
> semanage.SEMANAGE_PROTO_IP6, "ffee:dddd::bbbb")
>          if status < 0:
> @@ -1053,100 +1086,100 @@ class Tests:
>
>          semanage.semanage_node_set_proto(node,
> semanage.SEMANAGE_PROTO_IP6)
>          if self.verbose:
> -            print "SENode protocol set: ", semanage.semanage_node_get_
> proto_str(semanage.SEMANAGE_PROTO_IP6)
> +            print("SENode protocol set: %s" % semanage.semanage_node_get_
> proto_str(semanage.SEMANAGE_PROTO_IP6))
>
>          (status, con) = semanage.semanage_context_create(sh)
>          if status < 0:
>              raise Error("Could not create SEContext object")
>          if self.verbose:
> -            print "SEContext object created (for node)."
> +            print("SEContext object created (for node).")
>
>          status = semanage.semanage_context_set_user(sh, con, "system_u")
>          if status < 0:
>              raise Error("Could not set context user")
>          if self.verbose:
> -            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +            print("SEContext user: %s" % semanage.semanage_context_get_
> user(con))
>
>          status = semanage.semanage_context_set_role(sh, con, "object_r")
>          if status < 0:
>              raise Error("Could not set context role")
>          if self.verbose:
> -            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +            print("SEContext role: %s" % semanage.semanage_context_get_
> role(con))
>
>          status = semanage.semanage_context_set_type(sh, con, "lo_node_t")
>          if status < 0:
>              raise Error("Could not set context type")
>          if self.verbose:
> -            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +            print("SEContext type: %s" % semanage.semanage_context_get_
> type(con))
>
>          status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
>          if status < 0:
>              raise Error("Could not set context MLS fields")
>          if self.verbose:
> -            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +            print("SEContext mls: %s" % semanage.semanage_context_get_
> mls(con))
>
>          status = semanage.semanage_node_set_con(sh, node, con)
>          if status < 0:
>              raise Error("Could not set SENode context")
>          if self.verbose:
> -            print "SENode context set: ", con
> +            print("SENode context set: %s" % con)
>
> -        (status,key) = semanage.semanage_node_key_extract(sh, node)
> +        (status, key) = semanage.semanage_node_key_extract(sh, node)
>          if status < 0:
>              raise Error("Could not extract SENode key")
>          if self.verbose:
> -            print "SENode key extracted: ", key
> +            print("SENode key extracted: %s" % key)
>
> -        (status,exists) = semanage.semanage_node_exists_local(sh,key)
> +        (status, exists) = semanage.semanage_node_exists_local(sh, key)
>          if status < 0:
>              raise Error("Could not check if SENode exists")
>          if self.verbose:
> -            print "Exists status (commit number): ", status
> +            print("Exists status (commit number): %s" % status)
>
>          if exists:
>              (status, old_node) = semanage.semanage_node_query_local(sh,
> key)
>              if status < 0:
>                  raise Error("Could not query old SENode")
>              if self.verbose:
> -                print "Query status (commit number): ", status
> +                print("Query status (commit number): %s" % status)
>
> -        print "Starting transaction..."
> +        print("Starting transaction...")
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
> -        status = semanage.semanage_node_modify_local(sh,key, node)
> +        status = semanage.semanage_node_modify_local(sh, key, node)
>          if status < 0:
>              raise Error("Could not modify SENode")
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit test transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          status = semanage.semanage_begin_transaction(sh)
>          if status < 0:
>              raise Error("Could not start semanage transaction")
>
>          if not exists:
> -            print "Removing network node..."
> +            print("Removing network node...")
>              status = semanage.semanage_node_del_local(sh, key)
>              if status < 0:
>                  raise Error("Could not delete test SENode")
>              if self.verbose:
> -                print "Network node delete: ", status
> +                print("Network node delete: %s" % status)
>          else:
> -            print "Resetting network node..."
> +            print("Resetting network node...")
>              status = semanage.semanage_node_modify_local(sh, key,
> old_node)
>              if status < 0:
>                  raise Error("Could not reset test SENode")
>              if self.verbose:
> -                print "Network node modify: ", status
> +                print("Network node modify: %s" % status)
>
>          status = semanage.semanage_commit(sh)
>          if status < 0:
>              raise Error("Could not commit reset transaction")
> -        print "Commit status (transaction number): ", status
> +        print("Commit status (transaction number): %s" % status)
>
>          semanage.semanage_context_free(con)
>          semanage.semanage_node_key_free(key)
> @@ -1154,17 +1187,41 @@ class Tests:
>          if exists:
>              semanage.semanage_node_free(old_node)
>
> +
>  def main(argv=None):
>      if argv is None:
>          argv = sys.argv
>      try:
>          try:
> -            opts, args = getopt.getopt(argv[1:], "hvmuspfibcUSPFIBCanN",
> ["help", "verbose", "modules", "users", "seusers", "ports", "file
> contexts", "network interfaces", "booleans", "active booleans", "network
> nodes", "writeuser", "writeseuser", "writeport", "writefcontext",
> "writeinterface", "writeboolean", "writeaboolean", "writenode", "all"])
> +            opts, args = getopt.getopt(
> +                argv[1:], "hvmuspfibcUSPFIBCanN",
> +                [
> +                    "help",
> +                    "verbose",
> +                    "modules",
> +                    "users",
> +                    "seusers",
> +                    "ports",
> +                    "file contexts",
> +                    "network interfaces",
> +                    "booleans",
> +                    "active booleans",
> +                    "network nodes",
> +                    "writeuser",
> +                    "writeseuser",
> +                    "writeport",
> +                    "writefcontext",
> +                    "writeinterface",
> +                    "writeboolean",
> +                    "writeaboolean",
> +                    "writenode",
> +                    "all",
> +                ])
>              tests = Tests()
>              for o, a in opts:
>                  if o == "-v":
>                      tests.verbose = True
> -                    print "Verbose output selected."
> +                    print("Verbose output selected.")
>                  if o == "-a":
>                      tests.all = True
>                  if o == "-u":
> @@ -1207,12 +1264,12 @@ def main(argv=None):
>              if not tests.selected():
>                  raise Usage("Please select a valid test.")
>
> -        except getopt.error, msg:
> +        except getopt.error as msg:
>              raise Usage(msg)
>
> -        sh=semanage.semanage_handle_create()
> +        sh = semanage.semanage_handle_create()
>
> -        if (semanage.semanage_is_managed(sh) != 1):
> +        if semanage.semanage_is_managed(sh) != 1:
>              raise Status("Unmanaged!")
>
>          status = semanage.semanage_connect(sh)
> @@ -1227,14 +1284,15 @@ def main(argv=None):
>
>          semanage.semanage_handle_destroy(sh)
>
> -    except Usage, err:
> -        print >>sys.stderr, err.msg
> -    except Status, err:
> -        print >>sys.stderr, err.msg
> -    except Error, err:
> -        print >>sys.stderr, err.msg
> +    except Usage as err:
> +        print(err.msg, file=sys.stderr)
> +    except Status as err:
> +        print(err.msg, file=sys.stderr)
> +    except Error as err:
> +        print(err.msg, file=sys.stderr)
>
>      return 2
>
> +
>  if __name__ == "__main__":
>      sys.exit(main())
> --
> 2.18.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--0000000000008658b50573ba0df5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Im assuming with your attention on the python side of the =
house we&#39;re going to see a lot of<div>formatting change patches heading=
 the mailing list. I don&#39;t have any problems with them.</div><div><br><=
/div><div>Are you using some formatter for these, if so which one is it? Is=
 it flake8 still?<br></div><div><br></div><div>We should probably document =
that patches should be sent formatted, ie if a patch introduces a delta</di=
v><div>after applying the patch and running &lt;formatter&gt;, it&#39;s an =
issue.</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Sat, Aug 18, 2018 at 10:50 AM, Nicolas Iooss <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:nicolas.iooss@m4x.org" target=3D"_blank">nicolas.iooss@m4x.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This program can =
be useful in order to test the Python API of<br>
libsemanage. Make it usable in Python 3 using 2to3 and some tweaks.<br>
<br>
While at it, fix warnings reported by flake8 linter.<br>
<br>
Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org">n=
icolas.iooss@m4x.org</a>&gt;<br>
---<br>
=C2=A0libsemanage/src/pywrap-test.py | 680 ++++++++++++++++++------------<w=
br>---<br>
=C2=A01 file changed, 369 insertions(+), 311 deletions(-)<br>
<br>
diff --git a/libsemanage/src/pywrap-test.<wbr>py b/libsemanage/src/pywrap-t=
est.<wbr>py<br>
index 326034947aa5..5ac48f408380 100644<br>
--- a/libsemanage/src/pywrap-test.<wbr>py<br>
+++ b/libsemanage/src/pywrap-test.<wbr>py<br>
@@ -1,8 +1,11 @@<br>
-#!/usr/bin/python<br>
+#!/usr/bin/env python<br>
+from __future__ import print_function<br>
+<br>
=C2=A0import sys<br>
=C2=A0import getopt<br>
=C2=A0import semanage<br>
<br>
+<br>
=C2=A0usage =3D &quot;\<br>
=C2=A0Choose one of the following tests:\n\<br>
=C2=A0-m for modules\n\<br>
@@ -27,21 +30,25 @@ Other options:\n\<br>
=C2=A0-v for verbose output\<br>
=C2=A0&quot;<br>
<br>
+<br>
=C2=A0class Usage(Exception):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, msg):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exception.__init__(self)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.msg =3D msg<br>
<br>
+<br>
=C2=A0class Status(Exception):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, msg):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exception.__init__(self)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.msg =3D msg<br>
<br>
+<br>
=C2=A0class Error(Exception):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, msg):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Exception.__init__(self)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.msg =3D msg<br>
<br>
+<br>
=C2=A0class Tests:<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.all =3D False<br>
@@ -65,146 +72,164 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.verbose =3D False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def selected(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (self.all or self.users or self.modules=
 or self.seusers or self.ports or self.fcontexts or self.interfaces or self=
.booleans or self.abooleans or self.writeuser or self.writeseuser or self.w=
riteport or self.writefcontext or self.writeinterface or self.writeboolean =
or self.writeaboolean or self.nodes or self.writenode)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.users or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.modules or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.seusers or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fcontexts or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.interfaces or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.booleans or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.abooleans or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeuser or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeseuser or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeport or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writefcontext or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeinterface or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeboolean or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writeaboolean or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.nodes or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.writenode)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def run(self, handle):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.users or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.users or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_users(handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.seusers or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.seusers or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_seusers(handle)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.ports or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.ports or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_ports(handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.modules or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.modules or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_modules(handle)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.fcontexts or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.fcontexts or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_fcontexts(handle)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.interfaces or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.interfaces or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_interfaces(handle=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.booleans or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.booleans or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_booleans(handle)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.abooleans or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.abooleans or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_abooleans(handle)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.nodes or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.nodes or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_nodes(handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeuser or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeuser or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeuser(handle)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeseuser or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeseuser or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeseuser(handl=
e)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeport or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeport or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeport(handle)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writefcontext or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writefcontext or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writefcontext(<wb=
r>handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeinterface or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeinterface or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeinterface(<w=
br>handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeboolean or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeboolean or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeboolean(hand=
le)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writeaboolean or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writeaboolean or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writeaboolean(<wb=
r>handle)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.writenode or self.all):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.writenode or self.all:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_writenode(handle)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;&quot;)<br>
<br>
-=C2=A0 =C2=A0 def test_modules(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing modules...&quot;<br>
+=C2=A0 =C2=A0 def test_modules(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing modules...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(trans_cnt, mlist, mlist_size) =3D semana=
ge.semanage_module_list(<wbr>sh)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Transaction number: &quot;, trans_=
cnt<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Module list size: &quot;, mlist_si=
ze<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Transaction number: %s&quot; % tra=
ns_cnt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Module list size: %s&quot; % mlist=
_size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;List reference: &quo=
t;, mlist<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;List reference: %s&q=
uot; % mlist)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mlist_size =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No modules installed=
!&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if mlist_size =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No modules installed=
!&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for idx in range(mlist_size):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module =3D semanage.semanag=
e_module_list_<wbr>nth(mlist, idx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Module=
 reference: &quot;, module<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Module name: &quot;,=
 semanage.semanage_module_get_<wbr>name(module)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Module=
 reference: %s&quot; % module)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Module name: %s&quot=
; % semanage.semanage_module_get_<wbr>name(module))<br>
<br>
-=C2=A0 =C2=A0 def test_seusers(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing seusers...&quot;<br>
+=C2=A0 =C2=A0 def test_seusers(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing seusers...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, slist) =3D semanage.semanage_seu=
ser_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list seusers&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( len(slist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No seusers found!&qu=
ot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(slist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No seusers found!&qu=
ot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for seuser in slist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;seseus=
er reference: &quot;, seuser<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;seuser name: &quot;,=
 semanage.semanage_seuser_get_<wbr>name(seuser)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0seuser =
mls range: &quot;, semanage.semanage_seuser_get_<wbr>mlsrange(seuser)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0seuser =
sename: &quot;, semanage.semanage_seuser_get_<wbr>sename(seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;seseus=
er reference: %s&quot; % seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;seuser name: %s&quot=
; % semanage.semanage_seuser_get_<wbr>name(seuser))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0seuser =
mls range: %s&quot; % semanage.semanage_seuser_get_<wbr>mlsrange(seuser))<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0seuser =
sename: %s&quot; % semanage.semanage_seuser_get_<wbr>sename(seuser))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_seuser_fr=
ee(<wbr>seuser)<br>
<br>
-=C2=A0 =C2=A0 def test_users(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing users...&quot;<br>
+=C2=A0 =C2=A0 def test_users(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing users...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, ulist) =3D semanage.semanage_use=
r_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list users&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( len(ulist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No users found!&quot=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(ulist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No users found!&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for user in ulist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User r=
eference: &quot;, user<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User name: &quot;, s=
emanage.semanage_user_get_<wbr>name(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0User la=
beling prefix: &quot;, semanage.semanage_user_get_<wbr>prefix(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0User ml=
s level: &quot;, semanage.semanage_user_get_<wbr>mlslevel(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0User ml=
s range: &quot;, semanage.semanage_user_get_<wbr>mlsrange(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0User nu=
mber of roles: &quot;, semanage.semanage_user_get_<wbr>num_roles(user)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0 =C2=A0User ro=
les: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User r=
eference: %s&quot; % user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User name: %s&quot; =
% semanage.semanage_user_get_<wbr>name(user))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0User la=
beling prefix: %s&quot; % semanage.semanage_user_get_<wbr>prefix(user))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0User ml=
s level: %s&quot; % semanage.semanage_user_get_<wbr>mlslevel(user))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0User ml=
s range: %s&quot; % semanage.semanage_user_get_<wbr>mlsrange(user))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0User nu=
mber of roles: %s&quot; % semanage.semanage_user_get_<wbr>num_roles(user))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0 =C2=A0User ro=
les: &quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, rlist) =3D semanag=
e.semanage_user_get_<wbr>roles(sh, user)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not get user roles&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for role in rlist:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;=C2=A0=
 =C2=A0 =C2=A0 &quot;, role<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;=C2=A0=
 =C2=A0 =C2=A0 %s&quot; % role)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_user_free=
(<wbr>user)<br>
<br>
-=C2=A0 =C2=A0 def test_ports(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing ports...&quot;<br>
+=C2=A0 =C2=A0 def test_ports(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing ports...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, plist) =3D semanage.semanage_por=
t_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list ports&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( len(plist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No ports found!&quot=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(plist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No ports found!&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for port in plist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Port r=
eference: &quot;, port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Port r=
eference: %s&quot; % port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0low =3D semanage.semanage_p=
ort_get_<wbr>low(port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high =3D semanage.semanage_=
port_get_<wbr>high(port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D semanage.semanage_p=
ort_get_<wbr>con(port)<br>
@@ -214,26 +239,27 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range_str =3D=
 str(low)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range_str =3D=
 str(low) + &quot;-&quot; + str(high)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, con_str) =3D semanage.seman=
age_context_to_<wbr>string(sh,con)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0: con_str =3D &quot;=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Port: &quot;, range_=
str, &quot; &quot;, proto_str, &quot; Context: &quot;, con_str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, con_str) =3D semanage.seman=
age_context_to_<wbr>string(sh, con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con_str =3D &quot;=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Port: %s %s Context:=
 %s&quot; % (range_str, proto_str, con_str))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_port_free=
(<wbr>port)<br>
<br>
-=C2=A0 =C2=A0 def test_fcontexts(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing file contexts...&quot;<br>
+=C2=A0 =C2=A0 def test_fcontexts(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing file contexts...&quot;)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, flist) =3D semanage.semanage_fco=
ntext_<wbr>list(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list file contexts&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len(flist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No file contexts fou=
nd!&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(flist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No file contexts fou=
nd!&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fcon in flist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;File C=
ontext reference: &quot;, fcon<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;File C=
ontext reference: %s&quot; % fcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expr =3D semanage.semanage_=
fcontext_<wbr>get_expr(fcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D semanage.semanage_=
fcontext_<wbr>get_type(fcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type_str =3D semanage.seman=
age_fcontext_<wbr>get_type_str(type)<br>
@@ -241,406 +267,413 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not con:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con_str =3D &=
quot;&lt;&lt;none&gt;&gt;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, con_str) =3D =
semanage.semanage_context_to_<wbr>string(sh,con)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0: con_=
str =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;File Expr: &quot;, e=
xpr, &quot; [&quot;, type_str, &quot;] Context: &quot;, con_str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, con_str) =3D =
semanage.semanage_context_to_<wbr>string(sh, con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con_=
str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;File Expr: %s [%s] C=
ontext: %s&quot; % (expr, type_str, con_str))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_fcontext_=
<wbr>free(fcon)<br>
<br>
-=C2=A0 =C2=A0 def test_interfaces(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing network interfaces...&quot=
;<br>
+=C2=A0 =C2=A0 def test_interfaces(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing network interfaces...&quot=
;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, ilist) =3D semanage.semanage_ifa=
ce_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list interfaces&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len(ilist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No network interface=
s found!&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(ilist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No network interface=
s found!&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for iface in ilist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Interf=
ace reference: &quot;, iface<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Interf=
ace reference: %s&quot; % iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D semanage.semanage_=
iface_get_<wbr>name(iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg_con =3D semanage.semana=
ge_iface_get_<wbr>msgcon(iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if_con =3D semanage.semanag=
e_iface_get_<wbr>ifcon(iface)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, msg_con_str) =3D semanage.s=
emanage_context_to_<wbr>string(sh,msg_con)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0: msg_con_str =3D &q=
uot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, msg_con_str) =3D semanage.s=
emanage_context_to_<wbr>string(sh, msg_con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_con_str =3D &q=
uot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rc, if_con_str) =3D semana=
ge.semanage_context_to_<wbr>string(sh, if_con)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0: if_con_str =3D &qu=
ot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Interface: &quot;, n=
ame, &quot; Context: &quot;, if_con_str, &quot; Message Context: &quot;, ms=
g_con_str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_con_str =3D &qu=
ot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Interface: %s Contex=
t: %s Message Context: %s&quot; % (name, if_con_str, msg_con_str))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_iface_fre=
e(<wbr>iface)<br>
<br>
-=C2=A0 =C2=A0 def test_booleans(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing booleans...&quot;<br>
+=C2=A0 =C2=A0 def test_booleans(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing booleans...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, blist) =3D semanage.semanage_boo=
l_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list booleans&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len(blist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No booleans found!&q=
uot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(blist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No booleans found!&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for pbool in blist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Boolea=
n reference: &quot;, pbool<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Boolea=
n reference: %s&quot; % pbool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D semanage.semanage_=
bool_get_<wbr>name(pbool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D semanage.semanage=
_bool_get_<wbr>value(pbool)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Boolean: &quot;, nam=
e, &quot; Value: &quot;, value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Boolean: %s Value: %=
s&quot; % (name, value))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_free=
(<wbr>pbool)<br>
<br>
-=C2=A0 =C2=A0 def test_abooleans(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing active booleans...&quot;<b=
r>
+=C2=A0 =C2=A0 def test_abooleans(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing active booleans...&quot;)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, ablist) =3D semanage.semanage_bo=
ol_list_<wbr>active(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list active booleans&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len(ablist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No active booleans f=
ound!&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(ablist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No active booleans f=
ound!&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for abool in ablist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Active=
 boolean reference: &quot;, abool<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Active=
 boolean reference: %s&quot; % abool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D semanage.semanage_=
bool_get_<wbr>name(abool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D semanage.semanage=
_bool_get_<wbr>value(abool)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Active Boolean: &quo=
t;, name, &quot; Value: &quot;, value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Active Boolean: %s V=
alue: %s&quot; % (name, value))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_free=
(<wbr>abool)<br>
<br>
-=C2=A0 =C2=A0 def test_nodes(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing network nodes...&quot;<br>
+=C2=A0 =C2=A0 def test_nodes(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing network nodes...&quot;)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, nlist) =3D semanage.semanage_nod=
e_list(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 list network nodes&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit number): &quo=
t;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit number): %s&q=
uot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len(nlist) =3D=3D 0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;No network nodes fou=
nd!&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;This is not necessar=
ily a test failure.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(nlist) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;No network nodes fou=
nd!&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This is not necessar=
ily a test failure.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for node in nlist:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Networ=
k node reference: &quot;, node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Networ=
k node reference: %s&quot; % node)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, addr) =3D semanage=
.semanage_node_get_<wbr>addr(sh, node)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0: addr =3D &quot=
;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D &quot;&qu=
ot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, mask) =3D semanage=
.semanage_node_get_<wbr>mask(sh, node)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0: mask =3D &quot=
;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D &quot;&qu=
ot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proto =3D semanage.semanage=
_node_get_<wbr>proto(node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proto_str =3D semanage.sema=
nage_node_get_<wbr>proto_str(proto)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con =3D semanage.semanage_n=
ode_get_<wbr>con(node)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, con_str) =3D seman=
age.semanage_context_to_<wbr>string(sh, con)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0: con_str =3D &q=
uot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if status &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con_str =3D &quot;=
&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Network Node: &quot;=
, addr, &quot;/&quot;, mask, &quot; (&quot;, proto_str, &quot;)&quot;, &quo=
t;Context: &quot;, con_str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Network Node: %s/%s =
(%s) Context: %s&quot; % (addr, mask, proto_str, con_str))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_node_free=
(<wbr>node)<br>
<br>
-=C2=A0 =C2=A0 def test_writeuser(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing user write...&quot;<br>
+=C2=A0 =C2=A0 def test_writeuser(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing user write...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, user) =3D semanage.semanage_user=
_create(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create user object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User object created&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User object created&=
quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_set_<wbr>nam=
e(sh,user, &quot;testPyUser&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_set_<wbr>nam=
e(sh, user, &quot;testPyUser&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set user name&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User name set: &quot=
;, semanage.semanage_user_get_<wbr>name(user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User name set: %s&qu=
ot; % semanage.semanage_user_get_<wbr>name(user))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_user_add_<wb=
r>role(sh, user, &quot;user_r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 add role&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_set_<wbr>pre=
fix(sh,user, &quot;user&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_set_<wbr>pre=
fix(sh, user, &quot;user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set labeling prefix&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User prefix set: &qu=
ot;, semanage.semanage_user_get_<wbr>prefix(user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User prefix set: %s&=
quot; % semanage.semanage_user_get_<wbr>prefix(user))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_user_set_<wb=
r>mlsrange(sh, user, &quot;s0&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set MLS range&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User mlsrange: &quot=
;, semanage.semanage_user_get_<wbr>mlsrange(user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User mlsrange: %s&qu=
ot; % semanage.semanage_user_get_<wbr>mlsrange(user))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_user_set_<wb=
r>mlslevel(sh, user, &quot;s0&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set MLS level&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User mlslevel: &quot=
;, semanage.semanage_user_get_<wbr>mlslevel(user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User mlslevel: %s&qu=
ot; % semanage.semanage_user_get_<wbr>mlslevel(user))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_user_key_<w=
br>extract(sh,user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_user_key_<=
wbr>extract(sh, user)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract user key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User key extracted: =
&quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User key extracted: =
%s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_user_exi=
sts_<wbr>local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_user_ex=
ists_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if user exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_user) =3D sema=
nage.semanage_user_query_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction..&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction..&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_modify_<wbr>=
local(sh,key,user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_user_modify_<wbr>=
local(sh, key, user)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify user&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing user...&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing user...&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_user_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User d=
elete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User d=
elete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting user...&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting user...&qu=
ot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_user_modify_<wbr>local(sh, key, old_user)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;User m=
odify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;User m=
odify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_user_key_<wbr>free(key)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_user_free(<wbr>user)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if exists: semanage.semanage_user_free(<wbr>ol=
d_user)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if exists:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage.semanage_user_free(<wbr=
>old_user)<br>
<br>
-=C2=A0 =C2=A0 def test_writeseuser(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing seuser write...&quot;<br>
+=C2=A0 =C2=A0 def test_writeseuser(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing seuser write...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, seuser) =3D semanage.semanage_se=
user_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEUser object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEUser object create=
d.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEUser object create=
d.&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_seuser_set_<wbr>n=
ame(sh,seuser, &quot;testPySEUser&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_seuser_set_<wbr>n=
ame(sh, seuser, &quot;testPySEUser&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set name&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEUser name set: &qu=
ot;, semanage.semanage_seuser_get_<wbr>name(seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEUser name set: %s&=
quot; % semanage.semanage_seuser_get_<wbr>name(seuser))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_seuser_set_<=
wbr>sename(sh, seuser, &quot;root&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set sename&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEUser seuser: &quot=
;, semanage.semanage_seuser_get_<wbr>sename(seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEUser seuser: %s&qu=
ot; % semanage.semanage_seuser_get_<wbr>sename(seuser))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_seuser_set_<=
wbr>mlsrange(sh, seuser, &quot;s0:c0.c255&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set MLS range&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEUser mlsrange: &qu=
ot;, semanage.semanage_seuser_get_<wbr>mlsrange(seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEUser mlsrange: %s&=
quot; % semanage.semanage_seuser_get_<wbr>mlsrange(seuser))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_seuser_key_=
<wbr>extract(sh,seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_seuser_key=
_<wbr>extract(sh, seuser)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SEUser key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEUser key extracted=
: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEUser key extracted=
: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_seuser_<=
wbr>exists_local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_seuser_=
<wbr>exists_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SEUser exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_seuser) =3D se=
manage.semanage_seuser_<wbr>query_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SEUser&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_seuser_<wbr>modif=
y_local(sh,key,seuser)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_seuser_<wbr>modif=
y_local(sh, key, seuser)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SEUser&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing seuser...&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing seuser...&q=
uot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_seuser_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SEUser&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Seuser=
 delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Seuser=
 delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting seuser...&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting seuser...&=
quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_seuser_<wbr>modify_local(sh, key, old_seuser)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test SEUser&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Seuser=
 modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Seuser=
 modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_seuser_key_<wbr>free(ke=
y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_seuser_free(<wbr>seuser=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_seuser_fr=
ee(<wbr>old_seuser)<br>
<br>
-=C2=A0 =C2=A0 def test_writeport(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing port write...&quot;<br>
+=C2=A0 =C2=A0 def test_writeport(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing port write...&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, port) =3D semanage.semanage_port=
_create(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEPort object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEPort object create=
d.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEPort object create=
d.&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage.semanage_port_set_<wbr>range(port,150=
,200)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage.semanage_port_set_<wbr>range(port, 15=
0, 200)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0low =3D semanage.semanage_port_get_<wbr>l=
ow(port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high =3D semanage.semanage_port_get_<wbr>=
high(port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEPort range set: &q=
uot;, low, &quot;-&quot;, high<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEPort range set: %s=
-%s&quot; % (low, high))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_port_set_<wbr>proto(por=
t, semanage.SEMANAGE_PROTO_TCP)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEPort protocol set:=
 &quot;, semanage.semanage_port_get_<wbr>proto_str(semanage.SEMANAGE_<wbr>P=
ROTO_TCP)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEPort protocol set:=
 %s&quot; % semanage.semanage_port_get_<wbr>proto_str(semanage.SEMANAGE_<wb=
r>PROTO_TCP))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, con) =3D semanage.semanage_conte=
xt_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEContext object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext object cre=
ated (for port).&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext object cre=
ated (for port).&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>user(sh, con, &quot;system_u&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext user: &quo=
t;, semanage.semanage_context_get_<wbr>user(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext user: %s&q=
uot; % semanage.semanage_context_get_<wbr>user(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>role(sh, con, &quot;object_r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context role&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext role: &quo=
t;, semanage.semanage_context_get_<wbr>role(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext role: %s&q=
uot; % semanage.semanage_context_get_<wbr>role(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>type(sh, con, &quot;http_port_t&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context type&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext type: &quo=
t;, semanage.semanage_context_get_<wbr>type(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext type: %s&q=
uot; % semanage.semanage_context_get_<wbr>type(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>mls(sh, con, &quot;s0:c0.c255&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context MLS fields&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext mls: &quot=
;, semanage.semanage_context_get_<wbr>mls(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext mls: %s&qu=
ot; % semanage.semanage_context_get_<wbr>mls(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_port_set_<wb=
r>con(sh, port, con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SEPort context&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEPort context set: =
&quot;, con<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEPort context set: =
%s&quot; % con)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_port_key_<w=
br>extract(sh,port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_port_key_<=
wbr>extract(sh, port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SEPort key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEPort key extracted=
: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEPort key extracted=
: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_port_exi=
sts_<wbr>local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_port_ex=
ists_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SEPort exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_port) =3D sema=
nage.semanage_port_query_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SEPort&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_port_modify_<wbr>=
local(sh,key,port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_port_modify_<wbr>=
local(sh, key, port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SEPort&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing port range.=
..&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing port range.=
..&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_port_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SEPort&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Port r=
ange delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Port r=
ange delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting port range=
...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting port range=
...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_port_modify_<wbr>local(sh, key, old_port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test SEPort&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Port r=
ange modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Port r=
ange modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_context_<wbr>free(con)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_port_key_<wbr>free(key)=
<br>
@@ -648,118 +681,118 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_port_free=
(<wbr>old_port)<br>
<br>
-=C2=A0 =C2=A0 def test_writefcontext(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing file context write...&quot=
;<br>
+=C2=A0 =C2=A0 def test_writefcontext(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing file context write...&quot=
;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, fcon) =3D semanage.semanage_fcon=
text_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEFcontext object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEFcontext object cr=
eated.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEFcontext object cr=
eated.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_fcontext_<wb=
r>set_expr(sh, fcon, &quot;/test/fcontext(/.*)?&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set expression&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEFContext expr set:=
 &quot;, semanage.semanage_fcontext_<wbr>get_expr(fcon)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEFContext expr set:=
 %s&quot; % semanage.semanage_fcontext_<wbr>get_expr(fcon))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_fcontext_<wbr>set_type(=
fcon, semanage.SEMANAGE_FCONTEXT_<wbr>REG)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ftype =3D semanage.semanage=
_fcontext_<wbr>get_type(fcon)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEFContext type set:=
 &quot;, semanage.semanage_fcontext_<wbr>get_type_str(ftype)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEFContext type set:=
 %s&quot; % semanage.semanage_fcontext_<wbr>get_type_str(ftype))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, con) =3D semanage.semanage_conte=
xt_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEContext object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext object cre=
ated (for file context).&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext object cre=
ated (for file context).&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>user(sh, con, &quot;system_u&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext user: &quo=
t;, semanage.semanage_context_get_<wbr>user(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext user: %s&q=
uot; % semanage.semanage_context_get_<wbr>user(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>role(sh, con, &quot;object_r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context role&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext role: &quo=
t;, semanage.semanage_context_get_<wbr>role(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext role: %s&q=
uot; % semanage.semanage_context_get_<wbr>role(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>type(sh, con, &quot;default_t&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context type&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext type: &quo=
t;, semanage.semanage_context_get_<wbr>type(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext type: %s&q=
uot; % semanage.semanage_context_get_<wbr>type(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>mls(sh, con, &quot;s0:c0.c255&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context MLS fields&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext mls: &quot=
;, semanage.semanage_context_get_<wbr>mls(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext mls: %s&qu=
ot; % semanage.semanage_context_get_<wbr>mls(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_fcontext_<wb=
r>set_con(sh, fcon, con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SEFcontext context&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEFcontext context s=
et: &quot;, con<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEFcontext context s=
et: %s&quot; % con)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_fcontext_<w=
br>key_extract(sh,fcon)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_fcontext_<=
wbr>key_extract(sh, fcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SEFcontext key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEFcontext key extra=
cted: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEFcontext key extra=
cted: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_fcontext=
_<wbr>exists_local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_fcontex=
t_<wbr>exists_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SEFcontext exists&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_fcontext) =3D =
semanage.semanage_fcontext_<wbr>query_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SEFcontext&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_fcontext_<wbr>mod=
ify_local(sh,key,fcon)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_fcontext_<wbr>mod=
ify_local(sh, key, fcon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SEFcontext&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing file contex=
t...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing file contex=
t...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_fcontext_<wbr>del_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SEFcontext&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;File c=
ontext delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;File c=
ontext delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting file conte=
xt...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting file conte=
xt...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_fcontext_<wbr>modify_local(sh, key, old_fcontext)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test FContext&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;File c=
ontext modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;File c=
ontext modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_context_<wbr>free(con)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_fcontext_<wbr>key_free(=
key)<br>
@@ -767,119 +800,119 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_fcontext_=
<wbr>free(old_fcontext)<br>
<br>
-=C2=A0 =C2=A0 def test_writeinterface(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing network interface write...=
&quot;<br>
+=C2=A0 =C2=A0 def test_writeinterface(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing network interface write...=
&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, iface) =3D semanage.semanage_ifa=
ce_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEIface object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEIface object creat=
ed.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEIface object creat=
ed.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_iface_set_<w=
br>name(sh, iface, &quot;test_iface&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SEIface name&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEIface name set: &q=
uot;, semanage.semanage_iface_get_<wbr>name(iface)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEIface name set: %s=
&quot; % semanage.semanage_iface_get_<wbr>name(iface))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, con) =3D semanage.semanage_conte=
xt_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEContext object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext object cre=
ated (for network interface)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext object cre=
ated (for network interface)&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>user(sh, con, &quot;system_u&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set interface context user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext user: &quo=
t;, semanage.semanage_context_get_<wbr>user(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext user: %s&q=
uot; % semanage.semanage_context_get_<wbr>user(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>role(sh, con, &quot;object_r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set interface context role&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext role: &quo=
t;, semanage.semanage_context_get_<wbr>role(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext role: %s&q=
uot; % semanage.semanage_context_get_<wbr>role(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>type(sh, con, &quot;default_t&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set interface context type&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext type: &quo=
t;, semanage.semanage_context_get_<wbr>type(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext type: %s&q=
uot; % semanage.semanage_context_get_<wbr>type(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>mls(sh, con, &quot;s0:c0.c255&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set interface context MLS fields&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext mls: &quot=
;, semanage.semanage_context_get_<wbr>mls(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext mls: %s&qu=
ot; % semanage.semanage_context_get_<wbr>mls(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_iface_set_<w=
br>ifcon(sh, iface, con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SEIface interface context&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEIface interface co=
ntext set: &quot;, con<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEIface interface co=
ntext set: %s&quot; % con)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_iface_set_<w=
br>msgcon(sh, iface, con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SEIface message context&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEIface message cont=
ext set: &quot;, con<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEIface message cont=
ext set: %s&quot; % con)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_iface_key_<=
wbr>extract(sh,iface)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_iface_key_=
<wbr>extract(sh, iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SEIface key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEIface key extracte=
d: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEIface key extracte=
d: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_iface_<w=
br>exists_local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_iface_<=
wbr>exists_local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SEIface exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_iface) =3D sem=
anage.semanage_iface_query_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SEIface&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 begin semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_iface_<wbr>modify=
_local(sh,key,iface)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_iface_<wbr>modify=
_local(sh, key, iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SEIface&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 begin semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing interface..=
.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing interface..=
.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_iface_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SEIface&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Interf=
ace delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Interf=
ace delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting interface.=
..&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting interface.=
..&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_iface_<wbr>modify_local(sh, key, old_iface)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test SEIface&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Interf=
ace modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Interf=
ace modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_context_<wbr>free(con)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_iface_key_<wbr>free(key=
)<br>
@@ -887,45 +920,45 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_iface_fre=
e(<wbr>old_iface)<br>
<br>
-=C2=A0 =C2=A0 def test_writeboolean(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing boolean write...&quot;<br>
+=C2=A0 =C2=A0 def test_writeboolean(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing boolean write...&quot;)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, pbool) =3D semanage.semanage_boo=
l_create(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEBool object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool object create=
d.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool object create=
d.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_bool_set_<wb=
r>name(sh, pbool, &quot;allow_execmem&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set name&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool name set: &qu=
ot;, semanage.semanage_bool_get_<wbr>name(pbool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool name set: %s&=
quot; % semanage.semanage_bool_get_<wbr>name(pbool))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_set_<wbr>value(pbo=
ol, 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEbool value set: &q=
uot;, semanage.semanage_bool_get_<wbr>value(pbool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEbool value set: %s=
&quot; % semanage.semanage_bool_get_<wbr>value(pbool))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_bool_key_<w=
br>extract(sh, pbool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_bool_key_<=
wbr>extract(sh, pbool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SEBool key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool key extracted=
: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool key extracted=
: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_bool_exi=
sts_<wbr>local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_bool_ex=
ists_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SEBool exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_bool) =3D sema=
nage.semanage_bool_query_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SEBool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
@@ -938,110 +971,110 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing boolean...&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing boolean...&=
quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_bool_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SEBool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Boolea=
n delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Boolea=
n delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting boolean...=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting boolean...=
&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_bool_modify_<wbr>local(sh, key, old_bool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test SEBool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Boolea=
n modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Boolea=
n modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_key_<wbr>free(key)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_free(<wbr>pbool)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if exists: semanage.semanage_bool_free(<wbr>ol=
d_bool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if exists:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage.semanage_bool_free(<wbr=
>old_bool)<br>
<br>
-=C2=A0 =C2=A0 def test_writeaboolean(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing active boolean write...&qu=
ot;<br>
+=C2=A0 =C2=A0 def test_writeaboolean(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing active boolean write...&qu=
ot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, key) =3D semanage.semanage_bool_=
key_<wbr>create(sh, &quot;allow_execmem&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEBool key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool key created: =
&quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool key created: =
%s&quot; % key)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_bool) =3D semanage.semanage_=
bool_query_<wbr>active(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 query old SEBool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query status (commit=
 number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query status (commit=
 number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, abool) =3D semanage.semanage_boo=
l_create(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEBool object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool object create=
d.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool object create=
d.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_bool_set_<wb=
r>name(sh, abool, &quot;allow_execmem&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set name&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool name set: &qu=
ot;, semanage.semanage_bool_get_<wbr>name(abool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool name set: %s&=
quot; % semanage.semanage_bool_get_<wbr>name(abool))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_set_<wbr>value(abo=
ol, 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEbool value set: &q=
uot;, semanage.semanage_bool_get_<wbr>value(abool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEbool value set: %s=
&quot; % semanage.semanage_bool_get_<wbr>value(abool))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_bool_set_<wbr>act=
ive(sh,key,abool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_bool_set_<wbr>act=
ive(sh, key, abool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SEBool&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting old active boolean...&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting old active boolean...&qu=
ot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_bool_set_<wbr>act=
ive(sh, key,old_bool)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_bool_set_<wbr>act=
ive(sh, key, old_bool)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 reset test SEBool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEBool active reset:=
 &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEBool active reset:=
 %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_key_<wbr>free(key)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_free(<wbr>abool)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_bool_free(<wbr>old_bool=
)<br>
<br>
-<br>
-=C2=A0 =C2=A0 def test_writenode(self,sh):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Testing network node write...&quot=
;<br>
+=C2=A0 =C2=A0 def test_writenode(self, sh):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Testing network node write...&quot=
;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, node) =3D semanage.semanage_node=
_create(<wbr>sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SENode object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SENode object create=
d.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SENode object create=
d.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_node_set_<wb=
r>addr(sh, node, semanage.SEMANAGE_PROTO_IP6, &quot;ffee:dddd::bbbb&quot;)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
@@ -1053,100 +1086,100 @@ class Tests:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_node_set_<wbr>proto(nod=
e, semanage.SEMANAGE_PROTO_IP6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SENode protocol set:=
 &quot;, semanage.semanage_node_get_<wbr>proto_str(semanage.SEMANAGE_<wbr>P=
ROTO_IP6)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SENode protocol set:=
 %s&quot; % semanage.semanage_node_get_<wbr>proto_str(semanage.SEMANAGE_<wb=
r>PROTO_IP6))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, con) =3D semanage.semanage_conte=
xt_<wbr>create(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 create SEContext object&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext object cre=
ated (for node).&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext object cre=
ated (for node).&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>user(sh, con, &quot;system_u&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context user&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext user: &quo=
t;, semanage.semanage_context_get_<wbr>user(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext user: %s&q=
uot; % semanage.semanage_context_get_<wbr>user(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>role(sh, con, &quot;object_r&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context role&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext role: &quo=
t;, semanage.semanage_context_get_<wbr>role(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext role: %s&q=
uot; % semanage.semanage_context_get_<wbr>role(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>type(sh, con, &quot;lo_node_t&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context type&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext type: &quo=
t;, semanage.semanage_context_get_<wbr>type(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext type: %s&q=
uot; % semanage.semanage_context_get_<wbr>type(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_context_set_=
<wbr>mls(sh, con, &quot;s0:c0.c255&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set context MLS fields&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SEContext mls: &quot=
;, semanage.semanage_context_get_<wbr>mls(con)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SEContext mls: %s&qu=
ot; % semanage.semanage_context_get_<wbr>mls(con))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_node_set_<wb=
r>con(sh, node, con)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 set SENode context&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SENode context set: =
&quot;, con<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SENode context set: =
%s&quot; % con)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,key) =3D semanage.semanage_node_key_<w=
br>extract(sh, node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, key) =3D semanage.semanage_node_key_<=
wbr>extract(sh, node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 extract SENode key&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;SENode key extracted=
: &quot;, key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;SENode key extracted=
: %s&quot; % key)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status,exists) =3D semanage.semanage_node_exi=
sts_<wbr>local(sh,key)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (status, exists) =3D semanage.semanage_node_ex=
ists_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 check if SENode exists&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Exists status (commi=
t number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Exists status (commi=
t number): %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(status, old_node) =3D sema=
nage.semanage_node_query_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not query old SENode&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Query =
status (commit number): &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Query =
status (commit number): %s&quot; % status)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Starting transaction...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Starting transaction...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_node_modify_<wbr>=
local(sh,key, node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D semanage.semanage_node_modify_<wbr>=
local(sh, key, node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 modify SENode&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit test transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_begin_<wbr>t=
ransaction(sh)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 start semanage transaction&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not exists:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Removing network nod=
e...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing network nod=
e...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_node_del_<wbr>local(sh, key)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not delete test SENode&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Networ=
k node delete: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Networ=
k node delete: %s&quot; % status)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Resetting network no=
de...&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Resetting network no=
de...&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanag=
e_node_modify_<wbr>local(sh, key, old_node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&=
quot;Could not reset test SENode&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Networ=
k node modify: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Networ=
k node modify: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_commit(sh)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if status &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Error(&quot;Could not=
 commit reset transaction&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &quot;Commit status (transaction number)=
: &quot;, status<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Commit status (transaction number)=
: %s&quot; % status)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_context_<wbr>free(con)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_node_key_<wbr>free(key)=
<br>
@@ -1154,17 +1187,41 @@ class Tests:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if exists:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_node_free=
(<wbr>old_node)<br>
<br>
+<br>
=C2=A0def main(argv=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0if argv is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv =3D sys.argv<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts, args =3D getopt.getopt(arg=
v[1:], &quot;hvmuspfibcUSPFIBCanN&quot;, [&quot;help&quot;, &quot;verbose&q=
uot;, &quot;modules&quot;, &quot;users&quot;, &quot;seusers&quot;, &quot;po=
rts&quot;, &quot;file contexts&quot;, &quot;network interfaces&quot;, &quot=
;booleans&quot;, &quot;active booleans&quot;, &quot;network nodes&quot;, &q=
uot;writeuser&quot;, &quot;writeseuser&quot;, &quot;writeport&quot;, &quot;=
writefcontext&quot;, &quot;writeinterface&quot;, &quot;writeboolean&quot;, =
&quot;writeaboolean&quot;, &quot;writenode&quot;, &quot;all&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts, args =3D getopt.getopt(<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[1:], &quot;hv=
muspfibcUSPFIBCanN&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;help&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;verbose&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;modules&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;users&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;seusers&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;ports&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;file contexts&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;network interfaces&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;booleans&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;active booleans&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;network nodes&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeuser&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeseuser&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeport&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writefcontext&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeinterface&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeboolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writeaboolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;writenode&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;all&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests =3D Tests()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for o, a in opts:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if o =3D=3D &=
quot;-v&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tests.verbose =3D True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t &quot;Verbose output selected.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t(&quot;Verbose output selected.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if o =3D=3D &=
quot;-a&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tests.all =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if o =3D=3D &=
quot;-u&quot;:<br>
@@ -1207,12 +1264,12 @@ def main(argv=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not tests.selected():<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Usage(&=
quot;Please select a valid test.&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except getopt.error, msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except getopt.error as msg:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Usage(msg)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sh=3Dsemanage.semanage_handle_<wbr>create()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sh =3D semanage.semanage_handle_<wbr>create()<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (semanage.semanage_is_managed(<wbr>sh) !=3D=
 1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if semanage.semanage_is_managed(<wbr>sh) !=3D =
1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Status(&quot;Unmanage=
d!&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D semanage.semanage_connect(sh)<=
br>
@@ -1227,14 +1284,15 @@ def main(argv=3DNone):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0semanage.semanage_handle_<wbr>destroy(sh)=
<br>
<br>
-=C2=A0 =C2=A0 except Usage, err:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &gt;&gt;sys.stderr, err.msg<br>
-=C2=A0 =C2=A0 except Status, err:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &gt;&gt;sys.stderr, err.msg<br>
-=C2=A0 =C2=A0 except Error, err:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print &gt;&gt;sys.stderr, err.msg<br>
+=C2=A0 =C2=A0 except Usage as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(err.msg, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 except Status as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(err.msg, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 except Error as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(err.msg, file=3Dsys.stderr)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 2<br>
<br>
+<br>
=C2=A0if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(main())<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.18.0<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br></div>

--0000000000008658b50573ba0df5--
