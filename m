Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7IIi4NR019910
 for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2018 14:44:04 -0400
Received: by mail-oi0-f44.google.com with SMTP id v8-v6so19459035oie.5
 for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2018 11:43:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180818175033.13100-1-nicolas.iooss@m4x.org>
References: <20180818175033.13100-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sat, 18 Aug 2018 11:43:53 -0700
Message-ID: <CAFftDdoyK+RL26yNcfgOuv+Z6gWOjxJfTVSCDuNb6u527V8Whg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000e0014b0573ba0e8d"
Subject: Re: [PATCH 1/2] libsemanage: reindent pywrap-test.py with
 spaces
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000e0014b0573ba0e8d
Content-Type: text/plain; charset="UTF-8"

Ack applies and runs

On Sat, Aug 18, 2018 at 10:50 AM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> Only use spaces to indent Python code. This reduces the number of
> warnings reported by Python linters.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/pywrap-test.py | 2301 +++++++++++++++++---------------
>  1 file changed, 1200 insertions(+), 1101 deletions(-)
>
> diff --git a/libsemanage/src/pywrap-test.py b/libsemanage/src/pywrap-test.
> py
> index 25b668d80b67..326034947aa5 100644
> --- a/libsemanage/src/pywrap-test.py
> +++ b/libsemanage/src/pywrap-test.py
> @@ -28,1114 +28,1213 @@ Other options:\n\
>  "
>
>  class Usage(Exception):
> -       def __init__(self, msg):
> -               Exception.__init__(self)
> -               self.msg = msg
> +    def __init__(self, msg):
> +        Exception.__init__(self)
> +        self.msg = msg
>
>  class Status(Exception):
> -       def __init__(self, msg):
> -               Exception.__init__(self)
> -               self.msg = msg
> +    def __init__(self, msg):
> +        Exception.__init__(self)
> +        self.msg = msg
>
>  class Error(Exception):
> -       def __init__(self, msg):
> -               Exception.__init__(self)
> -               self.msg = msg
> +    def __init__(self, msg):
> +        Exception.__init__(self)
> +        self.msg = msg
>
>  class Tests:
> -       def __init__(self):
> -               self.all = False
> -               self.users = False
> -               self.writeuser = False
> -               self.seusers = False
> -               self.writeseuser = False
> -               self.ports = False
> -               self.writeport = False
> -               self.fcontexts = False
> -               self.writefcontext = False
> -               self.interfaces = False
> -               self.writeinterface = False
> -               self.booleans = False
> -               self.writeboolean = False
> -               self.abooleans = False
> -               self.writeaboolean = False
> -               self.nodes = False
> -               self.writenode = False
> -               self.modules = False
> -               self.verbose = False
> -
> -       def selected(self):
> -               return (self.all or self.users or self.modules or
> self.seusers or self.ports or self.fcontexts or self.interfaces or
> self.booleans or self.abooleans or self.writeuser or self.writeseuser or
> self.writeport or self.writefcontext or self.writeinterface or
> self.writeboolean or self.writeaboolean or self.nodes or self.writenode)
> -
> -       def run(self, handle):
> -               if (self.users or self.all):
> -                       self.test_users(handle)
> -                       print ""
> -               if (self.seusers or self.all):
> -                       self.test_seusers(handle)
> -                       print ""
> -               if (self.ports or self.all):
> -                       self.test_ports(handle)
> -                       print ""
> -               if (self.modules or self.all):
> -                       self.test_modules(handle)
> -                       print ""
> -               if (self.fcontexts or self.all):
> -                       self.test_fcontexts(handle)
> -                       print ""
> -               if (self.interfaces or self.all):
> -                       self.test_interfaces(handle)
> -                       print ""
> -               if (self.booleans or self.all):
> -                       self.test_booleans(handle)
> -                       print ""
> -               if (self.abooleans or self.all):
> -                       self.test_abooleans(handle)
> -                       print ""
> -               if (self.nodes or self.all):
> -                       self.test_nodes(handle)
> -                       print ""
> -               if (self.writeuser or self.all):
> -                       self.test_writeuser(handle)
> -                       print ""
> -               if (self.writeseuser or self.all):
> -                       self.test_writeseuser(handle)
> -                       print ""
> -               if (self.writeport or self.all):
> -                       self.test_writeport(handle)
> -                       print ""
> -               if (self.writefcontext or self.all):
> -                       self.test_writefcontext(handle)
> -                       print ""
> -               if (self.writeinterface or self.all):
> -                       self.test_writeinterface(handle)
> -                       print ""
> -               if (self.writeboolean or self.all):
> -                       self.test_writeboolean(handle)
> -                       print ""
> -               if (self.writeaboolean or self.all):
> -                       self.test_writeaboolean(handle)
> -                       print ""
> -               if (self.writenode or self.all):
> -                       self.test_writenode(handle)
> -                       print ""
> -
> -       def test_modules(self,sh):
> -               print "Testing modules..."
> -
> -               (trans_cnt, mlist, mlist_size) =
> semanage.semanage_module_list(sh)
> -
> -               print "Transaction number: ", trans_cnt
> -               print "Module list size: ", mlist_size
> -               if self.verbose: print "List reference: ", mlist
> -
> -               if (mlist_size == 0):
> -                       print "No modules installed!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for idx in range(mlist_size):
> -                       module = semanage.semanage_module_list_nth(mlist,
> idx)
> -                       if self.verbose: print "Module reference: ", module
> -                       print "Module name: ",
> semanage.semanage_module_get_name(module)
> -
> -       def test_seusers(self,sh):
> -               print "Testing seusers..."
> -
> -               (status, slist) = semanage.semanage_seuser_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list seusers")
> -               print "Query status (commit number): ", status
> -
> -               if ( len(slist) == 0):
> -                       print "No seusers found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for seuser in slist:
> -                       if self.verbose: print "seseuser reference: ",
> seuser
> -                       print "seuser name: ",
> semanage.semanage_seuser_get_name(seuser)
> -                       print "   seuser mls range: ",
> semanage.semanage_seuser_get_mlsrange(seuser)
> -                       print "   seuser sename: ",
> semanage.semanage_seuser_get_sename(seuser)
> -                       semanage.semanage_seuser_free(seuser)
> -
> -       def test_users(self,sh):
> -               print "Testing users..."
> -
> -               (status, ulist) = semanage.semanage_user_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list users")
> -               print "Query status (commit number): ", status
> -
> -               if ( len(ulist) == 0):
> -                       print "No users found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for user in ulist:
> -                       if self.verbose: print "User reference: ", user
> -                       print "User name: ", semanage.semanage_user_get_
> name(user)
> -                       print "   User labeling prefix: ",
> semanage.semanage_user_get_prefix(user)
> -                       print "   User mls level: ",
> semanage.semanage_user_get_mlslevel(user)
> -                       print "   User mls range: ",
> semanage.semanage_user_get_mlsrange(user)
> -                       print "   User number of roles: ",
> semanage.semanage_user_get_num_roles(user)
> -                       print "   User roles: "
> -                       (status, rlist) = semanage.semanage_user_get_roles(sh,
> user)
> -                       if status < 0:
> -                               raise Error("Could not get user roles")
> -
> -                       for role in rlist:
> -                               print "      ", role
> -
> -                       semanage.semanage_user_free(user)
> -
> -       def test_ports(self,sh):
> -               print "Testing ports..."
> -
> -               (status, plist) = semanage.semanage_port_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list ports")
> -               print "Query status (commit number): ", status
> -
> -               if ( len(plist) == 0):
> -                       print "No ports found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for port in plist:
> -                       if self.verbose: print "Port reference: ", port
> -                       low = semanage.semanage_port_get_low(port)
> -                       high = semanage.semanage_port_get_high(port)
> -                       con = semanage.semanage_port_get_con(port)
> -                       proto = semanage.semanage_port_get_proto(port)
> -                       proto_str = semanage.semanage_port_get_
> proto_str(proto)
> -                       if low == high:
> -                               range_str = str(low)
> -                       else:
> -                               range_str = str(low) + "-" + str(high)
> -                       (rc, con_str) = semanage.semanage_context_to_
> string(sh,con)
> -                       if rc < 0: con_str = ""
> -                       print "Port: ", range_str, " ", proto_str, "
> Context: ", con_str
> -                       semanage.semanage_port_free(port)
> -
> -       def test_fcontexts(self,sh):
> -               print "Testing file contexts..."
> -
> -               (status, flist) = semanage.semanage_fcontext_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list file contexts")
> -               print "Query status (commit number): ", status
> -
> -               if (len(flist) == 0):
> -                       print "No file contexts found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for fcon in flist:
> -                       if self.verbose: print "File Context reference: ",
> fcon
> -                       expr = semanage.semanage_fcontext_get_expr(fcon)
> -                       type = semanage.semanage_fcontext_get_type(fcon)
> -                       type_str = semanage.semanage_fcontext_
> get_type_str(type)
> -                       con = semanage.semanage_fcontext_get_con(fcon)
> -                       if not con:
> -                               con_str = "<<none>>"
> -                       else:
> -                               (rc, con_str) =
> semanage.semanage_context_to_string(sh,con)
> -                               if rc < 0: con_str = ""
> -                       print "File Expr: ", expr, " [", type_str, "]
> Context: ", con_str
> -                       semanage.semanage_fcontext_free(fcon)
> -
> -       def test_interfaces(self,sh):
> -               print "Testing network interfaces..."
> -
> -               (status, ilist) = semanage.semanage_iface_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list interfaces")
> -               print "Query status (commit number): ", status
> -
> -               if (len(ilist) == 0):
> -                       print "No network interfaces found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for iface in ilist:
> -                       if self.verbose: print "Interface reference: ",
> iface
> -                       name = semanage.semanage_iface_get_name(iface)
> -                       msg_con = semanage.semanage_iface_get_
> msgcon(iface)
> -                       if_con = semanage.semanage_iface_get_ifcon(iface)
> -                       (rc, msg_con_str) = semanage.semanage_context_to_
> string(sh,msg_con)
> -                       if rc < 0: msg_con_str = ""
> -                       (rc, if_con_str) = semanage.semanage_context_to_string(sh,
> if_con)
> -                       if rc < 0: if_con_str = ""
> -                       print "Interface: ", name, " Context: ",
> if_con_str, " Message Context: ", msg_con_str
> -                       semanage.semanage_iface_free(iface)
> -
> -       def test_booleans(self,sh):
> -               print "Testing booleans..."
> -
> -               (status, blist) = semanage.semanage_bool_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list booleans")
> -               print "Query status (commit number): ", status
> -
> -               if (len(blist) == 0):
> -                       print "No booleans found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for pbool in blist:
> -                       if self.verbose: print "Boolean reference: ", pbool
> -                       name = semanage.semanage_bool_get_name(pbool)
> -                       value = semanage.semanage_bool_get_value(pbool)
> -                       print "Boolean: ", name, " Value: ", value
> -                       semanage.semanage_bool_free(pbool)
> -
> -       def test_abooleans(self,sh):
> -               print "Testing active booleans..."
> -
> -               (status, ablist) = semanage.semanage_bool_list_active(sh)
> -               if status < 0:
> -                       raise Error("Could not list active booleans")
> -               print "Query status (commit number): ", status
> -
> -               if (len(ablist) == 0):
> -                        print "No active booleans found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for abool in ablist:
> -                       if self.verbose: print "Active boolean reference:
> ", abool
> -                       name = semanage.semanage_bool_get_name(abool)
> -                       value = semanage.semanage_bool_get_value(abool)
> -                       print "Active Boolean: ", name, " Value: ", value
> -                       semanage.semanage_bool_free(abool)
> -
> -       def test_nodes(self,sh):
> -               print "Testing network nodes..."
> -
> -               (status, nlist) = semanage.semanage_node_list(sh)
> -               if status < 0:
> -                       raise Error("Could not list network nodes")
> -               print "Query status (commit number): ", status
> -
> -               if (len(nlist) == 0):
> -                       print "No network nodes found!"
> -                       print "This is not necessarily a test failure."
> -                       return
> -               for node in nlist:
> -                       if self.verbose: print "Network node reference: ",
> node
> -
> -                       (status, addr) = semanage.semanage_node_get_addr(sh,
> node)
> -                       if status < 0: addr = ""
> -
> -                       (status, mask) = semanage.semanage_node_get_mask(sh,
> node)
> -                       if status < 0: mask = ""
> -
> -                       proto = semanage.semanage_node_get_proto(node)
> -                       proto_str = semanage.semanage_node_get_proto_str(proto)
>
> -                       con = semanage.semanage_node_get_con(node)
> -
> -                       (status, con_str) = semanage.semanage_context_to_string(sh,
> con)
> -                       if status < 0: con_str = ""
> -
> -                       print "Network Node: ", addr, "/", mask, " (",
> proto_str, ")", "Context: ", con_str
> -                       semanage.semanage_node_free(node)
> -
> -       def test_writeuser(self,sh):
> -               print "Testing user write..."
> -
> -               (status, user) = semanage.semanage_user_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create user object")
> -               if self.verbose: print "User object created"
> -
> -               status = semanage.semanage_user_set_name(sh,user,
> "testPyUser")
> -               if status < 0:
> -                       raise Error("Could not set user name")
> -               if self.verbose: print "User name set: ",
> semanage.semanage_user_get_name(user)
> -
> -               status = semanage.semanage_user_add_role(sh, user,
> "user_r")
> -               if status < 0:
> -                       raise Error("Could not add role")
> -
> -               status = semanage.semanage_user_set_prefix(sh,user,
> "user")
> -               if status < 0:
> -                       raise Error("Could not set labeling prefix")
> -               if self.verbose: print "User prefix set: ",
> semanage.semanage_user_get_prefix(user)
> -
> -               status = semanage.semanage_user_set_mlsrange(sh, user,
> "s0")
> -               if status < 0:
> -                       raise Error("Could not set MLS range")
> -               if self.verbose: print "User mlsrange: ",
> semanage.semanage_user_get_mlsrange(user)
> -
> -               status = semanage.semanage_user_set_mlslevel(sh, user,
> "s0")
> -               if status < 0:
> -                       raise Error("Could not set MLS level")
> -               if self.verbose: print "User mlslevel: ",
> semanage.semanage_user_get_mlslevel(user)
> -
> -               (status,key) = semanage.semanage_user_key_extract(sh,user)
> -               if status < 0:
> -                       raise Error("Could not extract user key")
> -               if self.verbose: print "User key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_user_exists_
> local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if user exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_user) = semanage.semanage_user_query_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not query old user")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction.."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_user_modify_local(sh,key,user)
> -               if status < 0:
> -                       raise Error("Could not modify user")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing user..."
> -                       status = semanage.semanage_user_del_local(sh, key)
> -                       if status < 0:
> -                               raise Error("Could not delete test user")
> -                       if self.verbose: print "User delete: ", status
> -               else:
> -                       print "Resetting user..."
> -                       status = semanage.semanage_user_modify_local(sh,
> key, old_user)
> -                       if status < 0:
> -                               raise Error("Could not reset test user")
> -                       if self.verbose: print "User modify: ", status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_user_key_free(key)
> -               semanage.semanage_user_free(user)
> -               if exists: semanage.semanage_user_free(old_user)
> -
> -       def test_writeseuser(self,sh):
> -                print "Testing seuser write..."
> -
> -               (status, seuser) = semanage.semanage_seuser_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEUser object")
> -               if self.verbose: print "SEUser object created."
> -
> -               status = semanage.semanage_seuser_set_name(sh,seuser,
> "testPySEUser")
> -               if status < 0:
> -                       raise Error("Could not set name")
> -               if self.verbose: print "SEUser name set: ",
> semanage.semanage_seuser_get_name(seuser)
> -
> -               status = semanage.semanage_seuser_set_sename(sh, seuser,
> "root")
> -               if status < 0:
> -                       raise Error("Could not set sename")
> -                if self.verbose: print "SEUser seuser: ",
> semanage.semanage_seuser_get_sename(seuser)
> -
> -               status = semanage.semanage_seuser_set_mlsrange(sh,
> seuser, "s0:c0.c255")
> -               if status < 0:
> -                       raise Error("Could not set MLS range")
> -                if self.verbose: print "SEUser mlsrange: ",
> semanage.semanage_seuser_get_mlsrange(seuser)
> -
> -               (status,key) = semanage.semanage_seuser_key_
> extract(sh,seuser)
> -               if status < 0:
> -                       raise Error("Could not extract SEUser key")
> -                if self.verbose: print "SEUser key extracted: ", key
> -
> -                (status,exists) = semanage.semanage_seuser_
> exists_local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SEUser exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_seuser) = semanage.semanage_seuser_query_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not query old SEUser")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_seuser_
> modify_local(sh,key,seuser)
> -               if status < 0:
> -                       raise Error("Could not modify SEUser")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -                print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing seuser..."
> -                       status = semanage.semanage_seuser_del_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not delete test SEUser")
> -                       if self.verbose: print "Seuser delete: ", status
> -               else:
> -                       print "Resetting seuser..."
> -                       status = semanage.semanage_seuser_modify_local(sh,
> key, old_seuser)
> -                       if status < 0:
> -                               raise Error("Could not reset test SEUser")
> -                       if self.verbose: print "Seuser modify: ", status
> -
> -                status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -                print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_seuser_key_free(key)
> -               semanage.semanage_seuser_free(seuser)
> -               if exists: semanage.semanage_seuser_free(old_seuser)
> -
> -       def test_writeport(self,sh):
> -               print "Testing port write..."
> -
> -               (status, port) = semanage.semanage_port_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEPort object")
> -               if self.verbose: print "SEPort object created."
> -
> -               semanage.semanage_port_set_range(port,150,200)
> -               low = semanage.semanage_port_get_low(port)
> -               high = semanage.semanage_port_get_high(port)
> -               if self.verbose: print "SEPort range set: ", low, "-", high
> -
> -               semanage.semanage_port_set_proto(port,
> semanage.SEMANAGE_PROTO_TCP);
> -               if self.verbose: print "SEPort protocol set: ", \
> -                       semanage.semanage_port_get_
> proto_str(semanage.SEMANAGE_PROTO_TCP)
> -
> -               (status, con) = semanage.semanage_context_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEContext object")
> -               if self.verbose: print "SEContext object created (for
> port)."
> -
> -               status = semanage.semanage_context_set_user(sh, con,
> "system_u")
> -               if status < 0:
> -                       raise Error("Could not set context user")
> -               if self.verbose: print "SEContext user: ",
> semanage.semanage_context_get_user(con)
> -
> -               status = semanage.semanage_context_set_role(sh, con,
> "object_r")
> -               if status < 0:
> -                       raise Error("Could not set context role")
> -               if self.verbose: print "SEContext role: ",
> semanage.semanage_context_get_role(con)
> -
> -               status = semanage.semanage_context_set_type(sh, con,
> "http_port_t")
> -               if status < 0:
> -                       raise Error("Could not set context type")
> -               if self.verbose: print "SEContext type: ",
> semanage.semanage_context_get_type(con)
> -
> -               status = semanage.semanage_context_set_mls(sh, con,
> "s0:c0.c255")
> -               if status < 0:
> -                       raise Error("Could not set context MLS fields")
> -               if self.verbose: print "SEContext mls: ",
> semanage.semanage_context_get_mls(con)
> -
> -               status = semanage.semanage_port_set_con(sh, port, con)
> -               if status < 0:
> -                       raise Error("Could not set SEPort context")
> -               if self.verbose: print "SEPort context set: ", con
> -
> -                (status,key) = semanage.semanage_port_key_
> extract(sh,port)
> -               if status < 0:
> -                       raise Error("Could not extract SEPort key")
> -               if self.verbose: print "SEPort key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_port_exists_
> local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SEPort exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_port) = semanage.semanage_port_query_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not query old SEPort")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage
> transaction")
> -
> -               status = semanage.semanage_port_modify_local(sh,key,port)
> -               if status < 0:
> -                       raise Error("Could not modify SEPort")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing port range..."
> -                        status = semanage.semanage_port_del_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not delete test SEPort")
> -                        if self.verbose: print "Port range delete: ",
> status
> -                else:
> -                       print "Resetting port range..."
> -                       status = semanage.semanage_port_modify_local(sh,
> key, old_port)
> -                       if status < 0:
> -                               raise Error("Could not reset test SEPort")
> -                       if self.verbose: print "Port range modify: ",
> status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_context_free(con)
> -               semanage.semanage_port_key_free(key)
> -               semanage.semanage_port_free(port)
> -               if exists: semanage.semanage_port_free(old_port)
> -
> -       def test_writefcontext(self,sh):
> -               print "Testing file context write..."
> -
> -               (status, fcon) = semanage.semanage_fcontext_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEFcontext object")
> -               if self.verbose: print "SEFcontext object created."
> -
> -               status = semanage.semanage_fcontext_set_expr(sh, fcon,
> "/test/fcontext(/.*)?")
> -               if status < 0:
> -                       raise Error("Could not set expression")
> -               if self.verbose: print "SEFContext expr set: ",
> semanage.semanage_fcontext_get_expr(fcon)
> -
> -               semanage.semanage_fcontext_set_type(fcon,
> semanage.SEMANAGE_FCONTEXT_REG)
> -               if self.verbose:
> -                       ftype = semanage.semanage_fcontext_get_type(fcon)
> -                       print "SEFContext type set: ",
> semanage.semanage_fcontext_get_type_str(ftype)
> -
> -               (status, con) = semanage.semanage_context_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEContext object")
> -               if self.verbose: print "SEContext object created (for file
> context)."
> -
> -               status = semanage.semanage_context_set_user(sh, con,
> "system_u")
> -               if status < 0:
> -                       raise Error("Could not set context user")
> -               if self.verbose: print "SEContext user: ",
> semanage.semanage_context_get_user(con)
> -
> -               status = semanage.semanage_context_set_role(sh, con,
> "object_r")
> -               if status < 0:
> -                       raise Error("Could not set context role")
> -               if self.verbose: print "SEContext role: ",
> semanage.semanage_context_get_role(con)
> -
> -               status = semanage.semanage_context_set_type(sh, con,
> "default_t")
> -               if status < 0:
> -                       raise Error("Could not set context type")
> -               if self.verbose: print "SEContext type: ",
> semanage.semanage_context_get_type(con)
> -
> -               status = semanage.semanage_context_set_mls(sh, con,
> "s0:c0.c255")
> -               if status < 0:
> -                       raise Error("Could not set context MLS fields")
> -               if self.verbose: print "SEContext mls: ",
> semanage.semanage_context_get_mls(con)
> -
> -               status = semanage.semanage_fcontext_set_con(sh, fcon, con)
> -               if status < 0:
> -                       raise Error("Could not set SEFcontext context")
> -               if self.verbose: print "SEFcontext context set: ", con
> -
> -               (status,key) = semanage.semanage_fcontext_
> key_extract(sh,fcon)
> -               if status < 0:
> -                       raise Error("Could not extract SEFcontext key")
> -               if self.verbose: print "SEFcontext key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_fcontext_
> exists_local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SEFcontext exists")
> -
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -               if exists:
> -                       (status, old_fcontext) =
> semanage.semanage_fcontext_query_local(sh, key)
> -                       if status < 0:
> -                               raise Error("Could not query old
> SEFcontext")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_fcontext_
> modify_local(sh,key,fcon)
> -               if status < 0:
> -                       raise Error("Could not modify SEFcontext")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing file context..."
> -                       status = semanage.semanage_fcontext_del_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not delete test
> SEFcontext")
> -                       if self.verbose: print "File context delete: ",
> status
> -               else:
> -                       print "Resetting file context..."
> -                       status = semanage.semanage_fcontext_modify_local(sh,
> key, old_fcontext)
> -                       if status < 0:
> -                               raise Error("Could not reset test
> FContext")
> -                       if self.verbose: print "File context modify: ",
> status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_context_free(con)
> -               semanage.semanage_fcontext_key_free(key)
> -               semanage.semanage_fcontext_free(fcon)
> -               if exists: semanage.semanage_fcontext_free(old_fcontext)
> -
> -       def test_writeinterface(self,sh):
> -               print "Testing network interface write..."
> -
> -               (status, iface) = semanage.semanage_iface_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEIface object")
> -               if self.verbose: print "SEIface object created."
> -
> -               status = semanage.semanage_iface_set_name(sh, iface,
> "test_iface")
> -               if status < 0:
> -                       raise Error("Could not set SEIface name")
> -               if self.verbose: print "SEIface name set: ",
> semanage.semanage_iface_get_name(iface)
> -
> -               (status, con) = semanage.semanage_context_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEContext object")
> -               if self.verbose: print "SEContext object created (for
> network interface)"
> -
> -               status = semanage.semanage_context_set_user(sh, con,
> "system_u")
> -               if status < 0:
> -                       raise Error("Could not set interface context user")
> -               if self.verbose: print "SEContext user: ",
> semanage.semanage_context_get_user(con)
> -
> -               status = semanage.semanage_context_set_role(sh, con,
> "object_r")
> -               if status < 0:
> -                       raise Error("Could not set interface context role")
> -               if self.verbose: print "SEContext role: ",
> semanage.semanage_context_get_role(con)
> -
> -               status = semanage.semanage_context_set_type(sh, con,
> "default_t")
> -               if status < 0:
> -                       raise Error("Could not set interface context type")
> -               if self.verbose: print "SEContext type: ",
> semanage.semanage_context_get_type(con)
> -
> -               status = semanage.semanage_context_set_mls(sh, con,
> "s0:c0.c255")
> -               if status < 0:
> -                       raise Error("Could not set interface context MLS
> fields")
> -               if self.verbose: print "SEContext mls: ",
> semanage.semanage_context_get_mls(con)
> -
> -               status = semanage.semanage_iface_set_ifcon(sh, iface, con)
> -               if status < 0:
> -                       raise Error("Could not set SEIface interface
> context")
> -               if self.verbose: print "SEIface interface context set: ",
> con
> -
> -               status = semanage.semanage_iface_set_msgcon(sh, iface,
> con)
> -               if status < 0:
> -                       raise Error("Could not set SEIface message
> context")
> -               if self.verbose: print "SEIface message context set: ", con
> -
> -               (status,key) = semanage.semanage_iface_key_
> extract(sh,iface)
> -               if status < 0:
> -                       raise Error("Could not extract SEIface key")
> -               if self.verbose: print "SEIface key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_iface_
> exists_local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SEIface exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_iface) =
> semanage.semanage_iface_query_local(sh, key)
> -                       if status < 0:
> -                               raise Error("Could not query old SEIface")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not begin semanage transaction")
> -
> -               status = semanage.semanage_iface_
> modify_local(sh,key,iface)
> -               if status < 0:
> -                       raise Error("Could not modify SEIface")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not begin semanage transaction")
> -
> -               if not exists:
> -                       print "Removing interface..."
> -                       status = semanage.semanage_iface_del_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not delete test
> SEIface")
> -                       if self.verbose: print "Interface delete: ", status
> -               else:
> -                       print "Resetting interface..."
> -                       status = semanage.semanage_iface_modify_local(sh,
> key, old_iface)
> -                       if status < 0:
> -                               raise Error("Could not reset test SEIface")
> -                       if self.verbose: print "Interface modify: ", status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_context_free(con)
> -               semanage.semanage_iface_key_free(key)
> -               semanage.semanage_iface_free(iface)
> -               if exists: semanage.semanage_iface_free(old_iface)
> -
> -        def test_writeboolean(self,sh):
> -               print "Testing boolean write..."
> -
> -               (status, pbool) = semanage.semanage_bool_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEBool object")
> -               if self.verbose: print "SEBool object created."
> -
> -               status = semanage.semanage_bool_set_name(sh, pbool,
> "allow_execmem")
> -               if status < 0:
> -                       raise Error("Could not set name")
> -               if self.verbose: print "SEBool name set: ",
> semanage.semanage_bool_get_name(pbool)
> -
> -               semanage.semanage_bool_set_value(pbool, 0)
> -               if self.verbose: print "SEbool value set: ",
> semanage.semanage_bool_get_value(pbool)
> -
> -               (status,key) = semanage.semanage_bool_key_extract(sh,
> pbool)
> -               if status < 0:
> -                       raise Error("Could not extract SEBool key")
> -               if self.verbose: print "SEBool key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_bool_exists_
> local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SEBool exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_bool) = semanage.semanage_bool_query_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not query old SEBool")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_bool_modify_local(sh, key,
> pbool)
> -
> -               if status < 0:
> -                       raise Error("Could not modify SEBool")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing boolean..."
> -                       status = semanage.semanage_bool_del_local(sh, key)
> -                       if status < 0:
> -                               raise Error("Could not delete test SEBool")
> -                       if self.verbose: print "Boolean delete: ", status
> -               else:
> -                       print "Resetting boolean..."
> -                       status = semanage.semanage_bool_modify_local(sh,
> key, old_bool)
> -                       if status < 0:
> -                               raise Error("Could not reset test SEBool")
> -                       if self.verbose: print "Boolean modify: ", status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_bool_key_free(key)
> -               semanage.semanage_bool_free(pbool)
> -               if exists: semanage.semanage_bool_free(old_bool)
> -
> -       def test_writeaboolean(self,sh):
> -               print "Testing active boolean write..."
> -
> -               (status, key) = semanage.semanage_bool_key_create(sh,
> "allow_execmem")
> -               if status < 0:
> -                       raise Error("Could not create SEBool key")
> -               if self.verbose: print "SEBool key created: ", key
> -
> -               (status, old_bool) = semanage.semanage_bool_query_active(sh,
> key)
> -               if status < 0:
> -                       raise Error("Could not query old SEBool")
> -               if self.verbose: print "Query status (commit number): ",
> status
> -
> -               (status, abool) = semanage.semanage_bool_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEBool object")
> -               if self.verbose: print "SEBool object created."
> -
> -               status = semanage.semanage_bool_set_name(sh, abool,
> "allow_execmem")
> -               if status < 0:
> -                       raise Error("Could not set name")
> -               if self.verbose: print "SEBool name set: ",
> semanage.semanage_bool_get_name(abool)
> -
> -               semanage.semanage_bool_set_value(abool, 0)
> -               if self.verbose: print "SEbool value set: ",
> semanage.semanage_bool_get_value(abool)
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_bool_set_active(sh,key,abool)
> -               if status < 0:
> -                       raise Error("Could not modify SEBool")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               print "Resetting old active boolean..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               status = semanage.semanage_bool_set_active(sh,
> key,old_bool)
> -               if status < 0:
> -                       raise Error("Could not reset test SEBool")
> -               if self.verbose: print "SEBool active reset: ", status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_bool_key_free(key)
> -               semanage.semanage_bool_free(abool)
> -               semanage.semanage_bool_free(old_bool)
> -
> -
> -       def test_writenode(self,sh):
> -               print "Testing network node write..."
> -
> -               (status, node) = semanage.semanage_node_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SENode object")
> -               if self.verbose: print "SENode object created."
> -
> -               status = semanage.semanage_node_set_addr(sh, node,
> semanage.SEMANAGE_PROTO_IP6, "ffee:dddd::bbbb")
> -               if status < 0:
> -                       raise Error("Could not set SENode address")
> -
> -               status = semanage.semanage_node_set_mask(sh, node,
> semanage.SEMANAGE_PROTO_IP6, "::ffff:ffff:abcd:0000")
> -               if status < 0:
> -                       raise Error("Could not set SENode netmask")
> -
> -               semanage.semanage_node_set_proto(node,
> semanage.SEMANAGE_PROTO_IP6);
> -               if self.verbose: print "SENode protocol set: ", \
> -                       semanage.semanage_node_get_
> proto_str(semanage.SEMANAGE_PROTO_IP6)
> -
> -               (status, con) = semanage.semanage_context_create(sh)
> -               if status < 0:
> -                       raise Error("Could not create SEContext object")
> -               if self.verbose: print "SEContext object created (for
> node)."
> -
> -               status = semanage.semanage_context_set_user(sh, con,
> "system_u")
> -               if status < 0:
> -                       raise Error("Could not set context user")
> -               if self.verbose: print "SEContext user: ",
> semanage.semanage_context_get_user(con)
> -
> -               status = semanage.semanage_context_set_role(sh, con,
> "object_r")
> -               if status < 0:
> -                       raise Error("Could not set context role")
> -               if self.verbose: print "SEContext role: ",
> semanage.semanage_context_get_role(con)
> -
> -               status = semanage.semanage_context_set_type(sh, con,
> "lo_node_t")
> -               if status < 0:
> -                       raise Error("Could not set context type")
> -               if self.verbose: print "SEContext type: ",
> semanage.semanage_context_get_type(con)
> -
> -               status = semanage.semanage_context_set_mls(sh, con,
> "s0:c0.c255")
> -               if status < 0:
> -                       raise Error("Could not set context MLS fields")
> -               if self.verbose: print "SEContext mls: ",
> semanage.semanage_context_get_mls(con)
> -
> -               status = semanage.semanage_node_set_con(sh, node, con)
> -               if status < 0:
> -                       raise Error("Could not set SENode context")
> -               if self.verbose: print "SENode context set: ", con
> -
> -                (status,key) = semanage.semanage_node_key_extract(sh,
> node)
> -               if status < 0:
> -                       raise Error("Could not extract SENode key")
> -               if self.verbose: print "SENode key extracted: ", key
> -
> -               (status,exists) = semanage.semanage_node_exists_
> local(sh,key)
> -               if status < 0:
> -                       raise Error("Could not check if SENode exists")
> -               if self.verbose: print "Exists status (commit number): ",
> status
> -
> -               if exists:
> -                       (status, old_node) = semanage.semanage_node_query_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not query old SENode")
> -                       if self.verbose: print "Query status (commit
> number): ", status
> -
> -               print "Starting transaction..."
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage
> transaction")
> -
> -               status = semanage.semanage_node_modify_local(sh,key, node)
> -               if status < 0:
> -                       raise Error("Could not modify SENode")
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit test transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               status = semanage.semanage_begin_transaction(sh)
> -               if status < 0:
> -                       raise Error("Could not start semanage transaction")
> -
> -               if not exists:
> -                       print "Removing network node..."
> -                        status = semanage.semanage_node_del_local(sh,
> key)
> -                       if status < 0:
> -                               raise Error("Could not delete test SENode")
> -                        if self.verbose: print "Network node delete: ",
> status
> -                else:
> -                       print "Resetting network node..."
> -                       status = semanage.semanage_node_modify_local(sh,
> key, old_node)
> -                       if status < 0:
> -                               raise Error("Could not reset test SENode")
> -                       if self.verbose: print "Network node modify: ",
> status
> -
> -               status = semanage.semanage_commit(sh)
> -               if status < 0:
> -                       raise Error("Could not commit reset transaction")
> -               print "Commit status (transaction number): ", status
> -
> -               semanage.semanage_context_free(con)
> -               semanage.semanage_node_key_free(key)
> -               semanage.semanage_node_free(node)
> -               if exists: semanage.semanage_node_free(old_node)
> +    def __init__(self):
> +        self.all = False
> +        self.users = False
> +        self.writeuser = False
> +        self.seusers = False
> +        self.writeseuser = False
> +        self.ports = False
> +        self.writeport = False
> +        self.fcontexts = False
> +        self.writefcontext = False
> +        self.interfaces = False
> +        self.writeinterface = False
> +        self.booleans = False
> +        self.writeboolean = False
> +        self.abooleans = False
> +        self.writeaboolean = False
> +        self.nodes = False
> +        self.writenode = False
> +        self.modules = False
> +        self.verbose = False
> +
> +    def selected(self):
> +        return (self.all or self.users or self.modules or self.seusers or
> self.ports or self.fcontexts or self.interfaces or self.booleans or
> self.abooleans or self.writeuser or self.writeseuser or self.writeport or
> self.writefcontext or self.writeinterface or self.writeboolean or
> self.writeaboolean or self.nodes or self.writenode)
> +
> +    def run(self, handle):
> +        if (self.users or self.all):
> +            self.test_users(handle)
> +            print ""
> +        if (self.seusers or self.all):
> +            self.test_seusers(handle)
> +            print ""
> +        if (self.ports or self.all):
> +            self.test_ports(handle)
> +            print ""
> +        if (self.modules or self.all):
> +            self.test_modules(handle)
> +            print ""
> +        if (self.fcontexts or self.all):
> +            self.test_fcontexts(handle)
> +            print ""
> +        if (self.interfaces or self.all):
> +            self.test_interfaces(handle)
> +            print ""
> +        if (self.booleans or self.all):
> +            self.test_booleans(handle)
> +            print ""
> +        if (self.abooleans or self.all):
> +            self.test_abooleans(handle)
> +            print ""
> +        if (self.nodes or self.all):
> +            self.test_nodes(handle)
> +            print ""
> +        if (self.writeuser or self.all):
> +            self.test_writeuser(handle)
> +            print ""
> +        if (self.writeseuser or self.all):
> +            self.test_writeseuser(handle)
> +            print ""
> +        if (self.writeport or self.all):
> +            self.test_writeport(handle)
> +            print ""
> +        if (self.writefcontext or self.all):
> +            self.test_writefcontext(handle)
> +            print ""
> +        if (self.writeinterface or self.all):
> +            self.test_writeinterface(handle)
> +            print ""
> +        if (self.writeboolean or self.all):
> +            self.test_writeboolean(handle)
> +            print ""
> +        if (self.writeaboolean or self.all):
> +            self.test_writeaboolean(handle)
> +            print ""
> +        if (self.writenode or self.all):
> +            self.test_writenode(handle)
> +            print ""
> +
> +    def test_modules(self,sh):
> +        print "Testing modules..."
> +
> +        (trans_cnt, mlist, mlist_size) = semanage.semanage_module_list(
> sh)
> +
> +        print "Transaction number: ", trans_cnt
> +        print "Module list size: ", mlist_size
> +        if self.verbose:
> +            print "List reference: ", mlist
> +
> +        if (mlist_size == 0):
> +            print "No modules installed!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for idx in range(mlist_size):
> +            module = semanage.semanage_module_list_nth(mlist, idx)
> +            if self.verbose:
> +                print "Module reference: ", module
> +            print "Module name: ", semanage.semanage_module_get_
> name(module)
> +
> +    def test_seusers(self,sh):
> +        print "Testing seusers..."
> +
> +        (status, slist) = semanage.semanage_seuser_list(sh)
> +        if status < 0:
> +            raise Error("Could not list seusers")
> +        print "Query status (commit number): ", status
> +
> +        if ( len(slist) == 0):
> +            print "No seusers found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for seuser in slist:
> +            if self.verbose:
> +                print "seseuser reference: ", seuser
> +            print "seuser name: ", semanage.semanage_seuser_get_
> name(seuser)
> +            print "   seuser mls range: ", semanage.semanage_seuser_get_
> mlsrange(seuser)
> +            print "   seuser sename: ", semanage.semanage_seuser_get_
> sename(seuser)
> +            semanage.semanage_seuser_free(seuser)
> +
> +    def test_users(self,sh):
> +        print "Testing users..."
> +
> +        (status, ulist) = semanage.semanage_user_list(sh)
> +        if status < 0:
> +            raise Error("Could not list users")
> +        print "Query status (commit number): ", status
> +
> +        if ( len(ulist) == 0):
> +            print "No users found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for user in ulist:
> +            if self.verbose:
> +                print "User reference: ", user
> +            print "User name: ", semanage.semanage_user_get_name(user)
> +            print "   User labeling prefix: ", semanage.semanage_user_get_
> prefix(user)
> +            print "   User mls level: ", semanage.semanage_user_get_
> mlslevel(user)
> +            print "   User mls range: ", semanage.semanage_user_get_
> mlsrange(user)
> +            print "   User number of roles: ", semanage.semanage_user_get_
> num_roles(user)
> +            print "   User roles: "
> +            (status, rlist) = semanage.semanage_user_get_roles(sh, user)
> +            if status < 0:
> +                raise Error("Could not get user roles")
> +
> +            for role in rlist:
> +                print "      ", role
> +
> +            semanage.semanage_user_free(user)
> +
> +    def test_ports(self,sh):
> +        print "Testing ports..."
> +
> +        (status, plist) = semanage.semanage_port_list(sh)
> +        if status < 0:
> +            raise Error("Could not list ports")
> +        print "Query status (commit number): ", status
> +
> +        if ( len(plist) == 0):
> +            print "No ports found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for port in plist:
> +            if self.verbose:
> +                print "Port reference: ", port
> +            low = semanage.semanage_port_get_low(port)
> +            high = semanage.semanage_port_get_high(port)
> +            con = semanage.semanage_port_get_con(port)
> +            proto = semanage.semanage_port_get_proto(port)
> +            proto_str = semanage.semanage_port_get_proto_str(proto)
> +            if low == high:
> +                range_str = str(low)
> +            else:
> +                range_str = str(low) + "-" + str(high)
> +            (rc, con_str) = semanage.semanage_context_to_string(sh,con)
> +            if rc < 0: con_str = ""
> +            print "Port: ", range_str, " ", proto_str, " Context: ",
> con_str
> +            semanage.semanage_port_free(port)
> +
> +    def test_fcontexts(self,sh):
> +        print "Testing file contexts..."
> +
> +        (status, flist) = semanage.semanage_fcontext_list(sh)
> +        if status < 0:
> +            raise Error("Could not list file contexts")
> +        print "Query status (commit number): ", status
> +
> +        if (len(flist) == 0):
> +            print "No file contexts found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for fcon in flist:
> +            if self.verbose:
> +                print "File Context reference: ", fcon
> +            expr = semanage.semanage_fcontext_get_expr(fcon)
> +            type = semanage.semanage_fcontext_get_type(fcon)
> +            type_str = semanage.semanage_fcontext_get_type_str(type)
> +            con = semanage.semanage_fcontext_get_con(fcon)
> +            if not con:
> +                con_str = "<<none>>"
> +            else:
> +                (rc, con_str) = semanage.semanage_context_to_
> string(sh,con)
> +                if rc < 0: con_str = ""
> +            print "File Expr: ", expr, " [", type_str, "] Context: ",
> con_str
> +            semanage.semanage_fcontext_free(fcon)
> +
> +    def test_interfaces(self,sh):
> +        print "Testing network interfaces..."
> +
> +        (status, ilist) = semanage.semanage_iface_list(sh)
> +        if status < 0:
> +            raise Error("Could not list interfaces")
> +        print "Query status (commit number): ", status
> +
> +        if (len(ilist) == 0):
> +            print "No network interfaces found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for iface in ilist:
> +            if self.verbose:
> +                print "Interface reference: ", iface
> +            name = semanage.semanage_iface_get_name(iface)
> +            msg_con = semanage.semanage_iface_get_msgcon(iface)
> +            if_con = semanage.semanage_iface_get_ifcon(iface)
> +            (rc, msg_con_str) = semanage.semanage_context_to_
> string(sh,msg_con)
> +            if rc < 0: msg_con_str = ""
> +            (rc, if_con_str) = semanage.semanage_context_to_string(sh,
> if_con)
> +            if rc < 0: if_con_str = ""
> +            print "Interface: ", name, " Context: ", if_con_str, "
> Message Context: ", msg_con_str
> +            semanage.semanage_iface_free(iface)
> +
> +    def test_booleans(self,sh):
> +        print "Testing booleans..."
> +
> +        (status, blist) = semanage.semanage_bool_list(sh)
> +        if status < 0:
> +            raise Error("Could not list booleans")
> +        print "Query status (commit number): ", status
> +
> +        if (len(blist) == 0):
> +            print "No booleans found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for pbool in blist:
> +            if self.verbose:
> +                print "Boolean reference: ", pbool
> +            name = semanage.semanage_bool_get_name(pbool)
> +            value = semanage.semanage_bool_get_value(pbool)
> +            print "Boolean: ", name, " Value: ", value
> +            semanage.semanage_bool_free(pbool)
> +
> +    def test_abooleans(self,sh):
> +        print "Testing active booleans..."
> +
> +        (status, ablist) = semanage.semanage_bool_list_active(sh)
> +        if status < 0:
> +            raise Error("Could not list active booleans")
> +        print "Query status (commit number): ", status
> +
> +        if (len(ablist) == 0):
> +            print "No active booleans found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for abool in ablist:
> +            if self.verbose:
> +                print "Active boolean reference: ", abool
> +            name = semanage.semanage_bool_get_name(abool)
> +            value = semanage.semanage_bool_get_value(abool)
> +            print "Active Boolean: ", name, " Value: ", value
> +            semanage.semanage_bool_free(abool)
> +
> +    def test_nodes(self,sh):
> +        print "Testing network nodes..."
> +
> +        (status, nlist) = semanage.semanage_node_list(sh)
> +        if status < 0:
> +            raise Error("Could not list network nodes")
> +        print "Query status (commit number): ", status
> +
> +        if (len(nlist) == 0):
> +            print "No network nodes found!"
> +            print "This is not necessarily a test failure."
> +            return
> +        for node in nlist:
> +            if self.verbose:
> +                print "Network node reference: ", node
> +
> +            (status, addr) = semanage.semanage_node_get_addr(sh, node)
> +            if status < 0: addr = ""
> +
> +            (status, mask) = semanage.semanage_node_get_mask(sh, node)
> +            if status < 0: mask = ""
> +
> +            proto = semanage.semanage_node_get_proto(node)
> +            proto_str = semanage.semanage_node_get_proto_str(proto)
> +            con = semanage.semanage_node_get_con(node)
> +
> +            (status, con_str) = semanage.semanage_context_to_string(sh,
> con)
> +            if status < 0: con_str = ""
> +
> +            print "Network Node: ", addr, "/", mask, " (", proto_str,
> ")", "Context: ", con_str
> +            semanage.semanage_node_free(node)
> +
> +    def test_writeuser(self,sh):
> +        print "Testing user write..."
> +
> +        (status, user) = semanage.semanage_user_create(sh)
> +        if status < 0:
> +            raise Error("Could not create user object")
> +        if self.verbose:
> +            print "User object created"
> +
> +        status = semanage.semanage_user_set_name(sh,user, "testPyUser")
> +        if status < 0:
> +            raise Error("Could not set user name")
> +        if self.verbose:
> +            print "User name set: ", semanage.semanage_user_get_
> name(user)
> +
> +        status = semanage.semanage_user_add_role(sh, user, "user_r")
> +        if status < 0:
> +            raise Error("Could not add role")
> +
> +        status = semanage.semanage_user_set_prefix(sh,user, "user")
> +        if status < 0:
> +            raise Error("Could not set labeling prefix")
> +        if self.verbose:
> +            print "User prefix set: ", semanage.semanage_user_get_
> prefix(user)
> +
> +        status = semanage.semanage_user_set_mlsrange(sh, user, "s0")
> +        if status < 0:
> +            raise Error("Could not set MLS range")
> +        if self.verbose:
> +            print "User mlsrange: ", semanage.semanage_user_get_
> mlsrange(user)
> +
> +        status = semanage.semanage_user_set_mlslevel(sh, user, "s0")
> +        if status < 0:
> +            raise Error("Could not set MLS level")
> +        if self.verbose:
> +            print "User mlslevel: ", semanage.semanage_user_get_
> mlslevel(user)
> +
> +        (status,key) = semanage.semanage_user_key_extract(sh,user)
> +        if status < 0:
> +            raise Error("Could not extract user key")
> +        if self.verbose:
> +            print "User key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_user_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if user exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_user) = semanage.semanage_user_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old user")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction.."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_user_modify_local(sh,key,user)
> +        if status < 0:
> +            raise Error("Could not modify user")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing user..."
> +            status = semanage.semanage_user_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test user")
> +            if self.verbose:
> +                print "User delete: ", status
> +        else:
> +            print "Resetting user..."
> +            status = semanage.semanage_user_modify_local(sh, key,
> old_user)
> +            if status < 0:
> +                raise Error("Could not reset test user")
> +            if self.verbose:
> +                print "User modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_user_key_free(key)
> +        semanage.semanage_user_free(user)
> +        if exists: semanage.semanage_user_free(old_user)
> +
> +    def test_writeseuser(self,sh):
> +        print "Testing seuser write..."
> +
> +        (status, seuser) = semanage.semanage_seuser_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEUser object")
> +        if self.verbose:
> +            print "SEUser object created."
> +
> +        status = semanage.semanage_seuser_set_name(sh,seuser,
> "testPySEUser")
> +        if status < 0:
> +            raise Error("Could not set name")
> +        if self.verbose:
> +            print "SEUser name set: ", semanage.semanage_seuser_get_
> name(seuser)
> +
> +        status = semanage.semanage_seuser_set_sename(sh, seuser, "root")
> +        if status < 0:
> +            raise Error("Could not set sename")
> +        if self.verbose:
> +            print "SEUser seuser: ", semanage.semanage_seuser_get_
> sename(seuser)
> +
> +        status = semanage.semanage_seuser_set_mlsrange(sh, seuser,
> "s0:c0.c255")
> +        if status < 0:
> +            raise Error("Could not set MLS range")
> +        if self.verbose:
> +            print "SEUser mlsrange: ", semanage.semanage_seuser_get_
> mlsrange(seuser)
> +
> +        (status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
> +        if status < 0:
> +            raise Error("Could not extract SEUser key")
> +        if self.verbose:
> +            print "SEUser key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_seuser_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SEUser exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_seuser) = semanage.semanage_seuser_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SEUser")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_seuser_modify_local(sh,key,seuser)
> +        if status < 0:
> +            raise Error("Could not modify SEUser")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing seuser..."
> +            status = semanage.semanage_seuser_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SEUser")
> +            if self.verbose:
> +                print "Seuser delete: ", status
> +        else:
> +            print "Resetting seuser..."
> +            status = semanage.semanage_seuser_modify_local(sh, key,
> old_seuser)
> +            if status < 0:
> +                raise Error("Could not reset test SEUser")
> +            if self.verbose:
> +                print "Seuser modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_seuser_key_free(key)
> +        semanage.semanage_seuser_free(seuser)
> +        if exists:
> +            semanage.semanage_seuser_free(old_seuser)
> +
> +    def test_writeport(self,sh):
> +        print "Testing port write..."
> +
> +        (status, port) = semanage.semanage_port_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEPort object")
> +        if self.verbose:
> +            print "SEPort object created."
> +
> +        semanage.semanage_port_set_range(port,150,200)
> +        low = semanage.semanage_port_get_low(port)
> +        high = semanage.semanage_port_get_high(port)
> +        if self.verbose:
> +            print "SEPort range set: ", low, "-", high
> +
> +        semanage.semanage_port_set_proto(port,
> semanage.SEMANAGE_PROTO_TCP)
> +        if self.verbose:
> +            print "SEPort protocol set: ", semanage.semanage_port_get_
> proto_str(semanage.SEMANAGE_PROTO_TCP)
> +
> +        (status, con) = semanage.semanage_context_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEContext object")
> +        if self.verbose:
> +            print "SEContext object created (for port)."
> +
> +        status = semanage.semanage_context_set_user(sh, con, "system_u")
> +        if status < 0:
> +            raise Error("Could not set context user")
> +        if self.verbose:
> +            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +
> +        status = semanage.semanage_context_set_role(sh, con, "object_r")
> +        if status < 0:
> +            raise Error("Could not set context role")
> +        if self.verbose:
> +            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +
> +        status = semanage.semanage_context_set_type(sh, con,
> "http_port_t")
> +        if status < 0:
> +            raise Error("Could not set context type")
> +        if self.verbose:
> +            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +
> +        status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
> +        if status < 0:
> +            raise Error("Could not set context MLS fields")
> +        if self.verbose:
> +            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +
> +        status = semanage.semanage_port_set_con(sh, port, con)
> +        if status < 0:
> +            raise Error("Could not set SEPort context")
> +        if self.verbose:
> +            print "SEPort context set: ", con
> +
> +        (status,key) = semanage.semanage_port_key_extract(sh,port)
> +        if status < 0:
> +            raise Error("Could not extract SEPort key")
> +        if self.verbose:
> +            print "SEPort key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_port_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SEPort exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_port) = semanage.semanage_port_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SEPort")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_port_modify_local(sh,key,port)
> +        if status < 0:
> +            raise Error("Could not modify SEPort")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing port range..."
> +            status = semanage.semanage_port_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SEPort")
> +            if self.verbose:
> +                print "Port range delete: ", status
> +        else:
> +            print "Resetting port range..."
> +            status = semanage.semanage_port_modify_local(sh, key,
> old_port)
> +            if status < 0:
> +                raise Error("Could not reset test SEPort")
> +            if self.verbose:
> +                print "Port range modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_context_free(con)
> +        semanage.semanage_port_key_free(key)
> +        semanage.semanage_port_free(port)
> +        if exists:
> +            semanage.semanage_port_free(old_port)
> +
> +    def test_writefcontext(self,sh):
> +        print "Testing file context write..."
> +
> +        (status, fcon) = semanage.semanage_fcontext_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEFcontext object")
> +        if self.verbose:
> +            print "SEFcontext object created."
> +
> +        status = semanage.semanage_fcontext_set_expr(sh, fcon,
> "/test/fcontext(/.*)?")
> +        if status < 0:
> +            raise Error("Could not set expression")
> +        if self.verbose:
> +            print "SEFContext expr set: ", semanage.semanage_fcontext_
> get_expr(fcon)
> +
> +        semanage.semanage_fcontext_set_type(fcon,
> semanage.SEMANAGE_FCONTEXT_REG)
> +        if self.verbose:
> +            ftype = semanage.semanage_fcontext_get_type(fcon)
> +            print "SEFContext type set: ", semanage.semanage_fcontext_
> get_type_str(ftype)
> +
> +        (status, con) = semanage.semanage_context_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEContext object")
> +        if self.verbose:
> +            print "SEContext object created (for file context)."
> +
> +        status = semanage.semanage_context_set_user(sh, con, "system_u")
> +        if status < 0:
> +            raise Error("Could not set context user")
> +        if self.verbose:
> +            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +
> +        status = semanage.semanage_context_set_role(sh, con, "object_r")
> +        if status < 0:
> +            raise Error("Could not set context role")
> +        if self.verbose:
> +            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +
> +        status = semanage.semanage_context_set_type(sh, con, "default_t")
> +        if status < 0:
> +            raise Error("Could not set context type")
> +        if self.verbose:
> +            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +
> +        status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
> +        if status < 0:
> +            raise Error("Could not set context MLS fields")
> +        if self.verbose:
> +            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +
> +        status = semanage.semanage_fcontext_set_con(sh, fcon, con)
> +        if status < 0:
> +            raise Error("Could not set SEFcontext context")
> +        if self.verbose:
> +            print "SEFcontext context set: ", con
> +
> +        (status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
> +        if status < 0:
> +            raise Error("Could not extract SEFcontext key")
> +        if self.verbose:
> +            print "SEFcontext key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_fcontext_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SEFcontext exists")
> +
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +        if exists:
> +            (status, old_fcontext) = semanage.semanage_fcontext_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SEFcontext")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_fcontext_modify_local(sh,key,fcon)
> +        if status < 0:
> +            raise Error("Could not modify SEFcontext")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing file context..."
> +            status = semanage.semanage_fcontext_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SEFcontext")
> +            if self.verbose:
> +                print "File context delete: ", status
> +        else:
> +            print "Resetting file context..."
> +            status = semanage.semanage_fcontext_modify_local(sh, key,
> old_fcontext)
> +            if status < 0:
> +                raise Error("Could not reset test FContext")
> +            if self.verbose:
> +                print "File context modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_context_free(con)
> +        semanage.semanage_fcontext_key_free(key)
> +        semanage.semanage_fcontext_free(fcon)
> +        if exists:
> +            semanage.semanage_fcontext_free(old_fcontext)
> +
> +    def test_writeinterface(self,sh):
> +        print "Testing network interface write..."
> +
> +        (status, iface) = semanage.semanage_iface_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEIface object")
> +        if self.verbose:
> +            print "SEIface object created."
> +
> +        status = semanage.semanage_iface_set_name(sh, iface,
> "test_iface")
> +        if status < 0:
> +            raise Error("Could not set SEIface name")
> +        if self.verbose:
> +            print "SEIface name set: ", semanage.semanage_iface_get_
> name(iface)
> +
> +        (status, con) = semanage.semanage_context_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEContext object")
> +        if self.verbose:
> +            print "SEContext object created (for network interface)"
> +
> +        status = semanage.semanage_context_set_user(sh, con, "system_u")
> +        if status < 0:
> +            raise Error("Could not set interface context user")
> +        if self.verbose:
> +            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +
> +        status = semanage.semanage_context_set_role(sh, con, "object_r")
> +        if status < 0:
> +            raise Error("Could not set interface context role")
> +        if self.verbose:
> +            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +
> +        status = semanage.semanage_context_set_type(sh, con, "default_t")
> +        if status < 0:
> +            raise Error("Could not set interface context type")
> +        if self.verbose:
> +            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +
> +        status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
> +        if status < 0:
> +            raise Error("Could not set interface context MLS fields")
> +        if self.verbose:
> +            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +
> +        status = semanage.semanage_iface_set_ifcon(sh, iface, con)
> +        if status < 0:
> +            raise Error("Could not set SEIface interface context")
> +        if self.verbose:
> +            print "SEIface interface context set: ", con
> +
> +        status = semanage.semanage_iface_set_msgcon(sh, iface, con)
> +        if status < 0:
> +            raise Error("Could not set SEIface message context")
> +        if self.verbose:
> +            print "SEIface message context set: ", con
> +
> +        (status,key) = semanage.semanage_iface_key_extract(sh,iface)
> +        if status < 0:
> +            raise Error("Could not extract SEIface key")
> +        if self.verbose:
> +            print "SEIface key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_iface_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SEIface exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_iface) = semanage.semanage_iface_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SEIface")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not begin semanage transaction")
> +
> +        status = semanage.semanage_iface_modify_local(sh,key,iface)
> +        if status < 0:
> +            raise Error("Could not modify SEIface")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not begin semanage transaction")
> +
> +        if not exists:
> +            print "Removing interface..."
> +            status = semanage.semanage_iface_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SEIface")
> +            if self.verbose:
> +                print "Interface delete: ", status
> +        else:
> +            print "Resetting interface..."
> +            status = semanage.semanage_iface_modify_local(sh, key,
> old_iface)
> +            if status < 0:
> +                raise Error("Could not reset test SEIface")
> +            if self.verbose:
> +                print "Interface modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_context_free(con)
> +        semanage.semanage_iface_key_free(key)
> +        semanage.semanage_iface_free(iface)
> +        if exists:
> +            semanage.semanage_iface_free(old_iface)
> +
> +    def test_writeboolean(self,sh):
> +        print "Testing boolean write..."
> +
> +        (status, pbool) = semanage.semanage_bool_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEBool object")
> +        if self.verbose:
> +            print "SEBool object created."
> +
> +        status = semanage.semanage_bool_set_name(sh, pbool,
> "allow_execmem")
> +        if status < 0:
> +            raise Error("Could not set name")
> +        if self.verbose:
> +            print "SEBool name set: ", semanage.semanage_bool_get_
> name(pbool)
> +
> +        semanage.semanage_bool_set_value(pbool, 0)
> +        if self.verbose:
> +            print "SEbool value set: ", semanage.semanage_bool_get_
> value(pbool)
> +
> +        (status,key) = semanage.semanage_bool_key_extract(sh, pbool)
> +        if status < 0:
> +            raise Error("Could not extract SEBool key")
> +        if self.verbose:
> +            print "SEBool key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_bool_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SEBool exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_bool) = semanage.semanage_bool_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SEBool")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_bool_modify_local(sh, key, pbool)
> +
> +        if status < 0:
> +            raise Error("Could not modify SEBool")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing boolean..."
> +            status = semanage.semanage_bool_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SEBool")
> +            if self.verbose:
> +                print "Boolean delete: ", status
> +        else:
> +            print "Resetting boolean..."
> +            status = semanage.semanage_bool_modify_local(sh, key,
> old_bool)
> +            if status < 0:
> +                raise Error("Could not reset test SEBool")
> +            if self.verbose:
> +                print "Boolean modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_bool_key_free(key)
> +        semanage.semanage_bool_free(pbool)
> +        if exists: semanage.semanage_bool_free(old_bool)
> +
> +    def test_writeaboolean(self,sh):
> +        print "Testing active boolean write..."
> +
> +        (status, key) = semanage.semanage_bool_key_create(sh,
> "allow_execmem")
> +        if status < 0:
> +            raise Error("Could not create SEBool key")
> +        if self.verbose:
> +            print "SEBool key created: ", key
> +
> +        (status, old_bool) = semanage.semanage_bool_query_active(sh, key)
> +        if status < 0:
> +            raise Error("Could not query old SEBool")
> +        if self.verbose:
> +            print "Query status (commit number): ", status
> +
> +        (status, abool) = semanage.semanage_bool_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEBool object")
> +        if self.verbose:
> +            print "SEBool object created."
> +
> +        status = semanage.semanage_bool_set_name(sh, abool,
> "allow_execmem")
> +        if status < 0:
> +            raise Error("Could not set name")
> +        if self.verbose:
> +            print "SEBool name set: ", semanage.semanage_bool_get_
> name(abool)
> +
> +        semanage.semanage_bool_set_value(abool, 0)
> +        if self.verbose:
> +            print "SEbool value set: ", semanage.semanage_bool_get_
> value(abool)
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_bool_set_active(sh,key,abool)
> +        if status < 0:
> +            raise Error("Could not modify SEBool")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        print "Resetting old active boolean..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_bool_set_active(sh, key,old_bool)
> +        if status < 0:
> +            raise Error("Could not reset test SEBool")
> +        if self.verbose:
> +            print "SEBool active reset: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_bool_key_free(key)
> +        semanage.semanage_bool_free(abool)
> +        semanage.semanage_bool_free(old_bool)
> +
> +
> +    def test_writenode(self,sh):
> +        print "Testing network node write..."
> +
> +        (status, node) = semanage.semanage_node_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SENode object")
> +        if self.verbose:
> +            print "SENode object created."
> +
> +        status = semanage.semanage_node_set_addr(sh, node,
> semanage.SEMANAGE_PROTO_IP6, "ffee:dddd::bbbb")
> +        if status < 0:
> +            raise Error("Could not set SENode address")
> +
> +        status = semanage.semanage_node_set_mask(sh, node,
> semanage.SEMANAGE_PROTO_IP6, "::ffff:ffff:abcd:0000")
> +        if status < 0:
> +            raise Error("Could not set SENode netmask")
> +
> +        semanage.semanage_node_set_proto(node,
> semanage.SEMANAGE_PROTO_IP6)
> +        if self.verbose:
> +            print "SENode protocol set: ", semanage.semanage_node_get_
> proto_str(semanage.SEMANAGE_PROTO_IP6)
> +
> +        (status, con) = semanage.semanage_context_create(sh)
> +        if status < 0:
> +            raise Error("Could not create SEContext object")
> +        if self.verbose:
> +            print "SEContext object created (for node)."
> +
> +        status = semanage.semanage_context_set_user(sh, con, "system_u")
> +        if status < 0:
> +            raise Error("Could not set context user")
> +        if self.verbose:
> +            print "SEContext user: ", semanage.semanage_context_get_
> user(con)
> +
> +        status = semanage.semanage_context_set_role(sh, con, "object_r")
> +        if status < 0:
> +            raise Error("Could not set context role")
> +        if self.verbose:
> +            print "SEContext role: ", semanage.semanage_context_get_
> role(con)
> +
> +        status = semanage.semanage_context_set_type(sh, con, "lo_node_t")
> +        if status < 0:
> +            raise Error("Could not set context type")
> +        if self.verbose:
> +            print "SEContext type: ", semanage.semanage_context_get_
> type(con)
> +
> +        status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
> +        if status < 0:
> +            raise Error("Could not set context MLS fields")
> +        if self.verbose:
> +            print "SEContext mls: ", semanage.semanage_context_get_
> mls(con)
> +
> +        status = semanage.semanage_node_set_con(sh, node, con)
> +        if status < 0:
> +            raise Error("Could not set SENode context")
> +        if self.verbose:
> +            print "SENode context set: ", con
> +
> +        (status,key) = semanage.semanage_node_key_extract(sh, node)
> +        if status < 0:
> +            raise Error("Could not extract SENode key")
> +        if self.verbose:
> +            print "SENode key extracted: ", key
> +
> +        (status,exists) = semanage.semanage_node_exists_local(sh,key)
> +        if status < 0:
> +            raise Error("Could not check if SENode exists")
> +        if self.verbose:
> +            print "Exists status (commit number): ", status
> +
> +        if exists:
> +            (status, old_node) = semanage.semanage_node_query_local(sh,
> key)
> +            if status < 0:
> +                raise Error("Could not query old SENode")
> +            if self.verbose:
> +                print "Query status (commit number): ", status
> +
> +        print "Starting transaction..."
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        status = semanage.semanage_node_modify_local(sh,key, node)
> +        if status < 0:
> +            raise Error("Could not modify SENode")
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit test transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        status = semanage.semanage_begin_transaction(sh)
> +        if status < 0:
> +            raise Error("Could not start semanage transaction")
> +
> +        if not exists:
> +            print "Removing network node..."
> +            status = semanage.semanage_node_del_local(sh, key)
> +            if status < 0:
> +                raise Error("Could not delete test SENode")
> +            if self.verbose:
> +                print "Network node delete: ", status
> +        else:
> +            print "Resetting network node..."
> +            status = semanage.semanage_node_modify_local(sh, key,
> old_node)
> +            if status < 0:
> +                raise Error("Could not reset test SENode")
> +            if self.verbose:
> +                print "Network node modify: ", status
> +
> +        status = semanage.semanage_commit(sh)
> +        if status < 0:
> +            raise Error("Could not commit reset transaction")
> +        print "Commit status (transaction number): ", status
> +
> +        semanage.semanage_context_free(con)
> +        semanage.semanage_node_key_free(key)
> +        semanage.semanage_node_free(node)
> +        if exists:
> +            semanage.semanage_node_free(old_node)
>
>  def main(argv=None):
> -       if argv is None:
> -               argv = sys.argv
> -       try:
> -               try:
> -                       opts, args = getopt.getopt(argv[1:],
> "hvmuspfibcUSPFIBCanN", ["help", "verbose", "modules", "users", "seusers",
> "ports", "file contexts", "network interfaces", "booleans", "active
> booleans", "network nodes", "writeuser", "writeseuser", "writeport",
> "writefcontext", "writeinterface", "writeboolean", "writeaboolean",
> "writenode", "all"])
> -                       tests = Tests()
> -                       for o, a in opts:
> -                               if o == "-v":
> -                                       tests.verbose = True
> -                                       print "Verbose output selected."
> -                               if o == "-a":
> -                                       tests.all = True
> -                               if o == "-u":
> -                                       tests.users = True
> -                               if o == "-U":
> -                                       tests.writeuser = True
> -                               if o == "-s":
> -                                       tests.seusers = True
> -                               if o == "-S":
> -                                       tests.writeseuser = True
> -                               if o == "-p":
> -                                       tests.ports = True
> -                               if o == "-P":
> -                                       tests.writeport = True
> -                               if o == "-f":
> -                                       tests.fcontexts = True
> -                               if o == "-F":
> -                                       tests.writefcontext = True
> -                               if o == "-i":
> -                                       tests.interfaces = True
> -                               if o == "-I":
> -                                       tests.writeinterface = True
> -                               if o == "-b":
> -                                       tests.booleans = True
> -                               if o == "-B":
> -                                       tests.writeboolean = True
> -                               if o == "-c":
> -                                       tests.abooleans = True
> -                               if o == "-C":
> -                                       tests.writeaboolean = True
> -                               if o == "-n":
> -                                       tests.nodes = True
> -                               if o == "-N":
> -                                       tests.writenode = True
> -                               if o == "-m":
> -                                       tests.modules = True
> -                               if o == "-h":
> -                                       raise Usage(usage)
> -
> -                       if not tests.selected():
> -                               raise Usage("Please select a valid test.")
> -
> -               except getopt.error, msg:
> -                       raise Usage(msg)
> -
> -               sh=semanage.semanage_handle_create()
> -
> -               if (semanage.semanage_is_managed(sh) != 1):
> -                       raise Status("Unmanaged!")
> -
> -               status = semanage.semanage_connect(sh)
> -               if status < 0:
> -                       raise Error("Could not establish semanage
> connection")
> -
> -               tests.run(sh)
> -
> -               status = semanage.semanage_disconnect(sh)
> -               if status < 0:
> -                       raise Error("Could not disconnect")
> -
> -               semanage.semanage_handle_destroy(sh)
> -
> -       except Usage, err:
> -               print >>sys.stderr, err.msg
> -       except Status, err:
> -               print >>sys.stderr, err.msg
> -       except Error, err:
> -               print >>sys.stderr, err.msg
> -
> -        return 2
> +    if argv is None:
> +        argv = sys.argv
> +    try:
> +        try:
> +            opts, args = getopt.getopt(argv[1:], "hvmuspfibcUSPFIBCanN",
> ["help", "verbose", "modules", "users", "seusers", "ports", "file
> contexts", "network interfaces", "booleans", "active booleans", "network
> nodes", "writeuser", "writeseuser", "writeport", "writefcontext",
> "writeinterface", "writeboolean", "writeaboolean", "writenode", "all"])
> +            tests = Tests()
> +            for o, a in opts:
> +                if o == "-v":
> +                    tests.verbose = True
> +                    print "Verbose output selected."
> +                if o == "-a":
> +                    tests.all = True
> +                if o == "-u":
> +                    tests.users = True
> +                if o == "-U":
> +                    tests.writeuser = True
> +                if o == "-s":
> +                    tests.seusers = True
> +                if o == "-S":
> +                    tests.writeseuser = True
> +                if o == "-p":
> +                    tests.ports = True
> +                if o == "-P":
> +                    tests.writeport = True
> +                if o == "-f":
> +                    tests.fcontexts = True
> +                if o == "-F":
> +                    tests.writefcontext = True
> +                if o == "-i":
> +                    tests.interfaces = True
> +                if o == "-I":
> +                    tests.writeinterface = True
> +                if o == "-b":
> +                    tests.booleans = True
> +                if o == "-B":
> +                    tests.writeboolean = True
> +                if o == "-c":
> +                    tests.abooleans = True
> +                if o == "-C":
> +                    tests.writeaboolean = True
> +                if o == "-n":
> +                    tests.nodes = True
> +                if o == "-N":
> +                    tests.writenode = True
> +                if o == "-m":
> +                    tests.modules = True
> +                if o == "-h":
> +                    raise Usage(usage)
> +
> +            if not tests.selected():
> +                raise Usage("Please select a valid test.")
> +
> +        except getopt.error, msg:
> +            raise Usage(msg)
> +
> +        sh=semanage.semanage_handle_create()
> +
> +        if (semanage.semanage_is_managed(sh) != 1):
> +            raise Status("Unmanaged!")
> +
> +        status = semanage.semanage_connect(sh)
> +        if status < 0:
> +            raise Error("Could not establish semanage connection")
> +
> +        tests.run(sh)
> +
> +        status = semanage.semanage_disconnect(sh)
> +        if status < 0:
> +            raise Error("Could not disconnect")
> +
> +        semanage.semanage_handle_destroy(sh)
> +
> +    except Usage, err:
> +        print >>sys.stderr, err.msg
> +    except Status, err:
> +        print >>sys.stderr, err.msg
> +    except Error, err:
> +        print >>sys.stderr, err.msg
> +
> +    return 2
>
>  if __name__ == "__main__":
> -       sys.exit(main())
> -
> +    sys.exit(main())
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

--000000000000e0014b0573ba0e8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+QWNrIGFwcGxpZXMgYW5kIHJ1bnM8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBTYXQsIEF1ZyAxOCwgMjAx
OCBhdCAxMDo1MCBBTSwgTmljb2xhcyBJb29zcyA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9
Im1haWx0bzpuaWNvbGFzLmlvb3NzQG00eC5vcmciIHRhcmdldD0iX2JsYW5rIj5uaWNvbGFzLmlv
b3NzQG00eC5vcmc8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPk9ubHkgdXNlIHNwYWNlcyB0byBpbmRlbnQgUHl0aG9u
IGNvZGUuIFRoaXMgcmVkdWNlcyB0aGUgbnVtYmVyIG9mPGJyPg0Kd2FybmluZ3MgcmVwb3J0ZWQg
YnkgUHl0aG9uIGxpbnRlcnMuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogTmljb2xhcyBJb29z
cyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5pY29sYXMuaW9vc3NAbTR4Lm9yZyI+bmljb2xhcy5pb29z
c0BtNHgub3JnPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGxpYnNlbWFuYWdlL3NyYy9weXdyYXAt
dGVzdC5weSB8IDIzMDEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tPHdicj4tLTxicj4N
CsKgMSBmaWxlIGNoYW5nZWQsIDEyMDAgaW5zZXJ0aW9ucygrKSwgMTEwMSBkZWxldGlvbnMoLSk8
YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL3B5d3JhcC10ZXN0Ljx3YnI+
cHkgYi9saWJzZW1hbmFnZS9zcmMvcHl3cmFwLXRlc3QuPHdicj5weTxicj4NCmluZGV4IDI1YjY2
OGQ4MGI2Ny4uMzI2MDM0OTQ3YWE1IDEwMDY0NDxicj4NCi0tLSBhL2xpYnNlbWFuYWdlL3NyYy9w
eXdyYXAtdGVzdC48d2JyPnB5PGJyPg0KKysrIGIvbGlic2VtYW5hZ2Uvc3JjL3B5d3JhcC10ZXN0
Ljx3YnI+cHk8YnI+DQpAQCAtMjgsMTExNCArMjgsMTIxMyBAQCBPdGhlciBvcHRpb25zOlxuXDxi
cj4NCsKgJnF1b3Q7PGJyPg0KPGJyPg0KwqBjbGFzcyBVc2FnZShFeGNlcHRpb24pOjxicj4NCi3C
oCDCoCDCoCDCoGRlZiBfX2luaXRfXyhzZWxmLCBtc2cpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoEV4Y2VwdGlvbi5fX2luaXRfXyhzZWxmKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNlbGYubXNnID0gbXNnPGJyPg0KK8KgIMKgIGRlZiBfX2luaXRfXyhzZWxmLCBtc2cpOjxi
cj4NCivCoCDCoCDCoCDCoCBFeGNlcHRpb24uX19pbml0X18oc2VsZik8YnI+DQorwqAgwqAgwqAg
wqAgc2VsZi5tc2cgPSBtc2c8YnI+DQo8YnI+DQrCoGNsYXNzIFN0YXR1cyhFeGNlcHRpb24pOjxi
cj4NCi3CoCDCoCDCoCDCoGRlZiBfX2luaXRfXyhzZWxmLCBtc2cpOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoEV4Y2VwdGlvbi5fX2luaXRfXyhzZWxmKTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNlbGYubXNnID0gbXNnPGJyPg0KK8KgIMKgIGRlZiBfX2luaXRfXyhzZWxmLCBt
c2cpOjxicj4NCivCoCDCoCDCoCDCoCBFeGNlcHRpb24uX19pbml0X18oc2VsZik8YnI+DQorwqAg
wqAgwqAgwqAgc2VsZi5tc2cgPSBtc2c8YnI+DQo8YnI+DQrCoGNsYXNzIEVycm9yKEV4Y2VwdGlv
bik6PGJyPg0KLcKgIMKgIMKgIMKgZGVmIF9faW5pdF9fKHNlbGYsIG1zZyk6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgRXhjZXB0aW9uLl9faW5pdF9fKHNlbGYpPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc2VsZi5tc2cgPSBtc2c8YnI+DQorwqAgwqAgZGVmIF9faW5pdF9fKHNl
bGYsIG1zZyk6PGJyPg0KK8KgIMKgIMKgIMKgIEV4Y2VwdGlvbi5fX2luaXRfXyhzZWxmKTxicj4N
CivCoCDCoCDCoCDCoCBzZWxmLm1zZyA9IG1zZzxicj4NCjxicj4NCsKgY2xhc3MgVGVzdHM6PGJy
Pg0KLcKgIMKgIMKgIMKgZGVmIF9faW5pdF9fKHNlbGYpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHNlbGYuYWxsID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxm
LnVzZXJzID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLndyaXRldXNl
ciA9IEZhbHNlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi5zZXVzZXJzID0gRmFs
c2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLndyaXRlc2V1c2VyID0gRmFsc2U8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnBvcnRzID0gRmFsc2U8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLndyaXRlcG9ydCA9IEZhbHNlPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc2VsZi5mY29udGV4dHMgPSBGYWxzZTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNlbGYud3JpdGVmY29udGV4dCA9IEZhbHNlPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2VsZi5pbnRlcmZhY2VzID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzZWxmLndyaXRlaW50ZXJmYWNlID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzZWxmLmJvb2xlYW5zID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
ZWxmLndyaXRlYm9vbGVhbiA9IEZhbHNlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vs
Zi5hYm9vbGVhbnMgPSBGYWxzZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYud3Jp
dGVhYm9vbGVhbiA9IEZhbHNlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi5ub2Rl
cyA9IEZhbHNlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi53cml0ZW5vZGUgPSBG
YWxzZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYubW9kdWxlcyA9IEZhbHNlPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi52ZXJib3NlID0gRmFsc2U8YnI+DQotPGJy
Pg0KLcKgIMKgIMKgIMKgZGVmIHNlbGVjdGVkKHNlbGYpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiAoc2VsZi5hbGwgb3Igc2VsZi51c2VycyBvciBzZWxmLm1vZHVsZXMgb3Ig
c2VsZi5zZXVzZXJzIG9yIHNlbGYucG9ydHMgb3Igc2VsZi5mY29udGV4dHMgb3Igc2VsZi5pbnRl
cmZhY2VzIG9yIHNlbGYuYm9vbGVhbnMgb3Igc2VsZi5hYm9vbGVhbnMgb3Igc2VsZi53cml0ZXVz
ZXIgb3Igc2VsZi53cml0ZXNldXNlciBvciBzZWxmLndyaXRlcG9ydCBvciBzZWxmLndyaXRlZmNv
bnRleHQgb3Igc2VsZi53cml0ZWludGVyZmFjZSBvciBzZWxmLndyaXRlYm9vbGVhbiBvciBzZWxm
LndyaXRlYWJvb2xlYW4gb3Igc2VsZi5ub2RlcyBvciBzZWxmLndyaXRlbm9kZSk8YnI+DQotPGJy
Pg0KLcKgIMKgIMKgIMKgZGVmIHJ1bihzZWxmLCBoYW5kbGUpOjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChzZWxmLnVzZXJzIG9yIHNlbGYuYWxsKTogPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi50ZXN0X3VzZXJzKGhhbmRsZSk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsmcXVvdDs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsZi5zZXVzZXJzIG9yIHNlbGYuYWxsKTogPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi50ZXN0X3NldXNlcnMo
aGFuZGxlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZx
dW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzZWxmLnBvcnRzIG9y
IHNlbGYuYWxsKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxm
LnRlc3RfcG9ydHMoaGFuZGxlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHByaW50ICZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChz
ZWxmLm1vZHVsZXMgb3Igc2VsZi5hbGwpOiA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzZWxmLnRlc3RfbW9kdWxlcyhoYW5kbGUpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKHNlbGYuZmNvbnRleHRzIG9yIHNlbGYuYWxsKTo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnRlc3RfZmNvbnRleHRzKGhhbmRsZSk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsmcXVv
dDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsZi5pbnRlcmZhY2VzIG9yIHNl
bGYuYWxsKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnRl
c3RfaW50ZXJmYWNlcyhoYW5kbGUpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KHNlbGYuYm9vbGVhbnMgb3Igc2VsZi5hbGwpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNlbGYudGVzdF9ib29sZWFucyhoYW5kbGUpPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKHNlbGYuYWJvb2xlYW5zIG9yIHNlbGYuYWxsKTo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnRlc3RfYWJvb2xlYW5zKGhhbmRs
ZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsm
cXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsZi5ub2RlcyBvciBzZWxm
LmFsbCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi50ZXN0
X25vZGVzKGhhbmRsZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBw
cmludCAmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsZi53
cml0ZXVzZXIgb3Igc2VsZi5hbGwpOiA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzZWxmLnRlc3Rfd3JpdGV1c2VyKGhhbmRsZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAoc2VsZi53cml0ZXNldXNlciBvciBzZWxmLmFsbCk6IDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYudGVzdF93cml0ZXNldXNlcihoYW5k
bGUpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7
JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNlbGYud3JpdGVwb3J0IG9y
IHNlbGYuYWxsKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxm
LnRlc3Rfd3JpdGVwb3J0KGhhbmRsZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBwcmludCAmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoc2VsZi53cml0ZWZjb250ZXh0IG9yIHNlbGYuYWxsKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnRlc3Rfd3JpdGVmY29udGV4dCg8d2JyPmhhbmRsZSk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsmcXVv
dDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2VsZi53cml0ZWludGVyZmFjZSBv
ciBzZWxmLmFsbCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vs
Zi50ZXN0X3dyaXRlaW50ZXJmYWNlKDx3YnI+aGFuZGxlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChzZWxmLndyaXRlYm9vbGVhbiBvciBzZWxmLmFsbCk6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi50ZXN0X3dyaXRlYm9vbGVhbihoYW5k
bGUpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7
JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNlbGYud3JpdGVhYm9vbGVh
biBvciBzZWxmLmFsbCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c2VsZi50ZXN0X3dyaXRlYWJvb2xlYW4oPHdicj5oYW5kbGUpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKHNlbGYud3JpdGVub2RlIG9yIHNlbGYuYWxsKTo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLnRlc3Rfd3JpdGVub2RlKGhhbmRsZSk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDsmcXVv
dDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZGVmIHRlc3RfbW9kdWxlcyhzZWxmLHNoKTo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUZXN0aW5nIG1vZHVsZXMuLi4m
cXVvdDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHRyYW5zX2NudCwgbWxp
c3QsIG1saXN0X3NpemUpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfbW9kdWxlX2xpc3QoPHdicj5zaCk8
YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VHJhbnNhY3Rp
b24gbnVtYmVyOiAmcXVvdDssIHRyYW5zX2NudDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHByaW50ICZxdW90O01vZHVsZSBsaXN0IHNpemU6ICZxdW90OywgbWxpc3Rfc2l6ZTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7TGlzdCBy
ZWZlcmVuY2U6ICZxdW90OywgbWxpc3Q8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKG1saXN0X3NpemUgPT0gMCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcHJpbnQgJnF1b3Q7Tm8gbW9kdWxlcyBpbnN0YWxsZWQhJnF1b3Q7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGhpcyBpcyBub3Qg
bmVjZXNzYXJpbHkgYSB0ZXN0IGZhaWx1cmUuJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9y
IGlkeCBpbiByYW5nZShtbGlzdF9zaXplKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBtb2R1bGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9tb2R1bGVfbGlzdF88d2JyPm50
aChtbGlzdCwgaWR4KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7TW9kdWxlIHJlZmVyZW5jZTogJnF1b3Q7LCBtb2R1
bGU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtN
b2R1bGUgbmFtZTogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9tb2R1bGVfZ2V0Xzx3YnI+bmFt
ZShtb2R1bGUpPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGRlZiB0ZXN0X3NldXNlcnMoc2VsZixz
aCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGVzdGluZyBzZXVz
ZXJzLi4uJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMs
IHNsaXN0KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl9saXN0KDx3YnI+c2gpPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgbGlzdCBz
ZXVzZXJzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1F1
ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICggbGVuKHNsaXN0KSA9PSAwKTo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtObyBzZXVzZXJzIGZvdW5k
ISZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZx
dW90O1RoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgdGVzdCBmYWlsdXJlLiZxdW90Ozxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZvciBzZXVzZXIgaW4gc2xpc3Q6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtzZXNldXNlciBy
ZWZlcmVuY2U6ICZxdW90Oywgc2V1c2VyIDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHByaW50ICZxdW90O3NldXNlciBuYW1lOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFu
YWdlX3NldXNlcl9nZXRfPHdicj5uYW1lKHNldXNlcik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDvCoCDCoHNldXNlciBtbHMgcmFuZ2U6ICZxdW90
Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2JyPm1sc3JhbmdlKHNldXNlcik8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDvCoCDCoHNl
dXNlciBzZW5hbWU6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2JyPnNl
bmFtZShzZXVzZXIpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vt
YW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2ZyZWUoPHdicj5zZXVzZXIpwqAgwqAgwqAgwqAgwqAgwqA8
YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZGVmIHRlc3RfdXNlcnMoc2VsZixzaCk6PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGVzdGluZyB1c2Vycy4uLiZxdW90Ozxi
cj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCB1bGlzdCkgPSBzZW1h
bmFnZS5zZW1hbmFnZV91c2VyX2xpc3QoPHdicj5zaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBsaXN0IHVzZXJzJnF1b3Q7KTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0
IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmICggbGVuKHVsaXN0KSA9PSAwKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwcmludCAmcXVvdDtObyB1c2VycyBmb3VuZCEmcXVvdDs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUaGlzIGlzIG5vdCBuZWNl
c3NhcmlseSBhIHRlc3QgZmFpbHVyZS4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm48YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgdXNl
ciBpbiB1bGlzdDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBz
ZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1VzZXIgcmVmZXJlbmNlOiAmcXVvdDssIHVzZXIgPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VXNlciBu
YW1lOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0Xzx3YnI+bmFtZSh1c2VyKTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O8KgIMKg
VXNlciBsYWJlbGluZyBwcmVmaXg6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9nZXRf
PHdicj5wcmVmaXgodXNlcik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBwcmludCAmcXVvdDvCoCDCoFVzZXIgbWxzIGxldmVsOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFu
YWdlX3VzZXJfZ2V0Xzx3YnI+bWxzbGV2ZWwodXNlcik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDvCoCDCoFVzZXIgbWxzIHJhbmdlOiAmcXVvdDss
IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0Xzx3YnI+bWxzcmFuZ2UodXNlcik8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDvCoCDCoFVzZXIgbnVt
YmVyIG9mIHJvbGVzOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0Xzx3YnI+bnVt
X3JvbGVzKHVzZXIpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnQgJnF1b3Q7wqAgwqBVc2VyIHJvbGVzOiAmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBybGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV91c2Vy
X2dldF88d2JyPnJvbGVzKHNoLCB1c2VyKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGdldCB1
c2VyIHJvbGVzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZv
ciByb2xlIGluIHJsaXN0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHByaW50ICZxdW90O8KgIMKgIMKgICZxdW90Oywgcm9sZTxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV91
c2VyX2ZyZWUoPHdicj51c2VyKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBkZWYgdGVzdF9wb3J0
cyhzZWxmLHNoKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUZXN0
aW5nIHBvcnRzLi4uJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChz
dGF0dXMsIHBsaXN0KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfbGlzdCg8d2JyPnNoKTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGxp
c3QgcG9ydHMmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7
UXVlcnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCBsZW4ocGxpc3QpID09IDApOjxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O05vIHBvcnRzIGZvdW5k
ISZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZx
dW90O1RoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgdGVzdCBmYWlsdXJlLiZxdW90Ozxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZvciBwb3J0IGluIHBsaXN0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7UG9ydCByZWZlcmVu
Y2U6ICZxdW90OywgcG9ydDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGxvdyA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfZ2V0Xzx3YnI+bG93KHBvcnQpPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaGlnaCA9IHNlbWFuYWdlLnNlbWFuYWdl
X3BvcnRfZ2V0Xzx3YnI+aGlnaChwb3J0KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNvbiA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfZ2V0Xzx3YnI+Y29uKHBvcnQp
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJvdG8gPSBzZW1hbmFn
ZS5zZW1hbmFnZV9wb3J0X2dldF88d2JyPnByb3RvKHBvcnQpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJvdG9fc3RyID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9n
ZXRfPHdicj5wcm90b19zdHIocHJvdG8pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgbG93ID09IGhpZ2g6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFuZ2Vfc3RyID0gc3RyKGxvdyk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhbmdlX3N0ciA9IHN0cihsb3cpICsgJnF1b3Q7
LSZxdW90OyArIHN0cihoaWdoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoChyYywgY29uX3N0cikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3RvXzx3YnI+c3Ry
aW5nKHNoLGNvbik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBy
YyAmbHQ7IDA6IGNvbl9zdHIgPSAmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtQb3J0OiAmcXVvdDssIHJhbmdlX3N0ciwgJnF1
b3Q7ICZxdW90OywgcHJvdG9fc3RyLCAmcXVvdDsgQ29udGV4dDogJnF1b3Q7LCBjb25fc3RyPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2Vf
cG9ydF9mcmVlKDx3YnI+cG9ydCk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZGVmIHRlc3RfZmNv
bnRleHRzKHNlbGYsc2gpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90
O1Rlc3RpbmcgZmlsZSBjb250ZXh0cy4uLiZxdW90Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAoc3RhdHVzLCBmbGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88
d2JyPmxpc3Qoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigm
cXVvdDtDb3VsZCBub3QgbGlzdCBmaWxlIGNvbnRleHRzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZx
dW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChsZW4o
Zmxpc3QpID09IDApOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBy
aW50ICZxdW90O05vIGZpbGUgY29udGV4dHMgZm91bmQhJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGhpcyBpcyBub3QgbmVjZXNzYXJp
bHkgYSB0ZXN0IGZhaWx1cmUuJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIGZjb24gaW4g
Zmxpc3Q6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52
ZXJib3NlOiBwcmludCAmcXVvdDtGaWxlIENvbnRleHQgcmVmZXJlbmNlOiAmcXVvdDssIGZjb248
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleHByID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfZmNvbnRleHRfPHdicj5nZXRfZXhwcihmY29uKTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHR5cGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88
d2JyPmdldF90eXBlKGZjb24pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdHlwZV9zdHIgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPmdldF90eXBlX3N0
cih0eXBlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbiA9IHNl
bWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3YnI+Z2V0X2NvbihmY29uKTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG5vdCBjb246IDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbl9zdHIgPSAmcXVvdDsmbHQ7
Jmx0O25vbmUmZ3Q7Jmd0OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVsc2U6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKHJjLCBjb25fc3RyKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfdG9fPHdi
cj5zdHJpbmcoc2gsY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIHJjICZsdDsgMDogY29uX3N0ciA9ICZxdW90OyZxdW90Ozxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O0ZpbGUgRXhwcjog
JnF1b3Q7LCBleHByLCAmcXVvdDsgWyZxdW90OywgdHlwZV9zdHIsICZxdW90O10gQ29udGV4dDog
JnF1b3Q7LCBjb25fc3RyPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5mcmVlKGZjb24pPGJyPg0KLTxicj4NCi3C
oCDCoCDCoCDCoGRlZiB0ZXN0X2ludGVyZmFjZXMoc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGVzdGluZyBuZXR3b3JrIGludGVyZmFjZXMuLi4mcXVv
dDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cywgaWxpc3QpID0g
c2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfbGlzdCg8d2JyPnNoKTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGxpc3QgaW50ZXJmYWNlcyZx
dW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtRdWVyeSBzdGF0
dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAobGVuKGlsaXN0KSA9PSAwKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtObyBuZXR3b3JrIGludGVyZmFjZXMgZm91
bmQhJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQg
JnF1b3Q7VGhpcyBpcyBub3QgbmVjZXNzYXJpbHkgYSB0ZXN0IGZhaWx1cmUuJnF1b3Q7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZm9yIGlmYWNlIGluIGlsaXN0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7SW50ZXJmYWNl
IHJlZmVyZW5jZTogJnF1b3Q7LCBpZmFjZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG5hbWUgPSBzZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV9nZXRfPHdicj5uYW1lKGlm
YWNlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1zZ19jb24gPSBz
ZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV9nZXRfPHdicj5tc2djb24oaWZhY2UpPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWZfY29uID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vf
aWZhY2VfZ2V0Xzx3YnI+aWZjb24oaWZhY2UpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKHJjLCBtc2dfY29uX3N0cikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0
X3RvXzx3YnI+c3RyaW5nKHNoLG1zZ19jb24pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgcmMgJmx0OyAwOiBtc2dfY29uX3N0ciA9ICZxdW90OyZxdW90Ozxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChyYywgaWZfY29uX3N0cikgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3RvXzx3YnI+c3RyaW5nKHNoLCBpZl9jb24pPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgcmMgJmx0OyAwOiBpZl9jb25f
c3RyID0gJnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcHJpbnQgJnF1b3Q7SW50ZXJmYWNlOiAmcXVvdDssIG5hbWUsICZxdW90OyBDb250ZXh0OiAm
cXVvdDssIGlmX2Nvbl9zdHIsICZxdW90OyBNZXNzYWdlIENvbnRleHQ6ICZxdW90OywgbXNnX2Nv
bl9zdHI8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5z
ZW1hbmFnZV9pZmFjZV9mcmVlKDx3YnI+aWZhY2UpPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGRl
ZiB0ZXN0X2Jvb2xlYW5zKHNlbGYsc2gpOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBy
aW50ICZxdW90O1Rlc3RpbmcgYm9vbGVhbnMuLi4mcXVvdDs8YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKHN0YXR1cywgYmxpc3QpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9s
aXN0KDx3YnI+c2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigm
cXVvdDtDb3VsZCBub3QgbGlzdCBib29sZWFucyZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBwcmludCAmcXVvdDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDss
IHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobGVuKGJsaXN0
KSA9PSAwKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAm
cXVvdDtObyBib29sZWFucyBmb3VuZCEmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUaGlzIGlzIG5vdCBuZWNlc3NhcmlseSBhIHRlc3Qg
ZmFpbHVyZS4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm48YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgcGJvb2wgaW4gYmxpc3Q6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBw
cmludCAmcXVvdDtCb29sZWFuIHJlZmVyZW5jZTogJnF1b3Q7LCBwYm9vbDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5hbWUgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29s
X2dldF88d2JyPm5hbWUocGJvb2wpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgdmFsdWUgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2dldF88d2JyPnZhbHVlKHBib29s
KSA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtC
b29sZWFuOiAmcXVvdDssIG5hbWUsICZxdW90OyBWYWx1ZTogJnF1b3Q7LCB2YWx1ZTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xf
ZnJlZSg8d2JyPnBib29sKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBkZWYgdGVzdF9hYm9vbGVh
bnMoc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGVz
dGluZyBhY3RpdmUgYm9vbGVhbnMuLi4mcXVvdDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKHN0YXR1cywgYWJsaXN0KSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfbGlzdF88
d2JyPmFjdGl2ZShzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0
OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9y
KCZxdW90O0NvdWxkIG5vdCBsaXN0IGFjdGl2ZSBib29sZWFucyZxdW90Oyk8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIp
OiAmcXVvdDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
bGVuKGFibGlzdCkgPT0gMCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHByaW50ICZxdW90O05vIGFjdGl2ZSBib29sZWFucyBmb3VuZCEmcXVvdDs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUaGlzIGlzIG5vdCBu
ZWNlc3NhcmlseSBhIHRlc3QgZmFpbHVyZS4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm48YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3Ig
YWJvb2wgaW4gYWJsaXN0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7QWN0aXZlIGJvb2xlYW4gcmVmZXJlbmNlOiAm
cXVvdDssIGFib29sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFt
ZSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfZ2V0Xzx3YnI+bmFtZShhYm9vbCk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWx1ZSA9IHNlbWFuYWdlLnNlbWFuYWdl
X2Jvb2xfZ2V0Xzx3YnI+dmFsdWUoYWJvb2wpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7QWN0aXZlIEJvb2xlYW46ICZxdW90OywgbmFtZSwgJnF1
b3Q7IFZhbHVlOiAmcXVvdDssIHZhbHVlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9mcmVlKDx3YnI+YWJvb2wpPGJyPg0KLTxi
cj4NCi3CoCDCoCDCoCDCoGRlZiB0ZXN0X25vZGVzKHNlbGYsc2gpOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1Rlc3RpbmcgbmV0d29yayBub2Rlcy4uLiZxdW90Ozxi
cj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBubGlzdCkgPSBzZW1h
bmFnZS5zZW1hbmFnZV9ub2RlX2xpc3QoPHdicj5zaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBsaXN0IG5ldHdvcmsgbm9kZXMmcXVv
dDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVz
IChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGxlbihubGlzdCkgPT0gMCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Tm8gbmV0d29yayBub2RlcyBmb3VuZCEmcXVv
dDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtU
aGlzIGlzIG5vdCBuZWNlc3NhcmlseSBhIHRlc3QgZmFpbHVyZS4mcXVvdDs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm48YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBmb3Igbm9kZSBpbiBubGlzdDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O05ldHdvcmsgbm9kZSByZWZl
cmVuY2U6ICZxdW90Oywgbm9kZTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAoc3RhdHVzLCBhZGRyKSA9IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfZ2V0Xzx3
YnI+YWRkcihzaCwgbm9kZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiBzdGF0dXMgJmx0OyAwOiBhZGRyID0gJnF1b3Q7JnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsIG1hc2spID0gc2VtYW5hZ2Uu
c2VtYW5hZ2Vfbm9kZV9nZXRfPHdicj5tYXNrKHNoLCBub2RlKTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6IG1hc2sgPSAmcXVvdDsmcXVv
dDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJvdG8g
PSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2dldF88d2JyPnByb3RvKG5vZGUpPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJvdG9fc3RyID0gc2VtYW5hZ2Uuc2VtYW5h
Z2Vfbm9kZV9nZXRfPHdicj5wcm90b19zdHIocHJvdG8pwqAgwqAgwqAgwqAgwqA8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb24gPSBzZW1hbmFnZS5zZW1hbmFnZV9u
b2RlX2dldF88d2JyPmNvbihub2RlKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBjb25fc3RyKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRl
eHRfdG9fPHdicj5zdHJpbmcoc2gsIGNvbik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOiBjb25fc3RyID0gJnF1b3Q7JnF1b3Q7PGJyPg0K
LTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O05l
dHdvcmsgTm9kZTogJnF1b3Q7LCBhZGRyLCAmcXVvdDsvJnF1b3Q7LCBtYXNrLCAmcXVvdDsgKCZx
dW90OywgcHJvdG9fc3RyLCAmcXVvdDspJnF1b3Q7LCAmcXVvdDtDb250ZXh0OiAmcXVvdDssIGNv
bl9zdHI8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5z
ZW1hbmFnZV9ub2RlX2ZyZWUoPHdicj5ub2RlKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBkZWYg
dGVzdF93cml0ZXVzZXIoc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnQgJnF1b3Q7VGVzdGluZyB1c2VyIHdyaXRlLi4uJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsIHVzZXIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9j
cmVhdGUoPHdicj5zaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0
OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9y
KCZxdW90O0NvdWxkIG5vdCBjcmVhdGUgdXNlciBvYmplY3QmcXVvdDspPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtVc2VyIG9iamVjdCBj
cmVhdGVkJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfc2V0Xzx3YnI+bmFtZShzaCx1c2VyLCAmcXVvdDt0ZXN0
UHlVc2VyJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IHNldCB1c2VyIG5hbWUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtVc2VyIG5hbWUgc2V0OiAmcXVv
dDssIHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0Xzx3YnI+bmFtZSh1c2VyKTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMg
PSBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX2FkZF88d2JyPnJvbGUoc2gsIHVzZXIsICZxdW90O3Vz
ZXJfciZxdW90OynCoCDCoCA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMg
Jmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBhZGQgcm9sZSZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9zZXRfPHdicj5w
cmVmaXgoc2gsdXNlciwgJnF1b3Q7dXNlciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgbGFiZWxpbmcgcHJlZml4JnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQg
JnF1b3Q7VXNlciBwcmVmaXggc2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0
Xzx3YnI+cHJlZml4KHVzZXIpPGJyPg0KLcKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9zZXRfPHdicj5tbHNyYW5n
ZShzaCwgdXNlciwgJnF1b3Q7czAmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IE1MUyByYW5nZSZxdW90Oyk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1VzZXIg
bWxzcmFuZ2U6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9nZXRfPHdicj5tbHNyYW5n
ZSh1c2VyKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1h
bmFnZS5zZW1hbmFnZV91c2VyX3NldF88d2JyPm1sc2xldmVsKHNoLCB1c2VyLCAmcXVvdDtzMCZx
dW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0Nv
dWxkIG5vdCBzZXQgTUxTIGxldmVsJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7VXNlciBtbHNsZXZlbDogJnF1b3Q7LCBzZW1h
bmFnZS5zZW1hbmFnZV91c2VyX2dldF88d2JyPm1sc2xldmVsKHVzZXIpPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsa2V5
KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfa2V5Xzx3YnI+ZXh0cmFjdChzaCx1c2VyKTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGV4
dHJhY3QgdXNlciBrZXkmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2Vs
Zi52ZXJib3NlOiBwcmludCAmcXVvdDtVc2VyIGtleSBleHRyYWN0ZWQ6ICZxdW90Oywga2V5PGJy
Pg0KLcKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cyxleGlz
dHMpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9leGlzdHNfPHdicj5sb2NhbChzaCxrZXkpPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qg
Y2hlY2sgaWYgdXNlciBleGlzdHMmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtFeGlzdHMgc3RhdHVzIChjb21taXQgbnVtYmVy
KTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
ZXhpc3RzOiA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVz
LCBvbGRfdXNlcikgPSBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX3F1ZXJ5Xzx3YnI+bG9jYWwoc2gs
IGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMg
Jmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBxdWVyeSBvbGQgdXNlciZxdW90Oyk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHBy
aW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJy
Pg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1N0YXJ0aW5nIHRy
YW5zYWN0aW9uLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFu
YWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX21vZGlmeV88d2JyPmxvY2FsKHNoLGtl
eSx1c2VyKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7
Q291bGQgbm90IG1vZGlmeSB1c2VyJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHRl
c3QgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQg
JnF1b3Q7Q29tbWl0IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8
YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0cmFuc2Fj
dGlvbiZxdW90Oyk8YnI+DQotIDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG5vdCBl
eGlzdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1
b3Q7UmVtb3ZpbmcgdXNlci4uLiZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZGVsXzx3YnI+bG9jYWwo
c2gsIGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0
dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBkZWxldGUgdGVzdCB1c2VyJnF1b3Q7
KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9z
ZTogcHJpbnQgJnF1b3Q7VXNlciBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZWxzZTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwcmludCAmcXVvdDtSZXNldHRpbmcgdXNlci4uLiZxdW90Ozxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJf
bW9kaWZ5Xzx3YnI+bG9jYWwoc2gsIGtleSwgb2xkX3VzZXIpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3Vs
ZCBub3QgcmVzZXQgdGVzdCB1c2VyJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7VXNlciBtb2RpZnk6ICZx
dW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rpb24m
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Q29tbWl0IHN0
YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9rZXlfPHdicj5mcmVl
KGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV91c2Vy
X2ZyZWUoPHdicj51c2VyKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czog
c2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9mcmVlKDx3YnI+b2xkX3VzZXIpPGJyPg0KLTxicj4NCi3C
oCDCoCDCoCDCoGRlZiB0ZXN0X3dyaXRlc2V1c2VyKHNlbGYsc2gpOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIHNldXNlciB3cml0ZS4uLiZxdW90Ozxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAoc3RhdHVzLCBzZXVzZXIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyXzx3YnI+Y3JlYXRl
KHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291
bGQgbm90IGNyZWF0ZSBTRVVzZXIgb2JqZWN0JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VVc2VyIG9iamVjdCBjcmVhdGVk
LiZxdW90Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1h
bmFnZS5zZW1hbmFnZV9zZXVzZXJfc2V0Xzx3YnI+bmFtZShzaCxzZXVzZXIsICZxdW90O3Rlc3RQ
eVNFVXNlciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0
OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9y
KCZxdW90O0NvdWxkIG5vdCBzZXQgbmFtZSZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFVXNlciBuYW1lIHNldDogJnF1b3Q7
LCBzZW1hbmFnZS5zZW1hbmFnZV9zZXVzZXJfZ2V0Xzx3YnI+bmFtZShzZXVzZXIpPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl9zZXRfPHdicj5zZW5hbWUoc2gsIHNldXNlciwg
JnF1b3Q7cm9vdCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMg
Jmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgc2VuYW1lJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFVXNlciBzZXVzZXI6ICZx
dW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2JyPnNlbmFtZShzZXVzZXIpPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX3NldF88d2JyPm1sc3JhbmdlKHNoLCBz
ZXVzZXIsICZxdW90O3MwOmMwLmMyNTUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IE1MUyByYW5nZSZxdW90Oyk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtT
RVVzZXIgbWxzcmFuZ2U6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2Jy
Pm1sc3JhbmdlKHNldXNlcik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cyxrZXkpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1
c2VyX2tleV88d2JyPmV4dHJhY3Qoc2gsc2V1c2VyKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGV4dHJhY3QgU0VVc2VyIGtleSZxdW90
Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOiBwcmludCAm
cXVvdDtTRVVzZXIga2V5IGV4dHJhY3RlZDogJnF1b3Q7LCBrZXk8YnI+DQotwqAgwqAgwqAgwqA8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKHN0YXR1cyxleGlzdHMpID0gc2VtYW5hZ2Uu
c2VtYW5hZ2Vfc2V1c2VyXzx3YnI+ZXhpc3RzX2xvY2FsKHNoLGtleSk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjaGVjayBpZiBTRVVz
ZXIgZXhpc3RzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVy
Ym9zZTogcHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywg
c3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBvbGRfc2V1c2Vy
KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl88d2JyPnF1ZXJ5X2xvY2FsKHNoLCBrZXkpPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlz
ZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIFNFVXNlciZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZx
dW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1N0YXJ0aW5nIHRyYW5zYWN0
aW9uLi4uJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0
cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3Rh
dHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyXzx3YnI+bW9kaWZ5X2xvY2FsKHNoLGtleSxz
ZXVzZXIpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3QgbW9kaWZ5IFNFVXNlciZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29tbWl0KHNoKTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1pdCB0
ZXN0IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmlu
dCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1
czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5z
ZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5z
YWN0aW9uJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBub3Qg
ZXhpc3RzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZx
dW90O1JlbW92aW5nIHNldXNlci4uLiZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl9kZWxfPHdicj5s
b2NhbChzaCwga2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGRlbGV0ZSB0ZXN0IFNFVXNl
ciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxm
LnZlcmJvc2U6IHByaW50ICZxdW90O1NldXNlciBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtSZXNldHRpbmcgc2V1c2VyLi4uJnF1b3Q7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2Vfc2V1c2VyXzx3YnI+bW9kaWZ5X2xvY2FsKHNoLCBrZXksIG9sZF9zZXVzZXIpPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBF
cnJvcigmcXVvdDtDb3VsZCBub3QgcmVzZXQgdGVzdCBTRVVzZXImcXVvdDspPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVv
dDtTZXVzZXIgbW9kaWZ5OiAmcXVvdDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29tbWl0KHNoKTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1p
dCByZXNldCB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnQgJnF1b3Q7Q29tbWl0IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBz
dGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5h
Z2Vfc2V1c2VyX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl9mcmVlKDx3YnI+c2V1c2VyKTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czogc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2ZyZWUo
PHdicj5vbGRfc2V1c2VyKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBkZWYgdGVzdF93cml0ZXBv
cnQoc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7VGVz
dGluZyBwb3J0IHdyaXRlLi4uJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoChzdGF0dXMsIHBvcnQpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9jcmVhdGUoPHdicj5z
aCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBjcmVhdGUgU0VQb3J0IG9iamVjdCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFUG9ydCBvYmplY3QgY3JlYXRlZC4m
cXVvdDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5h
Z2VfcG9ydF9zZXRfPHdicj5yYW5nZShwb3J0LDE1MCwyMDApPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgbG93ID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9nZXRfPHdicj5sb3cocG9ydCk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoaWdoID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9y
dF9nZXRfPHdicj5oaWdoKHBvcnQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2Vs
Zi52ZXJib3NlOiBwcmludCAmcXVvdDtTRVBvcnQgcmFuZ2Ugc2V0OiAmcXVvdDssIGxvdywgJnF1
b3Q7LSZxdW90OywgaGlnaDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfc2V0Xzx3YnI+cHJvdG8o
cG9ydCwgc2VtYW5hZ2UuU0VNQU5BR0VfUFJPVE9fVENQKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFUG9ydCBwcm90b2NvbCBzZXQ6
ICZxdW90OywgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbWFu
YWdlLnNlbWFuYWdlX3BvcnRfZ2V0Xzx3YnI+cHJvdG9fc3RyKHNlbWFuYWdlLlNFTUFOQUdFXzx3
YnI+UFJPVE9fVENQKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsIGNvbikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0
Xzx3YnI+Y3JlYXRlKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAm
bHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJy
b3IoJnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRUNvbnRleHQgb2JqZWN0JnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250
ZXh0IG9iamVjdCBjcmVhdGVkIChmb3IgcG9ydCkuJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfY29udGV4dF9zZXRfPHdicj51c2VyKHNoLCBjb24sICZxdW90O3N5c3RlbV91JnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291
bGQgbm90IHNldCBjb250ZXh0IHVzZXImcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUNvbnRleHQgdXNlcjogJnF1b3Q7LCBz
ZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X2dldF88d2JyPnVzZXIoY29uKTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNl
bWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+cm9sZShzaCwgY29uLCAmcXVvdDtvYmpl
Y3RfciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAw
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZx
dW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCByb2xlJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250ZXh0IHJvbGU6ICZx
dW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5yb2xlKGNvbik8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0
dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnR5cGUoc2gsIGNvbiwgJnF1
b3Q7aHR0cF9wb3J0X3QmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3Rh
dHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlz
ZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgdHlwZSZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFQ29udGV4
dCB0eXBlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+dHlwZShj
b24pPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdl
LnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+bWxzKHNoLCBjb24sICZxdW90O3MwOmMwLmMyNTUm
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3Qgc2V0IGNvbnRleHQgTUxTIGZpZWxkcyZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFQ29udGV4dCBtbHM6ICZx
dW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5tbHMoY29uKTxicj4NCi08
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9w
b3J0X3NldF88d2JyPmNvbihzaCwgcG9ydCwgY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBTRVBvcnQgY29udGV4dCZxdW90
Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZx
dW90O1NFUG9ydCBjb250ZXh0IHNldDogJnF1b3Q7LCBjb248YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsa2V5KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfa2V5
Xzx3YnI+ZXh0cmFjdChzaCxwb3J0KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0
YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGV4dHJhY3QgU0VQb3J0IGtleSZxdW90Oyk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFUG9y
dCBrZXkgZXh0cmFjdGVkOiAmcXVvdDssIGtleTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAoc3RhdHVzLGV4aXN0cykgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2V4aXN0c188
d2JyPmxvY2FsKHNoLGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMg
Jmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBjaGVjayBpZiBTRVBvcnQgZXhpc3RzJnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7RXhpc3Rz
IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBvbGRfcG9ydCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0
X3F1ZXJ5Xzx3YnI+bG9jYWwoc2gsIGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBxdWVy
eSBvbGQgU0VQb3J0JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQgbnVt
YmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNhY3Rpb24uLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5z
YWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1
b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KcKgIMKgIMKgPGJy
Pg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFu
YWdlX3BvcnRfbW9kaWZ5Xzx3YnI+bG9jYWwoc2gsa2V5LHBvcnQpPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgbW9kaWZ5IFNFUG9ydCZx
dW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfY29tbWl0KHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0
YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1pdCB0ZXN0IHRyYW5zYWN0aW9uJnF1b3Q7KTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRy
YW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2JlZ2luXzx3YnI+dHJhbnNh
Y3Rpb24oc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5hZ2UgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KLTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG5vdCBleGlzdHM6PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7UmVtb3ZpbmcgcG9ydCByYW5nZS4u
LiZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdGF0dXMg
PSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2RlbF88d2JyPmxvY2FsKHNoLCBrZXkpPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJv
cigmcXVvdDtDb3VsZCBub3QgZGVsZXRlIHRlc3QgU0VQb3J0JnF1b3Q7KTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90
O1BvcnQgcmFuZ2UgZGVsZXRlOiAmcXVvdDssIHN0YXR1czxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBlbHNlOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBy
aW50ICZxdW90O1Jlc2V0dGluZyBwb3J0IHJhbmdlLi4uJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9t
b2RpZnlfPHdicj5sb2NhbChzaCwga2V5LCBvbGRfcG9ydCk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCByZXNldCB0ZXN0IFNFUG9ydCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1BvcnQgcmFuZ2UgbW9k
aWZ5OiAmcXVvdDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHJlc2V0IHRyYW5z
YWN0aW9uJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O0Nv
bW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfPHdi
cj5mcmVlKGNvbik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFn
ZV9wb3J0X2tleV88d2JyPmZyZWUoa2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNl
bWFuYWdlLnNlbWFuYWdlX3BvcnRfZnJlZSg8d2JyPnBvcnQpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgZXhpc3RzOiBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2ZyZWUoPHdicj5vbGRf
cG9ydCk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZGVmIHRlc3Rfd3JpdGVmY29udGV4dChzZWxm
LHNoKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtUZXN0aW5nIGZp
bGUgY29udGV4dCB3cml0ZS4uLiZxdW90Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAoc3RhdHVzLCBmY29uKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3YnI+Y3Jl
YXRlKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7
Q291bGQgbm90IGNyZWF0ZSBTRUZjb250ZXh0IG9iamVjdCZxdW90Oyk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFRmNvbnRleHQgb2Jq
ZWN0IGNyZWF0ZWQuJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5zZXRfZXhw
cihzaCwgZmNvbiwgJnF1b3Q7L3Rlc3QvZmNvbnRleHQoLy4qKT8mcXVvdDspPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGV4cHJl
c3Npb24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3Nl
OiBwcmludCAmcXVvdDtTRUZDb250ZXh0IGV4cHIgc2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFu
YWdlX2Zjb250ZXh0Xzx3YnI+Z2V0X2V4cHIoZmNvbik8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5zZXRfdHlwZShmY29u
LCBzZW1hbmFnZS5TRU1BTkFHRV9GQ09OVEVYVF88d2JyPlJFRyk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnR5cGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPmdldF90
eXBlKGZjb24pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQg
JnF1b3Q7U0VGQ29udGV4dCB0eXBlIHNldDogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9mY29u
dGV4dF88d2JyPmdldF90eXBlX3N0cihmdHlwZSk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKHN0YXR1cywgY29uKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfPHdicj5j
cmVhdGUoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3QgY3JlYXRlIFNFQ29udGV4dCBvYmplY3QmcXVvdDspPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUNvbnRleHQgb2Jq
ZWN0IGNyZWF0ZWQgKGZvciBmaWxlIGNvbnRleHQpLiZxdW90Ozxicj4NCi08YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88
d2JyPnVzZXIoc2gsIGNvbiwgJnF1b3Q7c3lzdGVtX3UmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgdXNl
ciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHBy
aW50ICZxdW90O1NFQ29udGV4dCB1c2VyOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRl
eHRfZ2V0Xzx3YnI+dXNlcihjb24pPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+cm9sZShzaCwgY29u
LCAmcXVvdDtvYmplY3RfciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBz
dGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJh
aXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCByb2xlJnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250
ZXh0IHJvbGU6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5yb2xl
KGNvbik8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfY29udGV4dF9zZXRfPHdicj50eXBlKHNoLCBjb24sICZxdW90O2RlZmF1bHRf
dCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBzZXQgY29udGV4dCB0eXBlJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250ZXh0IHR5cGU6ICZxdW90
Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj50eXBlKGNvbik8YnI+DQotPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29u
dGV4dF9zZXRfPHdicj5tbHMoc2gsIGNvbiwgJnF1b3Q7czA6YzAuYzI1NSZxdW90Oyk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQg
Y29udGV4dCBNTFMgZmllbGRzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250ZXh0IG1sczogJnF1b3Q7LCBzZW1hbmFn
ZS5zZW1hbmFnZV9jb250ZXh0X2dldF88d2JyPm1scyhjb24pPGJyPg0KLTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3YnI+
c2V0X2NvbihzaCwgZmNvbiwgY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0
YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBTRUZjb250ZXh0IGNvbnRleHQmcXVvdDspPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtT
RUZjb250ZXh0IGNvbnRleHQgc2V0OiAmcXVvdDssIGNvbjxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAoc3RhdHVzLGtleSkgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88
d2JyPmtleV9leHRyYWN0KHNoLGZjb24pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
c3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
YWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgZXh0cmFjdCBTRUZjb250ZXh0IGtleSZxdW90Oyk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90
O1NFRmNvbnRleHQga2V5IGV4dHJhY3RlZDogJnF1b3Q7LCBrZXk8YnI+DQotPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cyxleGlzdHMpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNv
bnRleHRfPHdicj5leGlzdHNfbG9jYWwoc2gsa2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNoZWNrIGlmIFNFRmNvbnRleHQgZXhp
c3RzJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZl
cmJvc2U6IHByaW50ICZxdW90O0V4aXN0cyBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDss
IHN0YXR1czxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBvbGRfZmNvbnRleHQpID0g
c2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5xdWVyeV9sb2NhbChzaCwga2V5KTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2Ug
RXJyb3IoJnF1b3Q7Q291bGQgbm90IHF1ZXJ5IG9sZCBTRUZjb250ZXh0JnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQg
JnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQot
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNh
Y3Rpb24uLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1h
bmFnZS5zZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdl
IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPm1vZGlmeV9sb2NhbChzaCxr
ZXksZmNvbik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBtb2RpZnkgU0VGY29udGV4dCZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29tbWl0KHNoKTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNv
bW1pdCB0ZXN0IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHByaW50ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywg
c3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFu
YWdlLnNlbWFuYWdlX2JlZ2luXzx3YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5hZ2Ug
dHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IG5vdCBleGlzdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnQgJnF1b3Q7UmVtb3ZpbmcgZmlsZSBjb250ZXh0Li4uJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRl
eHRfPHdicj5kZWxfbG9jYWwoc2gsIGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBkZWxl
dGUgdGVzdCBTRUZjb250ZXh0JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7RmlsZSBjb250ZXh0IGRlbGV0
ZTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlOjxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1Jlc2V0dGlu
ZyBmaWxlIGNvbnRleHQuLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPm1vZGlmeV9s
b2NhbChzaCwga2V5LCBvbGRfZmNvbnRleHQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcmVz
ZXQgdGVzdCBGQ29udGV4dCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O0ZpbGUgY29udGV4dCBtb2RpZnk6
ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rp
b24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Q29tbWl0
IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF88d2JyPmZy
ZWUoY29uKcKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2Vt
YW5hZ2VfZmNvbnRleHRfPHdicj5rZXlfZnJlZShrZXkpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5mcmVlKGZjb24pPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgZXhpc3RzOiBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4
dF88d2JyPmZyZWUob2xkX2Zjb250ZXh0KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBkZWYgdGVz
dF93cml0ZWludGVyZmFjZShzZWxmLHNoKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBw
cmludCAmcXVvdDtUZXN0aW5nIG5ldHdvcmsgaW50ZXJmYWNlIHdyaXRlLi4uJnF1b3Q7PGJyPg0K
LTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsIGlmYWNlKSA9IHNlbWFuYWdl
LnNlbWFuYWdlX2lmYWNlXzx3YnI+Y3JlYXRlKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRUlmYWNlIG9iamVjdCZx
dW90OynCoCA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHBy
aW50ICZxdW90O1NFSWZhY2Ugb2JqZWN0IGNyZWF0ZWQuJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX3NldF88
d2JyPm5hbWUoc2gsIGlmYWNlLCAmcXVvdDt0ZXN0X2lmYWNlJnF1b3Q7KTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBTRUlmYWNl
IG5hbWUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3Nl
OiBwcmludCAmcXVvdDtTRUlmYWNlIG5hbWUgc2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdl
X2lmYWNlX2dldF88d2JyPm5hbWUoaWZhY2UpwqAgwqAgPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoChzdGF0dXMsIGNvbikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0Xzx3
YnI+Y3JlYXRlKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRUNvbnRleHQgb2JqZWN0JnF1b3Q7KTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VDb250ZXh0
IG9iamVjdCBjcmVhdGVkIChmb3IgbmV0d29yayBpbnRlcmZhY2UpJnF1b3Q7PGJyPg0KLTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRl
eHRfc2V0Xzx3YnI+dXNlcihzaCwgY29uLCAmcXVvdDtzeXN0ZW1fdSZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgaW50
ZXJmYWNlIGNvbnRleHQgdXNlciZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFQ29udGV4dCB1c2VyOiAmcXVvdDssIHNlbWFu
YWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+dXNlcihjb24pPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0
Xzx3YnI+cm9sZShzaCwgY29uLCAmcXVvdDtvYmplY3RfciZxdW90Oyk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgaW50ZXJmYWNl
IGNvbnRleHQgcm9sZSZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxm
LnZlcmJvc2U6IHByaW50ICZxdW90O1NFQ29udGV4dCByb2xlOiAmcXVvdDssIHNlbWFuYWdlLnNl
bWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+cm9sZShjb24pPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+
dHlwZShzaCwgY29uLCAmcXVvdDtkZWZhdWx0X3QmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGludGVyZmFjZSBjb250
ZXh0IHR5cGUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJi
b3NlOiBwcmludCAmcXVvdDtTRUNvbnRleHQgdHlwZTogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFn
ZV9jb250ZXh0X2dldF88d2JyPnR5cGUoY29uKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPm1scyhz
aCwgY29uLCAmcXVvdDtzMDpjMC5jMjU1JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBpbnRlcmZhY2UgY29udGV4dCBN
TFMgZmllbGRzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVy
Ym9zZTogcHJpbnQgJnF1b3Q7U0VDb250ZXh0IG1sczogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFn
ZV9jb250ZXh0X2dldF88d2JyPm1scyhjb24pPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX3NldF88d2JyPmlmY29uKHNo
LCBpZmFjZSwgY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IHNldCBTRUlmYWNlIGludGVyZmFjZSBjb250ZXh0JnF1b3Q7KTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VJ
ZmFjZSBpbnRlcmZhY2UgY29udGV4dCBzZXQ6ICZxdW90OywgY29uPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX3NldF88
d2JyPm1zZ2NvbihzaCwgaWZhY2UsIGNvbik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgU0VJZmFjZSBtZXNzYWdlIGNvbnRleHQm
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmlu
dCAmcXVvdDtTRUlmYWNlIG1lc3NhZ2UgY29udGV4dCBzZXQ6ICZxdW90OywgY29uPGJyPg0KLTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsa2V5KSA9IHNlbWFuYWdlLnNlbWFu
YWdlX2lmYWNlX2tleV88d2JyPmV4dHJhY3Qoc2gsaWZhY2UpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgZXh0cmFjdCBTRUlmYWNlIGtl
eSZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHBy
aW50ICZxdW90O1NFSWZhY2Uga2V5IGV4dHJhY3RlZDogJnF1b3Q7LCBrZXk8YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cyxleGlzdHMpID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfaWZhY2VfPHdicj5leGlzdHNfbG9jYWwoc2gsa2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNoZWNrIGlmIFNFSWZhY2UgZXhp
c3RzJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTog
cHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVz
PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBvbGRfaWZhY2UpID0gc2Vt
YW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfcXVlcnlfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IHF1ZXJ5IG9sZCBTRUlmYWNlJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7UXVl
cnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNhY3Rpb24uLi4m
cXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1h
bmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGJlZ2luIHNlbWFuYWdlIHRyYW5zYWN0
aW9uJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV88d2JyPm1vZGlmeV9sb2NhbChzaCxrZXksaWZhY2UpPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qg
bW9kaWZ5IFNFSWZhY2UmcXVvdDspPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgdGVzdCB0cmFu
c2FjdGlvbiZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtD
b21taXQgc3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCi08
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9i
ZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGJlZ2luIHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1
b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBub3QgZXhpc3RzOjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1JlbW92
aW5nIGludGVyZmFjZS4uLiZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX2RlbF88d2JyPmxvY2FsKHNo
LCBrZXkpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVz
ICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgZGVsZXRlIHRlc3QgU0VJZmFjZSZxdW90
Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJv
c2U6IHByaW50ICZxdW90O0ludGVyZmFjZSBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwcmludCAmcXVvdDtSZXNldHRpbmcgaW50ZXJmYWNlLi4uJnF1b3Q7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2VfaWZhY2VfPHdicj5tb2RpZnlfbG9jYWwoc2gsIGtleSwgb2xkX2lmYWNlKTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJy
b3IoJnF1b3Q7Q291bGQgbm90IHJlc2V0IHRlc3QgU0VJZmFjZSZxdW90Oyk8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90
O0ludGVyZmFjZSBtb2RpZnk6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21t
aXQgcmVzZXQgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cHJpbnQgJnF1b3Q7Q29tbWl0IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBz
dGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5h
Z2VfY29udGV4dF88d2JyPmZyZWUoY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNl
bWFuYWdlLnNlbWFuYWdlX2lmYWNlX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX2ZyZWUoPHdicj5pZmFjZSk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBleGlzdHM6IHNlbWFuYWdlLnNlbWFuYWdlX2lm
YWNlX2ZyZWUoPHdicj5vbGRfaWZhY2UpPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBkZWYgdGVz
dF93cml0ZWJvb2xlYW4oc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnQgJnF1b3Q7VGVzdGluZyBib29sZWFuIHdyaXRlLi4uJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMsIHBib29sKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jv
b2xfY3JlYXRlKDx3YnI+c2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVz
ICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBF
cnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFQm9vbCBvYmplY3QmcXVvdDspPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUJvb2wg
b2JqZWN0IGNyZWF0ZWQuJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfc2V0Xzx3YnI+bmFtZShzaCwgcGJvb2ws
ICZxdW90O2FsbG93X2V4ZWNtZW0mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IG5hbWUmcXVvdDspPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUJvb2wgbmFt
ZSBzZXQ6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9nZXRfPHdicj5uYW1lKHBib29s
KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV9i
b29sX3NldF88d2JyPnZhbHVlKHBib29sLCAwKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0Vib29sIHZhbHVlIHNldDogJnF1b3Q7LCBz
ZW1hbmFnZS5zZW1hbmFnZV9ib29sX2dldF88d2JyPnZhbHVlKHBib29sKTxicj4NCi08YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLGtleSkgPSBzZW1hbmFnZS5zZW1hbmFnZV9i
b29sX2tleV88d2JyPmV4dHJhY3Qoc2gsIHBib29sKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGV4dHJhY3QgU0VCb29sIGtleSZxdW90
Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZx
dW90O1NFQm9vbCBrZXkgZXh0cmFjdGVkOiAmcXVvdDssIGtleTxicj4NCi08YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLGV4aXN0cykgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29s
X2V4aXN0c188d2JyPmxvY2FsKHNoLGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjaGVjayBpZiBTRUJvb2wgZXhpc3RzJnF1b3Q7
KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1
b3Q7RXhpc3RzIHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RhdHVzLCBvbGRfYm9vbCkgPSBzZW1hbmFnZS5zZW1h
bmFnZV9ib29sX3F1ZXJ5Xzx3YnI+bG9jYWwoc2gsIGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBxdWVyeSBvbGQgU0VCb29sJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVzIChj
b21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNhY3Rpb24uLi4mcXVvdDs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9iZWdpbl88
d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2Ug
RXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxi
cj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1h
bmFnZV9ib29sX21vZGlmeV88d2JyPmxvY2FsKHNoLCBrZXksIHBib29sKTxicj4NCi08YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBtb2Rp
ZnkgU0VCb29sJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0
dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHRlc3QgdHJhbnNhY3Rp
b24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Q29tbWl0
IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5f
PHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0
dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0cmFuc2FjdGlvbiZxdW90Oyk8
YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgbm90IGV4aXN0czo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtSZW1vdmluZyBi
b29sZWFuLi4uJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9kZWxfPHdicj5sb2NhbChzaCwga2V5KTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGRlbGV0ZSB0ZXN0IFNFQm9vbCZxdW90Oyk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50
ICZxdW90O0Jvb2xlYW4gZGVsZXRlOiAmcXVvdDssIHN0YXR1czxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVsc2U6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cHJpbnQgJnF1b3Q7UmVzZXR0aW5nIGJvb2xlYW4uLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX21v
ZGlmeV88d2JyPmxvY2FsKHNoLCBrZXksIG9sZF9ib29sKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQg
bm90IHJlc2V0IHRlc3QgU0VCb29sJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7Qm9vbGVhbiBtb2RpZnk6
ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rp
b24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Q29tbWl0
IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9rZXlfPHdicj5m
cmVlKGtleSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV9i
b29sX2ZyZWUoPHdicj5wYm9vbCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBleGlz
dHM6IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfZnJlZSg8d2JyPm9sZF9ib29sKTxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqBkZWYgdGVzdF93cml0ZWFib29sZWFuKHNlbGYsc2gpOjxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1Rlc3RpbmcgYWN0aXZlIGJvb2xlYW4gd3Jp
dGUuLi4mcXVvdDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cywg
a2V5KSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfa2V5Xzx3YnI+Y3JlYXRlKHNoLCAmcXVvdDth
bGxvd19leGVjbWVtJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2Ug
RXJyb3IoJnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRUJvb2wga2V5JnF1b3Q7KTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQgJnF1b3Q7U0VCb29sIGtl
eSBjcmVhdGVkOiAmcXVvdDssIGtleTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAoc3RhdHVzLCBvbGRfYm9vbCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX3F1ZXJ5Xzx3YnI+
YWN0aXZlKHNoLCBrZXkpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZs
dDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJv
cigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIFNFQm9vbCZxdW90Oyk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAo
Y29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoChzdGF0dXMsIGFib29sKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfY3JlYXRl
KDx3YnI+c2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3QgY3JlYXRlIFNFQm9vbCBvYmplY3QmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUJvb2wgb2JqZWN0IGNy
ZWF0ZWQuJnF1b3Q7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfc2V0Xzx3YnI+bmFtZShzaCwgYWJvb2wsICZxdW90O2Fs
bG93X2V4ZWNtZW0mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVz
ICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBF
cnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IG5hbWUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUJvb2wgbmFtZSBzZXQ6ICZx
dW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9nZXRfPHdicj5uYW1lKGFib29sKTxicj4NCi08
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX3NldF88
d2JyPnZhbHVlKGFib29sLCAwKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYu
dmVyYm9zZTogcHJpbnQgJnF1b3Q7U0Vib29sIHZhbHVlIHNldDogJnF1b3Q7LCBzZW1hbmFnZS5z
ZW1hbmFnZV9ib29sX2dldF88d2JyPnZhbHVlKGFib29sKTxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtTdGFydGluZyB0cmFuc2FjdGlvbi4uLiZxdW90Ozxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jl
Z2luXzx3YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
c3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
YWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5hZ2UgdHJhbnNhY3Rpb24mcXVv
dDspPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdl
LnNlbWFuYWdlX2Jvb2xfc2V0Xzx3YnI+YWN0aXZlKHNoLGtleSxhYm9vbCk8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBtb2RpZnkgU0VC
b29sJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHRlc3QgdHJhbnNhY3Rpb24mcXVv
dDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7Q29tbWl0IHN0YXR1
cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQotPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7UmVzZXR0aW5nIG9sZCBhY3RpdmUgYm9vbGVh
bi4uLiZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdl
LnNlbWFuYWdlX2JlZ2luXzx3YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5hZ2UgdHJh
bnNhY3Rpb24mcXVvdDspPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfc2V0Xzx3YnI+YWN0aXZlKHNoLCBrZXksb2xkX2Jv
b2wpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3Vs
ZCBub3QgcmVzZXQgdGVzdCBTRUJvb2wmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtTRUJvb2wgYWN0aXZlIHJlc2V0OiAmcXVv
dDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHJlc2V0IHRyYW5zYWN0aW9uJnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O0NvbW1pdCBzdGF0
dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfa2V5Xzx3YnI+ZnJlZShr
ZXkpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9m
cmVlKDx3YnI+YWJvb2wpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2Vt
YW5hZ2VfYm9vbF9mcmVlKDx3YnI+b2xkX2Jvb2wpPGJyPg0KLTxicj4NCi08YnI+DQotwqAgwqAg
wqAgwqBkZWYgdGVzdF93cml0ZW5vZGUoc2VsZixzaCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcHJpbnQgJnF1b3Q7VGVzdGluZyBuZXR3b3JrIG5vZGUgd3JpdGUuLi4mcXVvdDs8YnI+
DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cywgbm9kZSkgPSBzZW1hbmFn
ZS5zZW1hbmFnZV9ub2RlX2NyZWF0ZSg8d2JyPnNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRU5vZGUgb2JqZWN0JnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQg
JnF1b3Q7U0VOb2RlIG9iamVjdCBjcmVhdGVkLiZxdW90Ozxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX3NldF88d2JyPmFk
ZHIoc2gsIG5vZGUsIHNlbWFuYWdlLlNFTUFOQUdFX1BST1RPX0lQNiwgJnF1b3Q7ZmZlZTpkZGRk
OjpiYmJiJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IHNldCBTRU5vZGUgYWRkcmVzcyZxdW90Oyk8YnI+DQotwqAgwqAgwqAg
wqA8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFn
ZV9ub2RlX3NldF88d2JyPm1hc2soc2gsIG5vZGUsIHNlbWFuYWdlLlNFTUFOQUdFX1BST1RPX0lQ
NiwgJnF1b3Q7OjpmZmZmOmZmZmY6YWJjZDowMDAwJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBTRU5vZGUgbmV0bWFz
ayZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2Vt
YW5hZ2Vfbm9kZV9zZXRfPHdicj5wcm90byhub2RlLCBzZW1hbmFnZS5TRU1BTkFHRV9QUk9UT19J
UDYpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVyYm9zZTogcHJpbnQg
JnF1b3Q7U0VOb2RlIHByb3RvY29sIHNldDogJnF1b3Q7LCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9nZXRfPHdicj5wcm90
b19zdHIoc2VtYW5hZ2UuU0VNQU5BR0VfPHdicj5QUk9UT19JUDYpPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cywgY29uKSA9
IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfPHdicj5jcmVhdGUoc2gpPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFQ29u
dGV4dCBvYmplY3QmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52
ZXJib3NlOiBwcmludCAmcXVvdDtTRUNvbnRleHQgb2JqZWN0IGNyZWF0ZWQgKGZvciBub2RlKS4m
cXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnVzZXIo
c2gsIGNvbiwgJnF1b3Q7c3lzdGVtX3UmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgdXNlciZxdW90Oyk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90
O1NFQ29udGV4dCB1c2VyOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3
YnI+dXNlcihjb24pPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9zZXRfPHdi
cj5yb2xlKHNoLCBjb24sICZxdW90O29iamVjdF9yJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBjb250ZXh0IHJvbGUm
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52ZXJib3NlOiBwcmlu
dCAmcXVvdDtTRUNvbnRleHQgcm9sZTogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0
X2dldF88d2JyPnJvbGUoY29uKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRf
c2V0Xzx3YnI+dHlwZShzaCwgY29uLCAmcXVvdDtsb19ub2RlX3QmcXVvdDspPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRl
eHQgdHlwZSZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJv
c2U6IHByaW50ICZxdW90O1NFQ29udGV4dCB0eXBlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdl
X2NvbnRleHRfZ2V0Xzx3YnI+dHlwZShjb24pPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+bWxzKHNo
LCBjb24sICZxdW90O3MwOmMwLmMyNTUmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgTUxTIGZpZWxkcyZx
dW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50
ICZxdW90O1NFQ29udGV4dCBtbHM6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9n
ZXRfPHdicj5tbHMoY29uKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0
dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX3NldF88d2JyPmNvbihzaCwgbm9kZSwgY29uKTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90
IHNldCBTRU5vZGUgY29udGV4dCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90O1NFTm9kZSBjb250ZXh0IHNldDogJnF1b3Q7LCBj
b248YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsa2V5KSA9IHNl
bWFuYWdlLnNlbWFuYWdlX25vZGVfa2V5Xzx3YnI+ZXh0cmFjdChzaCwgbm9kZSk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBleHRyYWN0
IFNFTm9kZSBrZXkmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc2VsZi52
ZXJib3NlOiBwcmludCAmcXVvdDtTRU5vZGUga2V5IGV4dHJhY3RlZDogJnF1b3Q7LCBrZXk8YnI+
DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cyxleGlzdHMpID0gc2VtYW5h
Z2Uuc2VtYW5hZ2Vfbm9kZV9leGlzdHNfPHdicj5sb2NhbChzaCxrZXkpPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY2hlY2sgaWYgU0VO
b2RlIGV4aXN0cyZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZl
cmJvc2U6IHByaW50ICZxdW90O0V4aXN0cyBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDss
IHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBleGlzdHM6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0YXR1cywgb2xkX25vZGUp
ID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9xdWVyeV88d2JyPmxvY2FsKHNoLCBrZXkpPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBF
cnJvcigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIFNFTm9kZSZxdW90Oyk8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzZWxmLnZlcmJvc2U6IHByaW50ICZxdW90
O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KLTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1N0YXJ0aW5nIHRyYW5zYWN0aW9u
Li4uJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0cmFu
c2FjdGlvbiZxdW90OynCoCDCoCDCoDxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX21vZGlmeV88d2JyPmxvY2FsKHNoLGtl
eSwgbm9kZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBtb2RpZnkgU0VOb2RlJnF1b3Q7KTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0
IHRlc3QgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnQgJnF1b3Q7Q29tbWl0IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0
dXM8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0cmFu
c2FjdGlvbiZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgbm90
IGV4aXN0czo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAm
cXVvdDtSZW1vdmluZyBuZXR3b3JrIG5vZGUuLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9kZWxf
PHdicj5sb2NhbChzaCwga2V5KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGRlbGV0ZSB0ZXN0
IFNFTm9kZSZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgc2VsZi52ZXJib3NlOiBwcmludCAmcXVvdDtOZXR3b3JrIG5vZGUgZGVsZXRlOiAmcXVvdDss
IHN0YXR1czxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlOjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZxdW90O1Jlc2V0dGluZyBuZXR3b3Jr
IG5vZGUuLi4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX21vZGlmeV88d2JyPmxvY2FsKHNoLCBrZXks
IG9sZF9ub2RlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0
YXR1cyAmbHQ7IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHJlc2V0IHRlc3QgU0VOb2RlJnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHNlbGYudmVy
Ym9zZTogcHJpbnQgJnF1b3Q7TmV0d29yayBub2RlIG1vZGlmeTogJnF1b3Q7LCBzdGF0dXM8YnI+
DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfY29tbWl0KHNoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IGNvbW1pdCByZXNldCB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFuc2FjdGlv
biBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0Xzx3YnI+ZnJlZShjb24pPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9rZXlfPHdicj5mcmVlKGtl
eSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2Zy
ZWUoPHdicj5ub2RlKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIGV4aXN0czogc2Vt
YW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9mcmVlKDx3YnI+b2xkX25vZGUpPGJyPg0KK8KgIMKgIGRlZiBf
X2luaXRfXyhzZWxmKTo8YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5hbGwgPSBGYWxzZTxicj4NCivC
oCDCoCDCoCDCoCBzZWxmLnVzZXJzID0gRmFsc2U8YnI+DQorwqAgwqAgwqAgwqAgc2VsZi53cml0
ZXVzZXIgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLnNldXNlcnMgPSBGYWxzZTxicj4N
CivCoCDCoCDCoCDCoCBzZWxmLndyaXRlc2V1c2VyID0gRmFsc2U8YnI+DQorwqAgwqAgwqAgwqAg
c2VsZi5wb3J0cyA9IEZhbHNlPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYud3JpdGVwb3J0ID0gRmFs
c2U8YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5mY29udGV4dHMgPSBGYWxzZTxicj4NCivCoCDCoCDC
oCDCoCBzZWxmLndyaXRlZmNvbnRleHQgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLmlu
dGVyZmFjZXMgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLndyaXRlaW50ZXJmYWNlID0g
RmFsc2U8YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5ib29sZWFucyA9IEZhbHNlPGJyPg0KK8KgIMKg
IMKgIMKgIHNlbGYud3JpdGVib29sZWFuID0gRmFsc2U8YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5h
Ym9vbGVhbnMgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLndyaXRlYWJvb2xlYW4gPSBG
YWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLm5vZGVzID0gRmFsc2U8YnI+DQorwqAgwqAgwqAg
wqAgc2VsZi53cml0ZW5vZGUgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLm1vZHVsZXMg
PSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLnZlcmJvc2UgPSBGYWxzZTxicj4NCis8YnI+
DQorwqAgwqAgZGVmIHNlbGVjdGVkKHNlbGYpOjxicj4NCivCoCDCoCDCoCDCoCByZXR1cm4gKHNl
bGYuYWxsIG9yIHNlbGYudXNlcnMgb3Igc2VsZi5tb2R1bGVzIG9yIHNlbGYuc2V1c2VycyBvciBz
ZWxmLnBvcnRzIG9yIHNlbGYuZmNvbnRleHRzIG9yIHNlbGYuaW50ZXJmYWNlcyBvciBzZWxmLmJv
b2xlYW5zIG9yIHNlbGYuYWJvb2xlYW5zIG9yIHNlbGYud3JpdGV1c2VyIG9yIHNlbGYud3JpdGVz
ZXVzZXIgb3Igc2VsZi53cml0ZXBvcnQgb3Igc2VsZi53cml0ZWZjb250ZXh0IG9yIHNlbGYud3Jp
dGVpbnRlcmZhY2Ugb3Igc2VsZi53cml0ZWJvb2xlYW4gb3Igc2VsZi53cml0ZWFib29sZWFuIG9y
IHNlbGYubm9kZXMgb3Igc2VsZi53cml0ZW5vZGUpPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgcnVu
KHNlbGYsIGhhbmRsZSk6PGJyPg0KK8KgIMKgIMKgIMKgIGlmIChzZWxmLnVzZXJzIG9yIHNlbGYu
YWxsKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi50ZXN0X3VzZXJzKGhhbmRsZSk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
IGlmIChzZWxmLnNldXNlcnMgb3Igc2VsZi5hbGwpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBz
ZWxmLnRlc3Rfc2V1c2VycyhoYW5kbGUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZx
dW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBpZiAoc2VsZi5wb3J0cyBvciBzZWxmLmFsbCk6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbGYudGVzdF9wb3J0cyhoYW5kbGUpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBpZiAo
c2VsZi5tb2R1bGVzIG9yIHNlbGYuYWxsKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi50
ZXN0X21vZHVsZXMoaGFuZGxlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDsm
cXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHNlbGYuZmNvbnRleHRzIG9yIHNlbGYuYWxsKTo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi50ZXN0X2Zjb250ZXh0cyhoYW5kbGUpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBp
ZiAoc2VsZi5pbnRlcmZhY2VzIG9yIHNlbGYuYWxsKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
c2VsZi50ZXN0X2ludGVyZmFjZXMoaGFuZGxlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmlu
dCAmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHNlbGYuYm9vbGVhbnMgb3Igc2Vs
Zi5hbGwpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnRlc3RfYm9vbGVhbnMoaGFuZGxl
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAg
wqAgwqAgaWYgKHNlbGYuYWJvb2xlYW5zIG9yIHNlbGYuYWxsKTo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgc2VsZi50ZXN0X2Fib29sZWFucyhoYW5kbGUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHByaW50ICZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBpZiAoc2VsZi5ub2RlcyBvciBz
ZWxmLmFsbCk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbGYudGVzdF9ub2RlcyhoYW5kbGUp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDC
oCDCoCBpZiAoc2VsZi53cml0ZXVzZXIgb3Igc2VsZi5hbGwpOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBzZWxmLnRlc3Rfd3JpdGV1c2VyKGhhbmRsZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIGlmIChzZWxmLndyaXRlc2V1c2Vy
IG9yIHNlbGYuYWxsKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi50ZXN0X3dyaXRlc2V1
c2VyKGhhbmRsZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIChzZWxmLndyaXRlcG9ydCBvciBzZWxmLmFsbCk6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHNlbGYudGVzdF93cml0ZXBvcnQoaGFuZGxlKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBwcmludCAmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHNlbGYu
d3JpdGVmY29udGV4dCBvciBzZWxmLmFsbCk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbGYu
dGVzdF93cml0ZWZjb250ZXh0KDx3YnI+aGFuZGxlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBw
cmludCAmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHNlbGYud3JpdGVpbnRlcmZh
Y2Ugb3Igc2VsZi5hbGwpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnRlc3Rfd3JpdGVp
bnRlcmZhY2UoPHdicj5oYW5kbGUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90
OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBpZiAoc2VsZi53cml0ZWJvb2xlYW4gb3Igc2VsZi5h
bGwpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLnRlc3Rfd3JpdGVib29sZWFuKGhhbmRs
ZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKg
IMKgIMKgIGlmIChzZWxmLndyaXRlYWJvb2xlYW4gb3Igc2VsZi5hbGwpOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBzZWxmLnRlc3Rfd3JpdGVhYm9vbGVhbig8d2JyPmhhbmRsZSk8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIGlmIChz
ZWxmLndyaXRlbm9kZSBvciBzZWxmLmFsbCk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbGYu
dGVzdF93cml0ZW5vZGUoaGFuZGxlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVv
dDsmcXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X21vZHVsZXMoc2VsZixzaCk6PGJy
Pg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1Rlc3RpbmcgbW9kdWxlcy4uLiZxdW90Ozxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgKHRyYW5zX2NudCwgbWxpc3QsIG1saXN0X3NpemUpID0gc2Vt
YW5hZ2Uuc2VtYW5hZ2VfbW9kdWxlX2xpc3QoPHdicj5zaCk8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIHByaW50ICZxdW90O1RyYW5zYWN0aW9uIG51bWJlcjogJnF1b3Q7LCB0cmFuc19jbnQ8YnI+
DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7TW9kdWxlIGxpc3Qgc2l6ZTogJnF1b3Q7LCBtbGlz
dF9zaXplPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcHJpbnQgJnF1b3Q7TGlzdCByZWZlcmVuY2U6ICZxdW90OywgbWxpc3Q8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIGlmIChtbGlzdF9zaXplID09IDApOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBwcmludCAmcXVvdDtObyBtb2R1bGVzIGluc3RhbGxlZCEmcXVvdDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7VGhpcyBpcyBub3QgbmVjZXNzYXJpbHkgYSB0ZXN0
IGZhaWx1cmUuJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjxicj4NCivCoCDC
oCDCoCDCoCBmb3IgaWR4IGluIHJhbmdlKG1saXN0X3NpemUpOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBtb2R1bGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9tb2R1bGVfbGlzdF88d2JyPm50aChtbGlz
dCwgaWR4KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O01vZHVsZSByZWZlcmVuY2U6ICZxdW90
OywgbW9kdWxlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O01vZHVsZSBuYW1l
OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX21vZHVsZV9nZXRfPHdicj5uYW1lKG1vZHVsZSk8
YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X3NldXNlcnMoc2VsZixzaCk6PGJyPg0KK8KgIMKg
IMKgIMKgIHByaW50ICZxdW90O1Rlc3Rpbmcgc2V1c2Vycy4uLiZxdW90Ozxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgKHN0YXR1cywgc2xpc3QpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2xp
c3QoPHdicj5zaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGxpc3Qgc2V1c2VycyZx
dW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQg
bnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmICggbGVu
KHNsaXN0KSA9PSAwKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7Tm8gc2V1
c2VycyBmb3VuZCEmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7VGhp
cyBpcyBub3QgbmVjZXNzYXJpbHkgYSB0ZXN0IGZhaWx1cmUuJnF1b3Q7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIHJldHVybjxicj4NCivCoCDCoCDCoCDCoCBmb3Igc2V1c2VyIGluIHNsaXN0Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHByaW50ICZxdW90O3Nlc2V1c2VyIHJlZmVyZW5jZTogJnF1b3Q7LCBzZXVz
ZXI8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7c2V1c2VyIG5hbWU6ICZxdW90
Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2JyPm5hbWUoc2V1c2VyKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDvCoCDCoHNldXNlciBtbHMgcmFuZ2U6ICZxdW90
Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88d2JyPm1sc3JhbmdlKHNldXNlcik8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7wqAgwqBzZXVzZXIgc2VuYW1lOiAmcXVv
dDssIHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl9nZXRfPHdicj5zZW5hbWUoc2V1c2VyKTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9zZXVzZXJfZnJlZSg8d2JyPnNl
dXNlcik8YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X3VzZXJzKHNlbGYsc2gpOjxicj4NCivC
oCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIHVzZXJzLi4uJnF1b3Q7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCAoc3RhdHVzLCB1bGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX2xp
c3QoPHdicj5zaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGxpc3QgdXNlcnMmcXVv
dDspPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51
bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiAoIGxlbih1
bGlzdCkgPT0gMCk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O05vIHVzZXJz
IGZvdW5kISZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtUaGlzIGlz
IG5vdCBuZWNlc3NhcmlseSBhIHRlc3QgZmFpbHVyZS4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcmV0dXJuPGJyPg0KK8KgIMKgIMKgIMKgIGZvciB1c2VyIGluIHVsaXN0Ojxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHByaW50ICZxdW90O1VzZXIgcmVmZXJlbmNlOiAmcXVvdDssIHVzZXI8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7VXNlciBuYW1lOiAmcXVvdDssIHNlbWFuYWdlLnNl
bWFuYWdlX3VzZXJfZ2V0Xzx3YnI+bmFtZSh1c2VyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBw
cmludCAmcXVvdDvCoCDCoFVzZXIgbGFiZWxpbmcgcHJlZml4OiAmcXVvdDssIHNlbWFuYWdlLnNl
bWFuYWdlX3VzZXJfZ2V0Xzx3YnI+cHJlZml4KHVzZXIpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHByaW50ICZxdW90O8KgIMKgVXNlciBtbHMgbGV2ZWw6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5h
Z2VfdXNlcl9nZXRfPHdicj5tbHNsZXZlbCh1c2VyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBw
cmludCAmcXVvdDvCoCDCoFVzZXIgbWxzIHJhbmdlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdl
X3VzZXJfZ2V0Xzx3YnI+bWxzcmFuZ2UodXNlcik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJp
bnQgJnF1b3Q7wqAgwqBVc2VyIG51bWJlciBvZiByb2xlczogJnF1b3Q7LCBzZW1hbmFnZS5zZW1h
bmFnZV91c2VyX2dldF88d2JyPm51bV9yb2xlcyh1c2VyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDvCoCDCoFVzZXIgcm9sZXM6ICZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCAoc3RhdHVzLCBybGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX2dldF88d2JyPnJv
bGVzKHNoLCB1c2VyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qg
Z2V0IHVzZXIgcm9sZXMmcXVvdDspPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBmb3Ig
cm9sZSBpbiBybGlzdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7
wqAgwqAgwqAgJnF1b3Q7LCByb2xlPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZW1h
bmFnZS5zZW1hbmFnZV91c2VyX2ZyZWUoPHdicj51c2VyKTxicj4NCis8YnI+DQorwqAgwqAgZGVm
IHRlc3RfcG9ydHMoc2VsZixzaCk6PGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1Rlc3Rp
bmcgcG9ydHMuLi4mcXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMsIHBsaXN0
KSA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfbGlzdCg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDC
oCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigm
cXVvdDtDb3VsZCBub3QgbGlzdCBwb3J0cyZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQg
JnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIGlmICggbGVuKHBsaXN0KSA9PSAwKTo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcHJpbnQgJnF1b3Q7Tm8gcG9ydHMgZm91bmQhJnF1b3Q7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIHByaW50ICZxdW90O1RoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgdGVzdCBmYWls
dXJlLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm48YnI+DQorwqAgwqAgwqAg
wqAgZm9yIHBvcnQgaW4gcGxpc3Q6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYudmVy
Ym9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UG9ydCByZWZl
cmVuY2U6ICZxdW90OywgcG9ydDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBsb3cgPSBzZW1hbmFn
ZS5zZW1hbmFnZV9wb3J0X2dldF88d2JyPmxvdyhwb3J0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBoaWdoID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9nZXRfPHdicj5oaWdoKHBvcnQpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIGNvbiA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfZ2V0Xzx3YnI+
Y29uKHBvcnQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByb3RvID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfcG9ydF9nZXRfPHdicj5wcm90byhwb3J0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcm90
b19zdHIgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2dldF88d2JyPnByb3RvX3N0cihwcm90byk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgbG93ID09IGhpZ2g6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJhbmdlX3N0ciA9IHN0cihsb3cpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IGVsc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhbmdlX3N0ciA9IHN0cihsb3cp
ICsgJnF1b3Q7LSZxdW90OyArIHN0cihoaWdoKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAocmMs
IGNvbl9zdHIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF90b188d2JyPnN0cmluZyhzaCxj
b24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHJjICZsdDsgMDogY29uX3N0ciA9ICZxdW90
OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtQb3J0OiAmcXVvdDss
IHJhbmdlX3N0ciwgJnF1b3Q7ICZxdW90OywgcHJvdG9fc3RyLCAmcXVvdDsgQ29udGV4dDogJnF1
b3Q7LCBjb25fc3RyPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX3Bv
cnRfZnJlZSg8d2JyPnBvcnQpPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgdGVzdF9mY29udGV4dHMo
c2VsZixzaCk6PGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1Rlc3RpbmcgZmlsZSBjb250
ZXh0cy4uLiZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cywgZmxpc3QpID0g
c2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5saXN0KHNoKTxicj4NCivCoCDCoCDCoCDC
oCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigm
cXVvdDtDb3VsZCBub3QgbGlzdCBmaWxlIGNvbnRleHRzJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1
czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgKGxlbihmbGlzdCkgPT0gMCk6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O05vIGZpbGUgY29udGV4dHMgZm91bmQhJnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1RoaXMgaXMgbm90IG5lY2Vzc2Fy
aWx5IGEgdGVzdCBmYWlsdXJlLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm48
YnI+DQorwqAgwqAgwqAgwqAgZm9yIGZjb24gaW4gZmxpc3Q6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQg
JnF1b3Q7RmlsZSBDb250ZXh0IHJlZmVyZW5jZTogJnF1b3Q7LCBmY29uPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIGV4cHIgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPmdldF9leHBy
KGZjb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHR5cGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9m
Y29udGV4dF88d2JyPmdldF90eXBlKGZjb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHR5cGVf
c3RyID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5nZXRfdHlwZV9zdHIodHlwZSk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgY29uID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRf
PHdicj5nZXRfY29uKGZjb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIG5vdCBjb246PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbl9zdHIgPSAmcXVvdDsmbHQ7Jmx0O25vbmUm
Z3Q7Jmd0OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBlbHNlOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAocmMsIGNvbl9zdHIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4
dF90b188d2JyPnN0cmluZyhzaCxjb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
IHJjICZsdDsgMDogY29uX3N0ciA9ICZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtGaWxlIEV4cHI6ICZxdW90OywgZXhwciwgJnF1b3Q7IFsmcXVvdDssIHR5
cGVfc3RyLCAmcXVvdDtdIENvbnRleHQ6ICZxdW90OywgY29uX3N0cjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPmZyZWUoZmNvbik8YnI+DQor
PGJyPg0KK8KgIMKgIGRlZiB0ZXN0X2ludGVyZmFjZXMoc2VsZixzaCk6PGJyPg0KK8KgIMKgIMKg
IMKgIHByaW50ICZxdW90O1Rlc3RpbmcgbmV0d29yayBpbnRlcmZhY2VzLi4uJnF1b3Q7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBpbGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9p
ZmFjZV9saXN0KDx3YnI+c2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBsaXN0IGlu
dGVyZmFjZXMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1
cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCBpZiAobGVuKGlsaXN0KSA9PSAwKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1
b3Q7Tm8gbmV0d29yayBpbnRlcmZhY2VzIGZvdW5kISZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBwcmludCAmcXVvdDtUaGlzIGlzIG5vdCBuZWNlc3NhcmlseSBhIHRlc3QgZmFpbHVyZS4m
cXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuPGJyPg0KK8KgIMKgIMKgIMKgIGZv
ciBpZmFjZSBpbiBpbGlzdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3Nl
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtJbnRlcmZhY2UgcmVm
ZXJlbmNlOiAmcXVvdDssIGlmYWNlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIG5hbWUgPSBzZW1h
bmFnZS5zZW1hbmFnZV9pZmFjZV9nZXRfPHdicj5uYW1lKGlmYWNlKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBtc2dfY29uID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfZ2V0Xzx3YnI+bXNnY29u
KGlmYWNlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZl9jb24gPSBzZW1hbmFnZS5zZW1hbmFn
ZV9pZmFjZV9nZXRfPHdicj5pZmNvbihpZmFjZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKHJj
LCBtc2dfY29uX3N0cikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3RvXzx3YnI+c3RyaW5n
KHNoLG1zZ19jb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHJjICZsdDsgMDogbXNnX2Nv
bl9zdHIgPSAmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKHJjLCBpZl9jb25f
c3RyKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfdG9fPHdicj5zdHJpbmcoc2gsIGlmX2Nv
bik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgcmMgJmx0OyAwOiBpZl9jb25fc3RyID0gJnF1
b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O0ludGVyZmFjZTog
JnF1b3Q7LCBuYW1lLCAmcXVvdDsgQ29udGV4dDogJnF1b3Q7LCBpZl9jb25fc3RyLCAmcXVvdDsg
TWVzc2FnZSBDb250ZXh0OiAmcXVvdDssIG1zZ19jb25fc3RyPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX2ZyZWUoPHdicj5pZmFjZSk8YnI+DQorPGJyPg0K
K8KgIMKgIGRlZiB0ZXN0X2Jvb2xlYW5zKHNlbGYsc2gpOjxicj4NCivCoCDCoCDCoCDCoCBwcmlu
dCAmcXVvdDtUZXN0aW5nIGJvb2xlYW5zLi4uJnF1b3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCAoc3RhdHVzLCBibGlzdCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2xpc3QoPHdicj5zaCk8
YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGxpc3QgYm9vbGVhbnMmcXVvdDspPGJyPg0K
K8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZx
dW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiAobGVuKGJsaXN0KSA9PSAw
KTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7Tm8gYm9vbGVhbnMgZm91bmQh
JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1RoaXMgaXMgbm90IG5l
Y2Vzc2FyaWx5IGEgdGVzdCBmYWlsdXJlLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm48YnI+DQorwqAgwqAgwqAgwqAgZm9yIHBib29sIGluIGJsaXN0Ojxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHByaW50ICZxdW90O0Jvb2xlYW4gcmVmZXJlbmNlOiAmcXVvdDssIHBib29sPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIG5hbWUgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2dldF88d2JyPm5hbWUo
cGJvb2wpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHZhbHVlID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vf
Ym9vbF9nZXRfPHdicj52YWx1ZShwYm9vbCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQg
JnF1b3Q7Qm9vbGVhbjogJnF1b3Q7LCBuYW1lLCAmcXVvdDsgVmFsdWU6ICZxdW90OywgdmFsdWU8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9mcmVlKDx3YnI+
cGJvb2wpPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgdGVzdF9hYm9vbGVhbnMoc2VsZixzaCk6PGJy
Pg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1Rlc3RpbmcgYWN0aXZlIGJvb2xlYW5zLi4uJnF1
b3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBhYmxpc3QpID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfYm9vbF9saXN0Xzx3YnI+YWN0aXZlKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
dGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3QgbGlzdCBhY3RpdmUgYm9vbGVhbnMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHBy
aW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiAobGVuKGFibGlzdCkgPT0gMCk6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHByaW50ICZxdW90O05vIGFjdGl2ZSBib29sZWFucyBmb3VuZCEmcXVvdDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7VGhpcyBpcyBub3QgbmVjZXNzYXJp
bHkgYSB0ZXN0IGZhaWx1cmUuJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjxi
cj4NCivCoCDCoCDCoCDCoCBmb3IgYWJvb2wgaW4gYWJsaXN0Ojxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50
ICZxdW90O0FjdGl2ZSBib29sZWFuIHJlZmVyZW5jZTogJnF1b3Q7LCBhYm9vbDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCBuYW1lID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9nZXRfPHdicj5uYW1l
KGFib29sKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB2YWx1ZSA9IHNlbWFuYWdlLnNlbWFuYWdl
X2Jvb2xfZ2V0Xzx3YnI+dmFsdWUoYWJvb2wpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50
ICZxdW90O0FjdGl2ZSBCb29sZWFuOiAmcXVvdDssIG5hbWUsICZxdW90OyBWYWx1ZTogJnF1b3Q7
LCB2YWx1ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2Zy
ZWUoPHdicj5hYm9vbCk8YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X25vZGVzKHNlbGYsc2gp
Ojxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIG5ldHdvcmsgbm9kZXMuLi4m
cXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMsIG5saXN0KSA9IHNlbWFuYWdl
LnNlbWFuYWdlX25vZGVfbGlzdCg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMg
Jmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBu
b3QgbGlzdCBuZXR3b3JrIG5vZGVzJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVv
dDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAgaWYgKGxlbihubGlzdCkgPT0gMCk6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHByaW50ICZxdW90O05vIG5ldHdvcmsgbm9kZXMgZm91bmQhJnF1b3Q7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1RoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgdGVzdCBm
YWlsdXJlLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm48YnI+DQorwqAgwqAg
wqAgwqAgZm9yIG5vZGUgaW4gbmxpc3Q6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYu
dmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7TmV0d29y
ayBub2RlIHJlZmVyZW5jZTogJnF1b3Q7LCBub2RlPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCAoc3RhdHVzLCBhZGRyKSA9IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfZ2V0Xzx3YnI+YWRk
cihzaCwgbm9kZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDogYWRk
ciA9ICZxdW90OyZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKHN0YXR1cywg
bWFzaykgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2dldF88d2JyPm1hc2soc2gsIG5vZGUpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6IG1hc2sgPSAmcXVvdDsmcXVv
dDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByb3RvID0gc2VtYW5hZ2Uuc2VtYW5h
Z2Vfbm9kZV9nZXRfPHdicj5wcm90byhub2RlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcm90
b19zdHIgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2dldF88d2JyPnByb3RvX3N0cihwcm90byk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgY29uID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9nZXRf
PHdicj5jb24obm9kZSk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsIGNv
bl9zdHIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF90b188d2JyPnN0cmluZyhzaCwgY29u
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOiBjb25fc3RyID0gJnF1
b3Q7JnF1b3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtOZXR3
b3JrIE5vZGU6ICZxdW90OywgYWRkciwgJnF1b3Q7LyZxdW90OywgbWFzaywgJnF1b3Q7ICgmcXVv
dDssIHByb3RvX3N0ciwgJnF1b3Q7KSZxdW90OywgJnF1b3Q7Q29udGV4dDogJnF1b3Q7LCBjb25f
c3RyPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfZnJlZSg8
d2JyPm5vZGUpPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgdGVzdF93cml0ZXVzZXIoc2VsZixzaCk6
PGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1Rlc3RpbmcgdXNlciB3cml0ZS4uLiZxdW90
Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cywgdXNlcikgPSBzZW1hbmFnZS5zZW1h
bmFnZV91c2VyX2NyZWF0ZSg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0
OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qg
Y3JlYXRlIHVzZXIgb2JqZWN0JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJv
c2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1VzZXIgb2JqZWN0IGNyZWF0
ZWQmcXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFu
YWdlX3VzZXJfc2V0Xzx3YnI+bmFtZShzaCx1c2VyLCAmcXVvdDt0ZXN0UHlVc2VyJnF1b3Q7KTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IHVzZXIgbmFtZSZxdW90Oyk8YnI+DQor
wqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmlu
dCAmcXVvdDtVc2VyIG5hbWUgc2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZ2V0
Xzx3YnI+bmFtZSh1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfdXNlcl9hZGRfPHdicj5yb2xlKHNoLCB1c2VyLCAmcXVvdDt1c2VyX3ImcXVv
dDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBhZGQgcm9sZSZxdW90Oyk8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfc2V0Xzx3
YnI+cHJlZml4KHNoLHVzZXIsICZxdW90O3VzZXImcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlm
IHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBzZXQgbGFiZWxpbmcgcHJlZml4JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBp
ZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1VzZXIg
cHJlZml4IHNldDogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV91c2VyX2dldF88d2JyPnByZWZp
eCh1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfdXNlcl9zZXRfPHdicj5tbHNyYW5nZShzaCwgdXNlciwgJnF1b3Q7czAmcXVvdDspPGJyPg0K
K8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJh
aXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgTUxTIHJhbmdlJnF1b3Q7KTxicj4NCivCoCDC
oCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZx
dW90O1VzZXIgbWxzcmFuZ2U6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9nZXRfPHdi
cj5tbHNyYW5nZSh1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfdXNlcl9zZXRfPHdicj5tbHNsZXZlbChzaCwgdXNlciwgJnF1b3Q7czAmcXVv
dDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgTUxTIGxldmVsJnF1b3Q7KTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHByaW50ICZxdW90O1VzZXIgbWxzbGV2ZWw6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNl
cl9nZXRfPHdicj5tbHNsZXZlbCh1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1
cyxrZXkpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9rZXlfPHdicj5leHRyYWN0KHNoLHVzZXIp
PGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBleHRyYWN0IHVzZXIga2V5JnF1b3Q7KTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHByaW50ICZxdW90O1VzZXIga2V5IGV4dHJhY3RlZDogJnF1b3Q7LCBrZXk8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIChzdGF0dXMsZXhpc3RzKSA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZXhp
c3RzXzx3YnI+bG9jYWwoc2gsa2V5KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAw
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY2hl
Y2sgaWYgdXNlciBleGlzdHMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9z
ZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1cyAoY29t
bWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiBl
eGlzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsIG9sZF91c2VyKSA9IHNlbWFu
YWdlLnNlbWFuYWdlX3VzZXJfcXVlcnlfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIHVzZXImcXVvdDspPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7
LCBzdGF0dXM8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1N0YXJ0aW5nIHRy
YW5zYWN0aW9uLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3Rh
dHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291
bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfdXNlcl9tb2RpZnlfPHdicj5sb2Nh
bChzaCxrZXksdXNlcik8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IG1vZGlmeSB1c2Vy
JnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfY29tbWl0KHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHRlc3Qg
dHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O0NvbW1pdCBz
dGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0
aW9uKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5hZ2UgdHJh
bnNhY3Rpb24mcXVvdDspPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiBub3QgZXhpc3RzOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtSZW1vdmluZyB1c2VyLi4uJnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJf
ZGVsXzx3YnI+bG9jYWwoc2gsIGtleSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc3RhdHVz
ICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7
Q291bGQgbm90IGRlbGV0ZSB0ZXN0IHVzZXImcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1
b3Q7VXNlciBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0KK8KgIMKgIMKgIMKgIGVsc2U6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1Jlc2V0dGluZyB1c2VyLi4uJnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJf
bW9kaWZ5Xzx3YnI+bG9jYWwoc2gsIGtleSwgb2xkX3VzZXIpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCByZXNldCB0ZXN0IHVzZXImcXVvdDspPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcHJpbnQgJnF1b3Q7VXNlciBtb2RpZnk6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KK8Kg
IMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rpb24mcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51
bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5z
ZW1hbmFnZV91c2VyX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFn
ZS5zZW1hbmFnZV91c2VyX2ZyZWUoPHdicj51c2VyKTxicj4NCivCoCDCoCDCoCDCoCBpZiBleGlz
dHM6IHNlbWFuYWdlLnNlbWFuYWdlX3VzZXJfZnJlZSg8d2JyPm9sZF91c2VyKTxicj4NCis8YnI+
DQorwqAgwqAgZGVmIHRlc3Rfd3JpdGVzZXVzZXIoc2VsZixzaCk6PGJyPg0KK8KgIMKgIMKgIMKg
IHByaW50ICZxdW90O1Rlc3Rpbmcgc2V1c2VyIHdyaXRlLi4uJnF1b3Q7PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCAoc3RhdHVzLCBzZXVzZXIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyXzx3
YnI+Y3JlYXRlKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFVXNl
ciBvYmplY3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VVc2VyIG9iamVjdCBjcmVhdGVkLiZxdW90
Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1
c2VyX3NldF88d2JyPm5hbWUoc2gsc2V1c2VyLCAmcXVvdDt0ZXN0UHlTRVVzZXImcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgbmFtZSZxdW90Oyk8YnI+DQorwqAgwqAg
wqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVv
dDtTRVVzZXIgbmFtZSBzZXQ6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2dldF88
d2JyPm5hbWUoc2V1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2Vfc2V1c2VyX3NldF88d2JyPnNlbmFtZShzaCwgc2V1c2VyLCAmcXVvdDtyb290
JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IHNlbmFtZSZxdW90Oyk8
YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtTRVVzZXIgc2V1c2VyOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX3Nl
dXNlcl9nZXRfPHdicj5zZW5hbWUoc2V1c2VyKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3Rh
dHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX3NldF88d2JyPm1sc3JhbmdlKHNoLCBzZXVz
ZXIsICZxdW90O3MwOmMwLmMyNTUmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAm
bHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5v
dCBzZXQgTUxTIHJhbmdlJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFVXNlciBtbHNyYW5nZTogJnF1
b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9zZXVzZXJfZ2V0Xzx3YnI+bWxzcmFuZ2Uoc2V1c2VyKTxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cyxrZXkpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vf
c2V1c2VyX2tleV88d2JyPmV4dHJhY3Qoc2gsc2V1c2VyKTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
dGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3QgZXh0cmFjdCBTRVVzZXIga2V5JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
ZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFVXNlciBr
ZXkgZXh0cmFjdGVkOiAmcXVvdDssIGtleTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1
cyxleGlzdHMpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyXzx3YnI+ZXhpc3RzX2xvY2FsKHNo
LGtleSk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNoZWNrIGlmIFNFVXNlciBleGlz
dHMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZx
dW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiBleGlzdHM6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsIG9sZF9zZXVzZXIpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vf
c2V1c2VyXzx3YnI+cXVlcnlfbG9jYWwoc2gsIGtleSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJy
b3IoJnF1b3Q7Q291bGQgbm90IHF1ZXJ5IG9sZCBTRVVzZXImcXVvdDspPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnQgJnF1b3Q7UXVlcnkgc3RhdHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1N0YXJ0aW5nIHRyYW5zYWN0aW9u
Li4uJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jl
Z2luXzx3YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBz
dGFydCBzZW1hbmFnZSB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNlcl88d2JyPm1vZGlmeV9sb2NhbChzaCxr
ZXksc2V1c2VyKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgbW9kaWZ5IFNFVXNlciZx
dW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdl
X2NvbW1pdChzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1pdCB0ZXN0IHRy
YW5zYWN0aW9uJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQgc3Rh
dHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlv
bihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5z
YWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgbm90IGV4aXN0czo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UmVtb3Zpbmcgc2V1c2VyLi4uJnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX3NldXNl
cl9kZWxfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0
dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3QgZGVsZXRlIHRlc3QgU0VVc2VyJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50
ICZxdW90O1NldXNlciBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0KK8KgIMKgIMKgIMKgIGVs
c2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1Jlc2V0dGluZyBzZXVzZXIu
Li4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5h
Z2Vfc2V1c2VyXzx3YnI+bW9kaWZ5X2xvY2FsKHNoLCBrZXksIG9sZF9zZXVzZXIpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCByZXNldCB0ZXN0IFNFVXNlciZxdW90
Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTZXVzZXIgbW9kaWZ5OiAmcXVvdDssIHN0YXR1
czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29t
bWl0KHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHJlc2V0IHRyYW5z
YWN0aW9uJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQgc3RhdHVz
ICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2Vfc2V1c2VyX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCivC
oCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9zZXVzZXJfZnJlZSg8d2JyPnNldXNlcik8YnI+
DQorwqAgwqAgwqAgwqAgaWYgZXhpc3RzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZW1hbmFn
ZS5zZW1hbmFnZV9zZXVzZXJfZnJlZSg8d2JyPm9sZF9zZXVzZXIpPGJyPg0KKzxicj4NCivCoCDC
oCBkZWYgdGVzdF93cml0ZXBvcnQoc2VsZixzaCk6PGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZx
dW90O1Rlc3RpbmcgcG9ydCB3cml0ZS4uLiZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
KHN0YXR1cywgcG9ydCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2NyZWF0ZSg8d2JyPnNoKTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFUG9ydCBvYmplY3QmcXVvdDsp
PGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgcHJpbnQgJnF1b3Q7U0VQb3J0IG9iamVjdCBjcmVhdGVkLiZxdW90Ozxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9zZXRfPHdicj5yYW5nZShwb3J0LDE1
MCwyMDApPGJyPg0KK8KgIMKgIMKgIMKgIGxvdyA9IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfZ2V0
Xzx3YnI+bG93KHBvcnQpPGJyPg0KK8KgIMKgIMKgIMKgIGhpZ2ggPSBzZW1hbmFnZS5zZW1hbmFn
ZV9wb3J0X2dldF88d2JyPmhpZ2gocG9ydCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJi
b3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRVBvcnQgcmFuZ2Ugc2V0
OiAmcXVvdDssIGxvdywgJnF1b3Q7LSZxdW90OywgaGlnaDxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9zZXRfPHdicj5wcm90byhwb3J0LCBzZW1hbmFnZS5T
RU1BTkFHRV9QUk9UT19UQ1ApPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VQb3J0IHByb3RvY29sIHNldDogJnF1
b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X2dldF88d2JyPnByb3RvX3N0cihzZW1hbmFnZS5T
RU1BTkFHRV88d2JyPlBST1RPX1RDUCk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMs
IGNvbikgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0Xzx3YnI+Y3JlYXRlKHNoKTxicj4NCivC
oCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlz
ZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFQ29udGV4dCBvYmplY3QmcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnQgJnF1b3Q7U0VDb250ZXh0IG9iamVjdCBjcmVhdGVkIChmb3IgcG9ydCkuJnF1b3Q7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0
X3NldF88d2JyPnVzZXIoc2gsIGNvbiwgJnF1b3Q7c3lzdGVtX3UmcXVvdDspPGJyPg0KK8KgIMKg
IMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCB1c2VyJnF1b3Q7KTxicj4NCivCoCDCoCDC
oCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90
O1NFQ29udGV4dCB1c2VyOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3
YnI+dXNlcihjb24pPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5z
ZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnJvbGUoc2gsIGNvbiwgJnF1b3Q7b2JqZWN0X3ImcXVv
dDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCByb2xlJnF1b3Q7
KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHByaW50ICZxdW90O1NFQ29udGV4dCByb2xlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdl
X2NvbnRleHRfZ2V0Xzx3YnI+cm9sZShjb24pPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0
dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnR5cGUoc2gsIGNvbiwgJnF1
b3Q7aHR0cF9wb3J0X3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQg
Y29udGV4dCB0eXBlJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFQ29udGV4dCB0eXBlOiAmcXVvdDss
IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+dHlwZShjb24pPGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2Jy
Pm1scyhzaCwgY29uLCAmcXVvdDtzMDpjMC5jMjU1JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBp
ZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgTUxTIGZpZWxkcyZxdW90Oyk8YnI+DQorwqAgwqAgwqAg
wqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtT
RUNvbnRleHQgbWxzOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+
bWxzKGNvbik8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFu
YWdlX3BvcnRfc2V0Xzx3YnI+Y29uKHNoLCBwb3J0LCBjb24pPGJyPg0KK8KgIMKgIMKgIMKgIGlm
IHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBzZXQgU0VQb3J0IGNvbnRleHQmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlm
IHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VQb3J0
IGNvbnRleHQgc2V0OiAmcXVvdDssIGNvbjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1
cyxrZXkpID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9rZXlfPHdicj5leHRyYWN0KHNoLHBvcnQp
PGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBleHRyYWN0IFNFUG9ydCBrZXkmcXVvdDsp
PGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgcHJpbnQgJnF1b3Q7U0VQb3J0IGtleSBleHRyYWN0ZWQ6ICZxdW90Oywga2V5PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLGV4aXN0cykgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0
X2V4aXN0c188d2JyPmxvY2FsKHNoLGtleSk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZs
dDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90
IGNoZWNrIGlmIFNFUG9ydCBleGlzdHMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYu
dmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1
cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCBpZiBleGlzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsIG9sZF9wb3J0KSA9
IHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfcXVlcnlfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIFNFUG9ydCZxdW90
Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIp
OiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U3Rh
cnRpbmcgdHJhbnNhY3Rpb24uLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2Vt
YW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAg
wqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3Io
JnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9tb2RpZnlf
PHdicj5sb2NhbChzaCxrZXkscG9ydCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IG1v
ZGlmeSBTRVBvcnQmcXVvdDspPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1h
bmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7
IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBj
b21taXQgdGVzdCB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1
b3Q7Q29tbWl0IHN0YXR1cyAodHJhbnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2JlZ2luXzx3
YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBz
ZW1hbmFnZSB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmIG5v
dCBleGlzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1JlbW92aW5nIHBv
cnQgcmFuZ2UuLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfcG9ydF9kZWxfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
YWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgZGVsZXRlIHRlc3QgU0VQb3J0JnF1b3Q7KTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHByaW50ICZxdW90O1BvcnQgcmFuZ2UgZGVsZXRlOiAmcXVvdDssIHN0YXR1czxi
cj4NCivCoCDCoCDCoCDCoCBlbHNlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVv
dDtSZXNldHRpbmcgcG9ydCByYW5nZS4uLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBz
dGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9wb3J0X21vZGlmeV88d2JyPmxvY2FsKHNoLCBrZXks
IG9sZF9wb3J0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcmVz
ZXQgdGVzdCBTRVBvcnQmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYudmVy
Ym9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UG9ydCByYW5n
ZSBtb2RpZnk6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMg
PSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHBy
aW50ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3Rh
dHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0Xzx3
YnI+ZnJlZShjb24pPGJyPg0KK8KgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRfa2V5
Xzx3YnI+ZnJlZShrZXkpPGJyPg0KK8KgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX3BvcnRf
ZnJlZSg8d2JyPnBvcnQpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIGV4aXN0czo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfcG9ydF9mcmVlKDx3YnI+b2xkX3BvcnQpPGJy
Pg0KKzxicj4NCivCoCDCoCBkZWYgdGVzdF93cml0ZWZjb250ZXh0KHNlbGYsc2gpOjxicj4NCivC
oCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIGZpbGUgY29udGV4dCB3cml0ZS4uLiZxdW90
Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cywgZmNvbikgPSBzZW1hbmFnZS5zZW1h
bmFnZV9mY29udGV4dF88d2JyPmNyZWF0ZShzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVz
ICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQg
bm90IGNyZWF0ZSBTRUZjb250ZXh0IG9iamVjdCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYg
c2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUZjb250
ZXh0IG9iamVjdCBjcmVhdGVkLiZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVz
ID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5zZXRfZXhwcihzaCwgZmNvbiwgJnF1
b3Q7L3Rlc3QvZmNvbnRleHQoLy4qKT8mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBzZXQgZXhwcmVzc2lvbiZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJi
b3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUZDb250ZXh0IGV4cHIg
c2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3YnI+Z2V0X2V4cHIoZmNv
bik8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3
YnI+c2V0X3R5cGUoZmNvbiwgc2VtYW5hZ2UuU0VNQU5BR0VfRkNPTlRFWFRfPHdicj5SRUcpPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
ZnR5cGUgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPmdldF90eXBlKGZjb24pPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFRkNvbnRleHQgdHlwZSBzZXQ6ICZx
dW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5nZXRfdHlwZV9zdHIoZnR5cGUp
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBjb24pID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfY29udGV4dF88d2JyPmNyZWF0ZShzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZs
dDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90
IGNyZWF0ZSBTRUNvbnRleHQgb2JqZWN0JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxm
LnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFQ29udGV4dCBv
YmplY3QgY3JlYXRlZCAoZm9yIGZpbGUgY29udGV4dCkuJnF1b3Q7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnVzZXIo
c2gsIGNvbiwgJnF1b3Q7c3lzdGVtX3UmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBzZXQgY29udGV4dCB1c2VyJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZl
cmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFQ29udGV4dCB1c2Vy
OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+dXNlcihjb24pPGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0
X3NldF88d2JyPnJvbGUoc2gsIGNvbiwgJnF1b3Q7b2JqZWN0X3ImcXVvdDspPGJyPg0KK8KgIMKg
IMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCByb2xlJnF1b3Q7KTxicj4NCivCoCDCoCDC
oCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90
O1NFQ29udGV4dCByb2xlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3
YnI+cm9sZShjb24pPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5z
ZW1hbmFnZV9jb250ZXh0X3NldF88d2JyPnR5cGUoc2gsIGNvbiwgJnF1b3Q7ZGVmYXVsdF90JnF1
b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgdHlwZSZxdW90
Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBwcmludCAmcXVvdDtTRUNvbnRleHQgdHlwZTogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFn
ZV9jb250ZXh0X2dldF88d2JyPnR5cGUoY29uKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3Rh
dHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9zZXRfPHdicj5tbHMoc2gsIGNvbiwgJnF1
b3Q7czA6YzAuYzI1NSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBj
b250ZXh0IE1MUyBmaWVsZHMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9z
ZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VDb250ZXh0IG1sczogJnF1
b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X2dldF88d2JyPm1scyhjb24pPGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2Jy
PnNldF9jb24oc2gsIGZjb24sIGNvbik8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNl
dCBTRUZjb250ZXh0IGNvbnRleHQmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVy
Ym9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VGY29udGV4dCBjb250
ZXh0IHNldDogJnF1b3Q7LCBjb248YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMsa2V5
KSA9IHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0Xzx3YnI+a2V5X2V4dHJhY3Qoc2gsZmNvbik8
YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGV4dHJhY3QgU0VGY29udGV4dCBrZXkmcXVv
dDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcHJpbnQgJnF1b3Q7U0VGY29udGV4dCBrZXkgZXh0cmFjdGVkOiAmcXVvdDssIGtleTxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cyxleGlzdHMpID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfZmNvbnRleHRfPHdicj5leGlzdHNfbG9jYWwoc2gsa2V5KTxicj4NCivCoCDCoCDCoCDCoCBp
ZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVv
dDtDb3VsZCBub3QgY2hlY2sgaWYgU0VGY29udGV4dCBleGlzdHMmcXVvdDspPGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBy
aW50ICZxdW90O0V4aXN0cyBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxi
cj4NCivCoCDCoCDCoCDCoCBpZiBleGlzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIChzdGF0
dXMsIG9sZF9mY29udGV4dCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9mY29udGV4dF88d2JyPnF1ZXJ5
X2xvY2FsKHNoLCBrZXkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5v
dCBxdWVyeSBvbGQgU0VGY29udGV4dCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYg
c2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtR
dWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNhY3Rpb24uLi4mcXVvdDs8YnI+
DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFu
c2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdl
IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2Vt
YW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5tb2RpZnlfbG9jYWwoc2gsa2V5LGZjb24pPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBtb2RpZnkgU0VGY29udGV4dCZxdW90Oyk8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChz
aCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1pdCB0ZXN0IHRyYW5zYWN0aW9u
JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFu
c2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
c3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+
DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
cmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1
b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgbm90IGV4aXN0czo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UmVtb3ZpbmcgZmlsZSBjb250ZXh0Li4uJnF1b3Q7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Zjb250ZXh0
Xzx3YnI+ZGVsX2xvY2FsKHNoLCBrZXkpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBkZWxldGUgdGVzdCBTRUZjb250ZXh0JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBy
aW50ICZxdW90O0ZpbGUgY29udGV4dCBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0KK8KgIMKg
IMKgIMKgIGVsc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1Jlc2V0dGlu
ZyBmaWxlIGNvbnRleHQuLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzID0g
c2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5tb2RpZnlfbG9jYWwoc2gsIGtleSwgb2xk
X2Zjb250ZXh0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcmVz
ZXQgdGVzdCBGQ29udGV4dCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52
ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtGaWxlIGNv
bnRleHQgbW9kaWZ5OiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3Rh
dHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29tbWl0KHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
dGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3QgY29tbWl0IHJlc2V0IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDss
IHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4
dF88d2JyPmZyZWUoY29uKTxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9mY29u
dGV4dF88d2JyPmtleV9mcmVlKGtleSk8YnI+DQorwqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5h
Z2VfZmNvbnRleHRfPHdicj5mcmVlKGZjb24pPGJyPg0KK8KgIMKgIMKgIMKgIGlmIGV4aXN0czo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfZmNvbnRleHRfPHdicj5m
cmVlKG9sZF9mY29udGV4dCk8YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X3dyaXRlaW50ZXJm
YWNlKHNlbGYsc2gpOjxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIG5ldHdv
cmsgaW50ZXJmYWNlIHdyaXRlLi4uJnF1b3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3Rh
dHVzLCBpZmFjZSkgPSBzZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV88d2JyPmNyZWF0ZShzaCk8YnI+
DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
cmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNyZWF0ZSBTRUlmYWNlIG9iamVjdCZxdW90Oyk8
YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtTRUlmYWNlIG9iamVjdCBjcmVhdGVkLiZxdW90Ozxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2Vfc2V0Xzx3YnI+bmFt
ZShzaCwgaWZhY2UsICZxdW90O3Rlc3RfaWZhY2UmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlm
IHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90
O0NvdWxkIG5vdCBzZXQgU0VJZmFjZSBuYW1lJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
ZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFSWZhY2Ug
bmFtZSBzZXQ6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfZ2V0Xzx3YnI+bmFtZShp
ZmFjZSk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMsIGNvbikgPSBzZW1hbmFnZS5z
ZW1hbmFnZV9jb250ZXh0Xzx3YnI+Y3JlYXRlKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0
dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3Vs
ZCBub3QgY3JlYXRlIFNFQ29udGV4dCBvYmplY3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlm
IHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VDb250
ZXh0IG9iamVjdCBjcmVhdGVkIChmb3IgbmV0d29yayBpbnRlcmZhY2UpJnF1b3Q7PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X3NldF88
d2JyPnVzZXIoc2gsIGNvbiwgJnF1b3Q7c3lzdGVtX3UmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKg
IGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZx
dW90O0NvdWxkIG5vdCBzZXQgaW50ZXJmYWNlIGNvbnRleHQgdXNlciZxdW90Oyk8YnI+DQorwqAg
wqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAm
cXVvdDtTRUNvbnRleHQgdXNlcjogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X2dl
dF88d2JyPnVzZXIoY29uKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfY29udGV4dF9zZXRfPHdicj5yb2xlKHNoLCBjb24sICZxdW90O29iamVjdF9y
JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGludGVyZmFjZSBjb250
ZXh0IHJvbGUmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VDb250ZXh0IHJvbGU6ICZxdW90Oywgc2Vt
YW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5yb2xlKGNvbik8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+dHlw
ZShzaCwgY29uLCAmcXVvdDtkZWZhdWx0X3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0
YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0Nv
dWxkIG5vdCBzZXQgaW50ZXJmYWNlIGNvbnRleHQgdHlwZSZxdW90Oyk8YnI+DQorwqAgwqAgwqAg
wqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtT
RUNvbnRleHQgdHlwZTogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0X2dldF88d2Jy
PnR5cGUoY29uKTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2VfY29udGV4dF9zZXRfPHdicj5tbHMoc2gsIGNvbiwgJnF1b3Q7czA6YzAuYzI1NSZxdW90
Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBpbnRlcmZhY2UgY29udGV4dCBN
TFMgZmllbGRzJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFQ29udGV4dCBtbHM6ICZxdW90Oywgc2Vt
YW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5tbHMoY29uKTxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2Vfc2V0Xzx3YnI+aWZjb24o
c2gsIGlmYWNlLCBjb24pPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgU0VJZmFj
ZSBpbnRlcmZhY2UgY29udGV4dCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJi
b3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUlmYWNlIGludGVyZmFj
ZSBjb250ZXh0IHNldDogJnF1b3Q7LCBjb248YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX3NldF88d2JyPm1zZ2NvbihzaCwgaWZhY2UsIGNv
bik8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBTRUlmYWNlIG1lc3NhZ2UgY29u
dGV4dCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUlmYWNlIG1lc3NhZ2UgY29udGV4dCBzZXQ6ICZx
dW90OywgY29uPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLGtleSkgPSBzZW1hbmFn
ZS5zZW1hbmFnZV9pZmFjZV9rZXlfPHdicj5leHRyYWN0KHNoLGlmYWNlKTxicj4NCivCoCDCoCDC
oCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJv
cigmcXVvdDtDb3VsZCBub3QgZXh0cmFjdCBTRUlmYWNlIGtleSZxdW90Oyk8YnI+DQorwqAgwqAg
wqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVv
dDtTRUlmYWNlIGtleSBleHRyYWN0ZWQ6ICZxdW90Oywga2V5PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoCAoc3RhdHVzLGV4aXN0cykgPSBzZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV88d2JyPmV4aXN0
c19sb2NhbChzaCxrZXkpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjaGVjayBpZiBT
RUlmYWNlIGV4aXN0cyZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtFeGlzdHMgc3RhdHVzIChjb21taXQg
bnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmIGV4aXN0
czo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKHN0YXR1cywgb2xkX2lmYWNlKSA9IHNlbWFuYWdl
LnNlbWFuYWdlX2lmYWNlX3F1ZXJ5Xzx3YnI+bG9jYWwoc2gsIGtleSk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHF1ZXJ5IG9sZCBTRUlmYWNlJnF1b3Q7KTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHByaW50ICZxdW90O1F1ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90
Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTdGFydGluZyB0
cmFuc2FjdGlvbi4uLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5z
ZW1hbmFnZV9iZWdpbl88d2JyPnRyYW5zYWN0aW9uKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBz
dGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtD
b3VsZCBub3QgYmVnaW4gc2VtYW5hZ2UgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV88d2JyPm1vZGlmeV9s
b2NhbChzaCxrZXksaWZhY2UpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBtb2RpZnkg
U0VJZmFjZSZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdl
LnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNvbW1p
dCB0ZXN0IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtD
b21taXQgc3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50
cmFuc2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGJlZ2luIHNlbWFu
YWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgbm90IGV4
aXN0czo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UmVtb3ZpbmcgaW50ZXJm
YWNlLi4uJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNl
bWFuYWdlX2lmYWNlX2RlbF88d2JyPmxvY2FsKHNoLCBrZXkpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCBkZWxldGUgdGVzdCBTRUlmYWNlJnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHByaW50ICZxdW90O0ludGVyZmFjZSBkZWxldGU6ICZxdW90Oywgc3RhdHVzPGJyPg0K
K8KgIMKgIMKgIMKgIGVsc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1Jl
c2V0dGluZyBpbnRlcmZhY2UuLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVz
ID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfPHdicj5tb2RpZnlfbG9jYWwoc2gsIGtleSwgb2xk
X2lmYWNlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgcmVzZXQg
dGVzdCBTRUlmYWNlJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJv
c2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O0ludGVyZmFjZSBt
b2RpZnk6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBz
ZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAm
bHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5v
dCBjb21taXQgcmVzZXQgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50
ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVz
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9jb250ZXh0Xzx3YnI+
ZnJlZShjb24pPGJyPg0KK8KgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdlX2lmYWNlX2tleV88
d2JyPmZyZWUoa2V5KTxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9pZmFjZV9m
cmVlKDx3YnI+aWZhY2UpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIGV4aXN0czo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfaWZhY2VfZnJlZSg8d2JyPm9sZF9pZmFjZSk8
YnI+DQorPGJyPg0KK8KgIMKgIGRlZiB0ZXN0X3dyaXRlYm9vbGVhbihzZWxmLHNoKTo8YnI+DQor
wqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7VGVzdGluZyBib29sZWFuIHdyaXRlLi4uJnF1b3Q7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBwYm9vbCkgPSBzZW1hbmFnZS5zZW1hbmFn
ZV9ib29sX2NyZWF0ZSg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAw
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3Jl
YXRlIFNFQm9vbCBvYmplY3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9z
ZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VCb29sIG9iamVjdCBjcmVh
dGVkLiZxdW90Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2Vt
YW5hZ2VfYm9vbF9zZXRfPHdicj5uYW1lKHNoLCBwYm9vbCwgJnF1b3Q7YWxsb3dfZXhlY21lbSZx
dW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBuYW1lJnF1b3Q7KTxicj4N
CivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHBy
aW50ICZxdW90O1NFQm9vbCBuYW1lIHNldDogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9ib29s
X2dldF88d2JyPm5hbWUocGJvb2wpPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5z
ZW1hbmFnZV9ib29sX3NldF88d2JyPnZhbHVlKHBib29sLCAwKTxicj4NCivCoCDCoCDCoCDCoCBp
ZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFYm9v
bCB2YWx1ZSBzZXQ6ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9nZXRfPHdicj52YWx1
ZShwYm9vbCk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIChzdGF0dXMsa2V5KSA9IHNlbWFuYWdl
LnNlbWFuYWdlX2Jvb2xfa2V5Xzx3YnI+ZXh0cmFjdChzaCwgcGJvb2wpPGJyPg0KK8KgIMKgIMKg
IMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9y
KCZxdW90O0NvdWxkIG5vdCBleHRyYWN0IFNFQm9vbCBrZXkmcXVvdDspPGJyPg0KK8KgIMKgIMKg
IMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7
U0VCb29sIGtleSBleHRyYWN0ZWQ6ICZxdW90Oywga2V5PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCAoc3RhdHVzLGV4aXN0cykgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2V4aXN0c188d2JyPmxv
Y2FsKHNoLGtleSk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGNoZWNrIGlmIFNFQm9v
bCBleGlzdHMmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7RXhpc3RzIHN0YXR1cyAoY29tbWl0IG51bWJl
cik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiBleGlzdHM6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIChzdGF0dXMsIG9sZF9ib29sKSA9IHNlbWFuYWdlLnNlbWFu
YWdlX2Jvb2xfcXVlcnlfPHdicj5sb2NhbChzaCwga2V5KTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBF
cnJvcigmcXVvdDtDb3VsZCBub3QgcXVlcnkgb2xkIFNFQm9vbCZxdW90Oyk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtRdWVyeSBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1
czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U3RhcnRpbmcgdHJhbnNhY3Rp
b24uLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vf
YmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZs
dDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90
IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9tb2RpZnlfPHdicj5sb2NhbChzaCwg
a2V5LCBwYm9vbCk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBtb2RpZnkg
U0VCb29sJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uu
c2VtYW5hZ2VfY29tbWl0KHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0
IHRlc3QgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O0Nv
bW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9iZWdpbl88d2JyPnRy
YW5zYWN0aW9uKHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc3RhcnQgc2VtYW5h
Z2UgdHJhbnNhY3Rpb24mcXVvdDspPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiBub3QgZXhp
c3RzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtSZW1vdmluZyBib29sZWFu
Li4uJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFu
YWdlX2Jvb2xfZGVsXzx3YnI+bG9jYWwoc2gsIGtleSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJy
b3IoJnF1b3Q7Q291bGQgbm90IGRlbGV0ZSB0ZXN0IFNFQm9vbCZxdW90Oyk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwcmludCAmcXVvdDtCb29sZWFuIGRlbGV0ZTogJnF1b3Q7LCBzdGF0dXM8YnI+DQorwqAgwqAg
wqAgwqAgZWxzZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UmVzZXR0aW5n
IGJvb2xlYW4uLi4mcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfYm9vbF9tb2RpZnlfPHdicj5sb2NhbChzaCwga2V5LCBvbGRfYm9vbCk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHJlc2V0IHRlc3QgU0VCb29s
JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O0Jvb2xlYW4gbW9kaWZ5OiAmcXVvdDss
IHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5h
Z2VfY29tbWl0KHNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHJlc2V0
IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQg
c3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9rZXlfPHdicj5mcmVlKGtleSk8YnI+
DQorwqAgwqAgwqAgwqAgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9mcmVlKDx3YnI+cGJvb2wpPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIGV4aXN0czogc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9mcmVlKDx3
YnI+b2xkX2Jvb2wpPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgdGVzdF93cml0ZWFib29sZWFuKHNl
bGYsc2gpOjxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtUZXN0aW5nIGFjdGl2ZSBib29s
ZWFuIHdyaXRlLi4uJnF1b3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBrZXkp
ID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9rZXlfPHdicj5jcmVhdGUoc2gsICZxdW90O2FsbG93
X2V4ZWNtZW0mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjcmVhdGUgU0VC
b29sIGtleSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUJvb2wga2V5IGNyZWF0ZWQ6ICZxdW90Oywg
a2V5PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCAoc3RhdHVzLCBvbGRfYm9vbCkgPSBzZW1hbmFn
ZS5zZW1hbmFnZV9ib29sX3F1ZXJ5Xzx3YnI+YWN0aXZlKHNoLCBrZXkpPGJyPg0KK8KgIMKgIMKg
IMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9y
KCZxdW90O0NvdWxkIG5vdCBxdWVyeSBvbGQgU0VCb29sJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1F1
ZXJ5IHN0YXR1cyAoY29tbWl0IG51bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCAoc3RhdHVzLCBhYm9vbCkgPSBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2NyZWF0
ZSg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFQm9vbCBv
YmplY3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VCb29sIG9iamVjdCBjcmVhdGVkLiZxdW90Ozxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9z
ZXRfPHdicj5uYW1lKHNoLCBhYm9vbCwgJnF1b3Q7YWxsb3dfZXhlY21lbSZxdW90Oyk8YnI+DQor
wqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBuYW1lJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NF
Qm9vbCBuYW1lIHNldDogJnF1b3Q7LCBzZW1hbmFnZS5zZW1hbmFnZV9ib29sX2dldF88d2JyPm5h
bWUoYWJvb2wpPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9ib29s
X3NldF88d2JyPnZhbHVlKGFib29sLCAwKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJv
c2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFYm9vbCB2YWx1ZSBzZXQ6
ICZxdW90Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfYm9vbF9nZXRfPHdicj52YWx1ZShhYm9vbCk8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O1N0YXJ0aW5nIHRyYW5zYWN0aW9uLi4u
JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2JlZ2lu
Xzx3YnI+dHJhbnNhY3Rpb24oc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFy
dCBzZW1hbmFnZSB0cmFuc2FjdGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0
YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2Jvb2xfc2V0Xzx3YnI+YWN0aXZlKHNoLGtleSxhYm9v
bCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IG1vZGlmeSBTRUJvb2wmcXVvdDspPGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQo
c2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgdGVzdCB0cmFuc2FjdGlv
biZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7Q29tbWl0IHN0YXR1cyAodHJh
bnNhY3Rpb24gbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IHByaW50ICZxdW90O1Jlc2V0dGluZyBvbGQgYWN0aXZlIGJvb2xlYW4uLi4mcXVvdDs8YnI+DQor
wqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2Fj
dGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRy
YW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfYm9vbF9zZXRfPHdicj5hY3RpdmUoc2gsIGtleSxvbGRfYm9vbCk8YnI+DQor
wqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFp
c2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHJlc2V0IHRlc3QgU0VCb29sJnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50
ICZxdW90O1NFQm9vbCBhY3RpdmUgcmVzZXQ6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9jb21taXQoc2gpPGJyPg0KK8Kg
IMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCBjb21taXQgcmVzZXQgdHJhbnNhY3Rpb24mcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIHByaW50ICZxdW90O0NvbW1pdCBzdGF0dXMgKHRyYW5zYWN0aW9uIG51
bWJlcik6ICZxdW90Oywgc3RhdHVzPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5z
ZW1hbmFnZV9ib29sX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFn
ZS5zZW1hbmFnZV9ib29sX2ZyZWUoPHdicj5hYm9vbCk8YnI+DQorwqAgwqAgwqAgwqAgc2VtYW5h
Z2Uuc2VtYW5hZ2VfYm9vbF9mcmVlKDx3YnI+b2xkX2Jvb2wpPGJyPg0KKzxicj4NCis8YnI+DQor
wqAgwqAgZGVmIHRlc3Rfd3JpdGVub2RlKHNlbGYsc2gpOjxicj4NCivCoCDCoCDCoCDCoCBwcmlu
dCAmcXVvdDtUZXN0aW5nIG5ldHdvcmsgbm9kZSB3cml0ZS4uLiZxdW90Ozxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgKHN0YXR1cywgbm9kZSkgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2NyZWF0
ZSg8d2JyPnNoKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY3JlYXRlIFNFTm9kZSBv
YmplY3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VOb2RlIG9iamVjdCBjcmVhdGVkLiZxdW90Ozxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9z
ZXRfPHdicj5hZGRyKHNoLCBub2RlLCBzZW1hbmFnZS5TRU1BTkFHRV9QUk9UT19JUDYsICZxdW90
O2ZmZWU6ZGRkZDo6YmJiYiZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNl
dCBTRU5vZGUgYWRkcmVzcyZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfc2V0Xzx3YnI+bWFzayhzaCwgbm9kZSwgc2VtYW5hZ2Uu
U0VNQU5BR0VfUFJPVE9fSVA2LCAmcXVvdDs6OmZmZmY6ZmZmZjphYmNkOjAwMDAmcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgU0VOb2RlIG5ldG1hc2smcXVvdDspPGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX3NldF88d2JyPnBy
b3RvKG5vZGUsIHNlbWFuYWdlLlNFTUFOQUdFX1BST1RPX0lQNik8YnI+DQorwqAgwqAgwqAgwqAg
aWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRU5v
ZGUgcHJvdG9jb2wgc2V0OiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfZ2V0Xzx3YnI+
cHJvdG9fc3RyKHNlbWFuYWdlLlNFTUFOQUdFXzx3YnI+UFJPVE9fSVA2KTxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgKHN0YXR1cywgY29uKSA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfPHdi
cj5jcmVhdGUoc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBjcmVhdGUgU0VDb250
ZXh0IG9iamVjdCZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtTRUNvbnRleHQgb2JqZWN0IGNyZWF0ZWQg
KGZvciBub2RlKS4mcXVvdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFu
YWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+dXNlcihzaCwgY29uLCAmcXVvdDtzeXN0ZW1f
dSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNldCBjb250ZXh0IHVzZXIm
cXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VDb250ZXh0IHVzZXI6ICZxdW90Oywgc2VtYW5hZ2Uuc2Vt
YW5hZ2VfY29udGV4dF9nZXRfPHdicj51c2VyKGNvbik8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3YnI+cm9sZShzaCwgY29u
LCAmcXVvdDtvYmplY3RfciZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsg
MDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHNl
dCBjb250ZXh0IHJvbGUmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7U0VDb250ZXh0IHJvbGU6ICZxdW90
Oywgc2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF9nZXRfPHdicj5yb2xlKGNvbik8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfc2V0Xzx3
YnI+dHlwZShzaCwgY29uLCAmcXVvdDtsb19ub2RlX3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKg
IGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZx
dW90O0NvdWxkIG5vdCBzZXQgY29udGV4dCB0eXBlJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBp
ZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFQ29u
dGV4dCB0eXBlOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdlX2NvbnRleHRfZ2V0Xzx3YnI+dHlw
ZShjb24pPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFn
ZV9jb250ZXh0X3NldF88d2JyPm1scyhzaCwgY29uLCAmcXVvdDtzMDpjMC5jMjU1JnF1b3Q7KTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3Qgc2V0IGNvbnRleHQgTUxTIGZpZWxkcyZxdW90
Oyk8YnI+DQorwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBwcmludCAmcXVvdDtTRUNvbnRleHQgbWxzOiAmcXVvdDssIHNlbWFuYWdlLnNlbWFuYWdl
X2NvbnRleHRfZ2V0Xzx3YnI+bWxzKGNvbik8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1
cyA9IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfc2V0Xzx3YnI+Y29uKHNoLCBub2RlLCBjb24pPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzZXQgU0VOb2RlIGNvbnRleHQmcXVvdDspPGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIHNlbGYudmVyYm9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnQgJnF1b3Q7U0VOb2RlIGNvbnRleHQgc2V0OiAmcXVvdDssIGNvbjxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgKHN0YXR1cyxrZXkpID0gc2VtYW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9rZXlfPHdi
cj5leHRyYWN0KHNoLCBub2RlKTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgZXh0cmFj
dCBTRU5vZGUga2V5JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1NFTm9kZSBrZXkgZXh0cmFjdGVkOiAm
cXVvdDssIGtleTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgKHN0YXR1cyxleGlzdHMpID0gc2Vt
YW5hZ2Uuc2VtYW5hZ2Vfbm9kZV9leGlzdHNfPHdicj5sb2NhbChzaCxrZXkpPGJyPg0KK8KgIMKg
IMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVy
cm9yKCZxdW90O0NvdWxkIG5vdCBjaGVjayBpZiBTRU5vZGUgZXhpc3RzJnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCBpZiBzZWxmLnZlcmJvc2U6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHByaW50
ICZxdW90O0V4aXN0cyBzdGF0dXMgKGNvbW1pdCBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgaWYgZXhpc3RzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAo
c3RhdHVzLCBvbGRfbm9kZSkgPSBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX3F1ZXJ5Xzx3YnI+bG9j
YWwoc2gsIGtleSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IHF1
ZXJ5IG9sZCBTRU5vZGUmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYudmVy
Ym9zZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJnF1b3Q7UXVlcnkgc3Rh
dHVzIChjb21taXQgbnVtYmVyKTogJnF1b3Q7LCBzdGF0dXM8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIHByaW50ICZxdW90O1N0YXJ0aW5nIHRyYW5zYWN0aW9uLi4uJnF1b3Q7PGJyPg0KK8KgIMKg
IMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2JlZ2luXzx3YnI+dHJhbnNhY3Rpb24o
c2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5vdCBzdGFydCBzZW1hbmFnZSB0cmFuc2Fj
dGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNl
bWFuYWdlX25vZGVfbW9kaWZ5Xzx3YnI+bG9jYWwoc2gsa2V5LCBub2RlKTxicj4NCivCoCDCoCDC
oCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBFcnJv
cigmcXVvdDtDb3VsZCBub3QgbW9kaWZ5IFNFTm9kZSZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX2NvbW1pdChzaCk8YnI+DQorwqAgwqAg
wqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJy
b3IoJnF1b3Q7Q291bGQgbm90IGNvbW1pdCB0ZXN0IHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFuc2FjdGlvbiBudW1iZXIp
OiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5h
Z2Uuc2VtYW5hZ2VfYmVnaW5fPHdicj50cmFuc2FjdGlvbihzaCk8YnI+DQorwqAgwqAgwqAgwqAg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1
b3Q7Q291bGQgbm90IHN0YXJ0IHNlbWFuYWdlIHRyYW5zYWN0aW9uJnF1b3Q7KTxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAgaWYgbm90IGV4aXN0czo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcHJp
bnQgJnF1b3Q7UmVtb3ZpbmcgbmV0d29yayBub2RlLi4uJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVfZGVsXzx3YnI+bG9jYWwoc2gs
IGtleSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1b3Q7Q291bGQgbm90IGRlbGV0ZSB0
ZXN0IFNFTm9kZSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3Nl
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtOZXR3b3JrIG5vZGUg
ZGVsZXRlOiAmcXVvdDssIHN0YXR1czxicj4NCivCoCDCoCDCoCDCoCBlbHNlOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtSZXNldHRpbmcgbmV0d29yayBub2RlLi4uJnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHN0YXR1cyA9IHNlbWFuYWdlLnNlbWFuYWdlX25vZGVf
bW9kaWZ5Xzx3YnI+bG9jYWwoc2gsIGtleSwgb2xkX25vZGUpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGlmIHN0YXR1cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNl
IEVycm9yKCZxdW90O0NvdWxkIG5vdCByZXNldCB0ZXN0IFNFTm9kZSZxdW90Oyk8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgaWYgc2VsZi52ZXJib3NlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBwcmludCAmcXVvdDtOZXR3b3JrIG5vZGUgbW9kaWZ5OiAmcXVvdDssIHN0YXR1czxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29tbWl0KHNo
KTxicj4NCivCoCDCoCDCoCDCoCBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBub3QgY29tbWl0IHJlc2V0IHRyYW5zYWN0aW9u
JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBwcmludCAmcXVvdDtDb21taXQgc3RhdHVzICh0cmFu
c2FjdGlvbiBudW1iZXIpOiAmcXVvdDssIHN0YXR1czxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
c2VtYW5hZ2Uuc2VtYW5hZ2VfY29udGV4dF88d2JyPmZyZWUoY29uKTxicj4NCivCoCDCoCDCoCDC
oCBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2tleV88d2JyPmZyZWUoa2V5KTxicj4NCivCoCDCoCDC
oCDCoCBzZW1hbmFnZS5zZW1hbmFnZV9ub2RlX2ZyZWUoPHdicj5ub2RlKTxicj4NCivCoCDCoCDC
oCDCoCBpZiBleGlzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNlbWFuYWdlLnNlbWFuYWdl
X25vZGVfZnJlZSg8d2JyPm9sZF9ub2RlKTxicj4NCjxicj4NCsKgZGVmIG1haW4oYXJndj1Ob25l
KTo8YnI+DQotwqAgwqAgwqAgwqBpZiBhcmd2IGlzIE5vbmU6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYXJndiA9IHN5cy5hcmd2PGJyPg0KLcKgIMKgIMKgIMKgdHJ5Ojxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHRyeTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBvcHRzLCBhcmdzID0gZ2V0b3B0LmdldG9wdChhcmd2WzE6XSwgJnF1b3Q7aHZtdXNw
ZmliY1VTUEZJQkNhbk4mcXVvdDssIFsmcXVvdDtoZWxwJnF1b3Q7LCAmcXVvdDt2ZXJib3NlJnF1
b3Q7LCAmcXVvdDttb2R1bGVzJnF1b3Q7LCAmcXVvdDt1c2VycyZxdW90OywgJnF1b3Q7c2V1c2Vy
cyZxdW90OywgJnF1b3Q7cG9ydHMmcXVvdDssICZxdW90O2ZpbGUgY29udGV4dHMmcXVvdDssICZx
dW90O25ldHdvcmsgaW50ZXJmYWNlcyZxdW90OywgJnF1b3Q7Ym9vbGVhbnMmcXVvdDssICZxdW90
O2FjdGl2ZSBib29sZWFucyZxdW90OywgJnF1b3Q7bmV0d29yayBub2RlcyZxdW90OywgJnF1b3Q7
d3JpdGV1c2VyJnF1b3Q7LCAmcXVvdDt3cml0ZXNldXNlciZxdW90OywgJnF1b3Q7d3JpdGVwb3J0
JnF1b3Q7LCAmcXVvdDt3cml0ZWZjb250ZXh0JnF1b3Q7LCAmcXVvdDt3cml0ZWludGVyZmFjZSZx
dW90OywgJnF1b3Q7d3JpdGVib29sZWFuJnF1b3Q7LCAmcXVvdDt3cml0ZWFib29sZWFuJnF1b3Q7
LCAmcXVvdDt3cml0ZW5vZGUmcXVvdDssICZxdW90O2FsbCZxdW90O10pPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMgPSBUZXN0cygpPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIG8sIGEgaW4gb3B0czo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBvID09ICZxdW90Oy12
JnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHRlc3RzLnZlcmJvc2UgPSBUcnVlPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnQgJnF1b3Q7
VmVyYm9zZSBvdXRwdXQgc2VsZWN0ZWQuJnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgbyA9PSAmcXVvdDstYSZxdW90Ozo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB0ZXN0cy5hbGwgPSBUcnVlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgbyA9PSAmcXVvdDstdSZxdW90Ozo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0ZXN0cy51c2Vy
cyA9IFRydWU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiBvID09ICZxdW90Oy1VJnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RzLndyaXRldXNlciA9IFRy
dWU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiBvID09ICZxdW90Oy1zJnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RzLnNldXNlcnMgPSBUcnVlPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgbyA9PSAm
cXVvdDstUyZxdW90Ozo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0ZXN0cy53cml0ZXNldXNlciA9IFRydWU8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBvID09ICZxdW90
Oy1wJnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RzLnBvcnRzID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG8gPT0gJnF1b3Q7LVAmcXVvdDs6
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgdGVzdHMud3JpdGVwb3J0ID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG8gPT0gJnF1b3Q7LWYmcXVvdDs6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdGVzdHMuZmNvbnRleHRzID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG8gPT0gJnF1b3Q7LUYmcXVvdDs6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVz
dHMud3JpdGVmY29udGV4dCA9IFRydWU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBvID09ICZxdW90Oy1pJnF1b3Q7Ojxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3Rz
LmludGVyZmFjZXMgPSBUcnVlPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgbyA9PSAmcXVvdDstSSZxdW90Ozo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0ZXN0cy53cml0
ZWludGVyZmFjZSA9IFRydWU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBvID09ICZxdW90Oy1iJnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RzLmJvb2xl
YW5zID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIG8gPT0gJnF1b3Q7LUImcXVvdDs6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMud3JpdGVib29sZWFu
ID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIG8gPT0gJnF1b3Q7LWMmcXVvdDs6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMuYWJvb2xlYW5zID0gVHJ1
ZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IG8gPT0gJnF1b3Q7LUMmcXVvdDs6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMud3JpdGVhYm9vbGVhbiA9IFRydWU8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBv
ID09ICZxdW90Oy1uJnF1b3Q7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RzLm5vZGVzID0gVHJ1ZTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG8gPT0gJnF1b3Q7
LU4mcXVvdDs6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMud3JpdGVub2RlID0gVHJ1ZTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG8gPT0gJnF1b3Q7LW0mcXVv
dDs6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdGVzdHMubW9kdWxlcyA9IFRydWU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBvID09ICZxdW90Oy1oJnF1b3Q7Ojxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJhaXNlIFVzYWdlKHVzYWdlKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiBub3QgdGVzdHMuc2VsZWN0ZWQoKTo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBVc2FnZSgmcXVvdDtQbGVh
c2Ugc2VsZWN0IGEgdmFsaWQgdGVzdC4mcXVvdDspPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGV4Y2VwdCBnZXRvcHQuZXJyb3IsIG1zZzo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBVc2FnZShtc2cpPGJyPg0KLTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHNoPXNlbWFuYWdlLnNlbWFuYWdlX2hhbmRsZV88d2JyPmNyZWF0ZSgp
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHNlbWFuYWdlLnNlbWFuYWdlX2lzX21hbmFnZWQoPHdicj5zaCkgIT0gMSk6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmFpc2UgU3RhdHVzKCZxdW90O1Vu
bWFuYWdlZCEmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID0gc2VtYW5hZ2Uuc2VtYW5hZ2VfY29ubmVjdChzaCk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzdGF0dXMgJmx0OyAwOjxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJhaXNlIEVycm9yKCZxdW90O0NvdWxkIG5v
dCBlc3RhYmxpc2ggc2VtYW5hZ2UgY29ubmVjdGlvbiZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgdGVzdHMucnVuKHNoKTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdGF0dXMgPSBzZW1hbmFnZS5zZW1hbmFnZV9kaXNjb25uZWN0KDx3YnI+c2gp
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgc3RhdHVzICZsdDsgMDo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZSBFcnJvcigmcXVvdDtDb3VsZCBu
b3QgZGlzY29ubmVjdCZxdW90Oyk8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c2VtYW5hZ2Uuc2VtYW5hZ2VfaGFuZGxlXzx3YnI+ZGVzdHJveShzaCk8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgZXhjZXB0IFVzYWdlLCBlcnI6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cHJpbnQgJmd0OyZndDtzeXMuc3RkZXJyLCBlcnIubXNnPGJyPg0KLcKgIMKgIMKgIMKgZXhjZXB0
IFN0YXR1cywgZXJyOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZndDsmZ3Q7
c3lzLnN0ZGVyciwgZXJyLm1zZzxicj4NCi3CoCDCoCDCoCDCoGV4Y2VwdCBFcnJvciwgZXJyOjxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50ICZndDsmZ3Q7c3lzLnN0ZGVyciwgZXJy
Lm1zZzxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgcmV0dXJuIDI8YnI+DQorwqAgwqAgaWYgYXJn
diBpcyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCBhcmd2ID0gc3lzLmFyZ3Y8YnI+DQorwqAgwqAg
dHJ5Ojxicj4NCivCoCDCoCDCoCDCoCB0cnk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIG9wdHMs
IGFyZ3MgPSBnZXRvcHQuZ2V0b3B0KGFyZ3ZbMTpdLCAmcXVvdDtodm11c3BmaWJjVVNQRklCQ2Fu
TiZxdW90OywgWyZxdW90O2hlbHAmcXVvdDssICZxdW90O3ZlcmJvc2UmcXVvdDssICZxdW90O21v
ZHVsZXMmcXVvdDssICZxdW90O3VzZXJzJnF1b3Q7LCAmcXVvdDtzZXVzZXJzJnF1b3Q7LCAmcXVv
dDtwb3J0cyZxdW90OywgJnF1b3Q7ZmlsZSBjb250ZXh0cyZxdW90OywgJnF1b3Q7bmV0d29yayBp
bnRlcmZhY2VzJnF1b3Q7LCAmcXVvdDtib29sZWFucyZxdW90OywgJnF1b3Q7YWN0aXZlIGJvb2xl
YW5zJnF1b3Q7LCAmcXVvdDtuZXR3b3JrIG5vZGVzJnF1b3Q7LCAmcXVvdDt3cml0ZXVzZXImcXVv
dDssICZxdW90O3dyaXRlc2V1c2VyJnF1b3Q7LCAmcXVvdDt3cml0ZXBvcnQmcXVvdDssICZxdW90
O3dyaXRlZmNvbnRleHQmcXVvdDssICZxdW90O3dyaXRlaW50ZXJmYWNlJnF1b3Q7LCAmcXVvdDt3
cml0ZWJvb2xlYW4mcXVvdDssICZxdW90O3dyaXRlYWJvb2xlYW4mcXVvdDssICZxdW90O3dyaXRl
bm9kZSZxdW90OywgJnF1b3Q7YWxsJnF1b3Q7XSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVz
dHMgPSBUZXN0cygpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZvciBvLCBhIGluIG9wdHM6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LXYmcXVvdDs6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLnZlcmJvc2UgPSBUcnVlPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50ICZxdW90O1ZlcmJvc2Ugb3V0cHV0
IHNlbGVjdGVkLiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZx
dW90Oy1hJnF1b3Q7Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy5h
bGwgPSBUcnVlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LXUm
cXVvdDs6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLnVzZXJzID0g
VHJ1ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1VJnF1b3Q7
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy53cml0ZXVzZXIgPSBU
cnVlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LXMmcXVvdDs6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLnNldXNlcnMgPSBUcnVl
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LVMmcXVvdDs6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLndyaXRlc2V1c2VyID0gVHJ1
ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1wJnF1b3Q7Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy5wb3J0cyA9IFRydWU8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgbyA9PSAmcXVvdDstUCZxdW90Ozo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdHMud3JpdGVwb3J0ID0gVHJ1ZTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1mJnF1b3Q7Ojxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy5mY29udGV4dHMgPSBUcnVlPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LUYmcXVvdDs6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLndyaXRlZmNvbnRleHQgPSBUcnVlPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LWkmcXVvdDs6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLmludGVyZmFjZXMgPSBUcnVlPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LUkmcXVvdDs6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLndyaXRlaW50ZXJmYWNlID0gVHJ1
ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1iJnF1b3Q7Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy5ib29sZWFucyA9IFRydWU8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgbyA9PSAmcXVvdDstQiZxdW90Ozo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdHMud3JpdGVib29sZWFuID0gVHJ1
ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1jJnF1b3Q7Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy5hYm9vbGVhbnMgPSBUcnVl
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LUMmcXVvdDs6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLndyaXRlYWJvb2xlYW4gPSBU
cnVlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LW4mcXVvdDs6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLm5vZGVzID0gVHJ1ZTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBvID09ICZxdW90Oy1OJnF1b3Q7Ojxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0cy53cml0ZW5vZGUgPSBUcnVlPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LW0mcXVvdDs6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3RzLm1vZHVsZXMgPSBUcnVlPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIG8gPT0gJnF1b3Q7LWgmcXVvdDs6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIFVzYWdlKHVzYWdlKTxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgbm90IHRlc3RzLnNlbGVjdGVkKCk6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIFVzYWdlKCZxdW90O1BsZWFzZSBzZWxlY3QgYSB2YWxp
ZCB0ZXN0LiZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGV4Y2VwdCBnZXRvcHQuZXJy
b3IsIG1zZzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgVXNhZ2UobXNnKTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgc2g9c2VtYW5hZ2Uuc2VtYW5hZ2VfaGFuZGxlXzx3YnI+Y3JlYXRl
KCk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmIChzZW1hbmFnZS5zZW1hbmFnZV9pc19tYW5h
Z2VkKDx3YnI+c2gpICE9IDEpOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByYWlzZSBTdGF0dXMo
JnF1b3Q7VW5tYW5hZ2VkISZxdW90Oyk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX2Nvbm5lY3Qoc2gpPGJyPg0KK8KgIMKgIMKgIMKgIGlmIHN0YXR1
cyAmbHQ7IDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIEVycm9yKCZxdW90O0NvdWxk
IG5vdCBlc3RhYmxpc2ggc2VtYW5hZ2UgY29ubmVjdGlvbiZxdW90Oyk8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIHRlc3RzLnJ1bihzaCk8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHN0YXR1cyA9
IHNlbWFuYWdlLnNlbWFuYWdlX2Rpc2Nvbm5lY3QoPHdicj5zaCk8YnI+DQorwqAgwqAgwqAgwqAg
aWYgc3RhdHVzICZsdDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmFpc2UgRXJyb3IoJnF1
b3Q7Q291bGQgbm90IGRpc2Nvbm5lY3QmcXVvdDspPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBz
ZW1hbmFnZS5zZW1hbmFnZV9oYW5kbGVfPHdicj5kZXN0cm95KHNoKTxicj4NCis8YnI+DQorwqAg
wqAgZXhjZXB0IFVzYWdlLCBlcnI6PGJyPg0KK8KgIMKgIMKgIMKgIHByaW50ICZndDsmZ3Q7c3lz
LnN0ZGVyciwgZXJyLm1zZzxicj4NCivCoCDCoCBleGNlcHQgU3RhdHVzLCBlcnI6PGJyPg0KK8Kg
IMKgIMKgIMKgIHByaW50ICZndDsmZ3Q7c3lzLnN0ZGVyciwgZXJyLm1zZzxicj4NCivCoCDCoCBl
eGNlcHQgRXJyb3IsIGVycjo8YnI+DQorwqAgwqAgwqAgwqAgcHJpbnQgJmd0OyZndDtzeXMuc3Rk
ZXJyLCBlcnIubXNnPGJyPg0KKzxicj4NCivCoCDCoCByZXR1cm4gMjxicj4NCjxicj4NCsKgaWYg
X19uYW1lX18gPT0gJnF1b3Q7X19tYWluX18mcXVvdDs6PGJyPg0KLcKgIMKgIMKgIMKgc3lzLmV4
aXQobWFpbigpKTxicj4NCi08YnI+DQorwqAgwqAgc3lzLmV4aXQobWFpbigpKTxicj4NCjxzcGFu
IGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLSA8YnI+DQoyLjE4LjA8YnI+
DQo8YnI+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX188d2JyPl9fX19fX19fX19fX19f
X19fPGJyPg0KU2VsaW51eCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86U2VsaW51
eEB0eWNoby5uc2EuZ292Ij5TZWxpbnV4QHR5Y2hvLm5zYS5nb3Y8L2E+PGJyPg0KVG8gdW5zdWJz
Y3JpYmUsIHNlbmQgZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOlNlbGludXgtbGVhdmVAdHljaG8u
bnNhLmdvdiI+U2VsaW51eC1sZWF2ZUB0eWNoby5uc2EuZ292PC9hPi48YnI+DQpUbyBnZXQgaGVs
cCwgc2VuZCBhbiBlbWFpbCBjb250YWluaW5nICZxdW90O2hlbHAmcXVvdDsgdG8gPGEgaHJlZj0i
bWFpbHRvOlNlbGludXgtcmVxdWVzdEB0eWNoby5uc2EuZ292Ij5TZWxpbnV4LXJlcXVlc3RAdHlj
aG8ubnNhLmdvdjwvYT4uPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJy
PjwvZGl2Pg0K
--000000000000e0014b0573ba0e8d--
