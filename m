Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4ECHAH7023335
 for <selinux@tycho.nsa.gov>; Sun, 14 May 2017 08:17:10 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so49908300pfh.0
 for <selinux@tycho.nsa.gov>; Sun, 14 May 2017 05:17:04 -0700 (PDT)
Date: Sun, 14 May 2017 20:16:59 +0800
From: Jason Zaman <jason@perfinion.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 8/9] semanage: Update semanage to allow runtime labeling
 of ibendports
Message-ID: <20170514121659.GA21543@meriadoc.perfinion.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-9-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494363042-121766-9-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 09, 2017 at 11:50:41PM +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Update libsepol and libsemanage to work with ibendport records. Add local
> storage for new and modified ibendport records in ibendports.local.
> Update semanage to parse the ibendport command options to add, modify,
> and delete them.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>  libsemanage/include/semanage/ibendport_record.h  |   62 +++++
>  libsemanage/include/semanage/ibendports_local.h  |   36 +++
>  libsemanage/include/semanage/ibendports_policy.h |   28 ++
>  libsemanage/include/semanage/semanage.h          |    3 +
>  libsemanage/src/direct_api.c                     |   42 +++-
>  libsemanage/src/handle.h                         |   38 ++-
>  libsemanage/src/ibendport_internal.h             |   48 ++++
>  libsemanage/src/ibendport_record.c               |  154 +++++++++++
>  libsemanage/src/ibendports_file.c                |  157 +++++++++++
>  libsemanage/src/ibendports_local.c               |  153 +++++++++++
>  libsemanage/src/ibendports_policy.c              |   55 ++++
>  libsemanage/src/ibendports_policydb.c            |   62 +++++
>  libsemanage/src/libsemanage.map                  |    1 +
>  libsemanage/src/policy_components.c              |    4 +
>  libsemanage/src/semanage_store.c                 |    1 +
>  libsemanage/src/semanage_store.h                 |    1 +
>  libsemanage/src/semanageswig.i                   |    3 +
>  libsemanage/src/semanageswig_python.i            |   43 +++
>  libsemanage/utils/semanage_migrate_store         |    3 +-
>  libsepol/include/sepol/ibendport_record.h        |   68 +++++
>  libsepol/include/sepol/ibendports.h              |   45 ++++
>  libsepol/include/sepol/sepol.h                   |    2 +
>  libsepol/src/ibendport_internal.h                |   20 ++
>  libsepol/src/ibendport_record.c                  |  299 ++++++++++++++++++++++
>  libsepol/src/ibendports.c                        |  255 ++++++++++++++++++
>  python/semanage/semanage                         |   58 ++++-
>  python/semanage/seobject.py                      |  238 +++++++++++++++++
>  27 files changed, 1857 insertions(+), 22 deletions(-)
>  create mode 100644 libsemanage/include/semanage/ibendport_record.h
>  create mode 100644 libsemanage/include/semanage/ibendports_local.h
>  create mode 100644 libsemanage/include/semanage/ibendports_policy.h
>  create mode 100644 libsemanage/src/ibendport_internal.h
>  create mode 100644 libsemanage/src/ibendport_record.c
>  create mode 100644 libsemanage/src/ibendports_file.c
>  create mode 100644 libsemanage/src/ibendports_local.c
>  create mode 100644 libsemanage/src/ibendports_policy.c
>  create mode 100644 libsemanage/src/ibendports_policydb.c
>  create mode 100644 libsepol/include/sepol/ibendport_record.h
>  create mode 100644 libsepol/include/sepol/ibendports.h
>  create mode 100644 libsepol/src/ibendport_internal.h
>  create mode 100644 libsepol/src/ibendport_record.c
>  create mode 100644 libsepol/src/ibendports.c

[ ... ]

> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 11b56e2..313537c 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -61,6 +61,9 @@ usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_n
>  usage_ibpkey = "semanage ibpkey [-h] [-n] [-N] [-s STORE] ["
>  usage_ibpkey_dict = {' --add': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --modify': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --delete': ('-x SUBNET_PREFIX', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>  
> +usage_ibendport = "semanage ibendport [-h] [-n] [-N] [-s STORE] ["
> +usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE''(', 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> +
>  usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
>  usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>  
> @@ -152,6 +155,10 @@ def ibpkey_ini():
>      OBJECT = seobject.ibpkeyRecords(store)
>      return OBJECT
>  
> +def ibendport_ini():
> +    OBJECT = seobject.ibendportRecords(store)
> +    return OBJECT
> +
>  def module_ini():
>      OBJECT = seobject.moduleRecords(store)
>      return OBJECT
> @@ -187,8 +194,7 @@ def dontaudit_ini():
>      return OBJECT
>  
>  # define dictonary for seobject OBEJCTS
> -object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini}
> -
> +object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini, 'ibendport': ibendport_ini}
>  
>  def generate_custom_usage(usage_text, usage_dict):
>      # generate custom usage from given text and dictonary
> @@ -303,6 +309,10 @@ def parser_add_subnet_prefix(parser, name):
>      Subnet prefix for  the specified infiniband ibpkey.
>  '''))
>  
> +def parser_add_ibdev_name(parser, name):
> +    parser.add_argument('-z', '--ibdev_name', help=_('''
> +    Name for the specified infiniband end port.
> +'''))
>  
>  def parser_add_modify(parser, name):
>      parser.add_argument('-m', '--modify', dest='action', action='store_const', const='modify', help=_("Modify a record of the %s object type") % name)
> @@ -567,6 +577,49 @@ def setupPkeyParser(subparsers):
>      ibpkeyParser.add_argument('ibpkey', nargs='?', default=None, help=_('pkey | pkey_range'))
>      ibpkeyParser.set_defaults(func=handlePkey)
>  
> +def handleIbendport(args):
> +    ibendport_args = {'list': [('ibendport', 'type', 'ibdev_name'), ('')], 'add': [('locallist'), ('type', 'ibendport', 'ibdev_name'), ('')], 'modify': [('localist'), ('ibendport', 'ibdev_name')], 'delete': [('locallist'), ('ibendport', 'ibdev_name')], 'extract': [('locallist', 'ibendport', 'type', 'ibdev_name'), ('')], 'deleteall': [('locallist'), ('')]}
> +
> +    handle_opts(args, ibendport_args, args.action)
> +
> +    OBJECT = object_dict['ibendport']()
> +    OBJECT.set_reload(args.noreload)
> +
> +    if args.action is "add":
> +        OBJECT.add(args.ibendport, args.ibdev_name, args.range, args.type)
> +    if args.action is "modify":
> +        OBJECT.modify(args.ibendport, args.ibdev_name, args.range, args.type)
> +    if args.action is "delete":
> +        OBJECT.delete(args.ibendport, args.ibdev_name)
> +    if args.action is "list":
> +        OBJECT.list(args.noheading, args.locallist)
> +    if args.action is "deleteall":
> +        OBJECT.deleteall()
> +    if args.action is "extract":
> +        for i in OBJECT.customized():
> +            print("ibendport %s" % str(i))
> +
> +
> +def setupIbendportParser(subparsers):
> +    generated_usage = generate_custom_usage(usage_ibendport, usage_ibendport_dict)
> +    ibendportParser = subparsers.add_parser('ibendport', usage=generated_usage, help=_('Manage infiniband end port type definitions'))
> +    parser_add_locallist(ibendportParser, "ibendport")
> +    parser_add_noheading(ibendportParser, "ibendport")
> +    parser_add_noreload(ibendportParser, "ibendport")
> +    parser_add_store(ibendportParser, "ibendport")
> +
> +    ibendport_action = ibendportParser.add_mutually_exclusive_group(required=True)
> +    parser_add_add(ibendport_action, "ibendport")
> +    parser_add_delete(ibendport_action, "ibendport")
> +    parser_add_modify(ibendport_action, "ibendport")
> +    parser_add_list(ibendport_action, "ibendport")
> +    parser_add_extract(ibendport_action, "ibendport")
> +    parser_add_deleteall(ibendport_action, "ibendport")
> +    parser_add_type(ibendportParser, "ibendport")
> +    parser_add_range(ibendportParser, "ibendport")
> +    parser_add_ibdev_name(ibendportParser, "ibendport")
> +    ibendportParser.add_argument('ibendport', nargs='?', default=None, help=_('ibendport'))
> +    ibendportParser.set_defaults(func=handleIbendport)
>  
>  def handleInterface(args):
>      interface_args = {'list': [('interface'), ('')], 'add': [('locallist'), ('type', 'interface')], 'modify': [('locallist'), ('type', 'interface')], 'delete': [('locallist'), ('interface')], 'extract': [('locallist', 'interface', 'type'), ('')], 'deleteall': [('locallist'), ('')]}
> @@ -907,6 +960,7 @@ def createCommandParser():
>      setupUserParser(subparsers)
>      setupPortParser(subparsers)
>      setupPkeyParser(subparsers)
> +    setupIbendportParser(subparsers)
>      setupInterfaceParser(subparsers)
>      setupModuleParser(subparsers)
>      setupNodeParser(subparsers)
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 02ad9f3..895becd 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1563,6 +1563,244 @@ class ibpkeyRecords(semanageRecords):
>                  rec += ", %s" % p
>              print rec
>  
> +class ibendportRecords(semanageRecords):
> +    try:
> +        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "ibendport_type"))[0]["types"])
> +    except RuntimeError:
> +        valid_types = []

Can you use setools4 directly instead of sepolicy.info()? It's an
abomination now and I only "fixed" it to keep backwards compat. It's
super slow cuz it has to loop through what setools returns and stuff it
into a dict to match the old info() format.

When I have time I want to kill most of seobject.py because its now
mostly just slow wrappers around setools4. New stuff shouldnt really use
it.

> +    def __init__(self, store=""):
> +        semanageRecords.__init__(self, store)
> +
> +    def __genkey(self, ibendport, ibdev_name):
> +	if ibdev_name == "":
> +            raise ValueError(_("IB device name is required"))
> +
> +        port = int(ibendport)
> +
> +        if port > 255 or port < 1:
> +            raise ValueError(_("Invalid Port Number"))
> +
> +        (rc, k) = semanage_ibendport_key_create(self.sh, ibdev_name, port)
> +        if rc < 0:
> +            raise ValueError(_("Could not create a key for ibendport %s/%s") % (ibdev_name, ibendport))
> +        return (k, ibdev_name, port)
> +
> +    def __add(self, ibendport, ibdev_name, serange, type):
> +        if is_mls_enabled == 1:
> +            if serange == "":
> +                serange = "s0"
> +            else:
> +                serange = untranslate(serange)
> +
> +        if type == "":
> +            raise ValueError(_("Type is required"))
> +
> +        if type not in self.valid_types:
> +            raise ValueError(_("Type %s is invalid, must be an ibendport type") % type)
> +        (k, ibendport, port) = self.__genkey(ibendport, ibdev_name)
> +
> +        (rc, exists) = semanage_ibendport_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, port))
> +        if exists:
> +            raise ValueError(_("ibendport %s/%s already defined") % (ibdev_name, port))
> +
> +        (rc, p) = semanage_ibendport_create(self.sh)
> +        if rc < 0:
> +            raise ValueError(_("Could not create ibendport for %s/%s") % (ibdev_name, port))
> +
> +        semanage_ibendport_set_ibdev_name(self.sh, p, ibdev_name)
> +        semanage_ibendport_set_port(p, port)
> +        (rc, con) = semanage_context_create(self.sh)
> +        if rc < 0:
> +            raise ValueError(_("Could not create context for %s/%s") % (ibdev_name, port))
> +
> +        rc = semanage_context_set_user(self.sh, con, "system_u")
> +        if rc < 0:
> +            raise ValueError(_("Could not set user in ibendport context for %s/%s") % (ibdev_name, port))
> +
> +        rc = semanage_context_set_role(self.sh, con, "object_r")
> +        if rc < 0:
> +            raise ValueError(_("Could not set role in ibendport context for %s/%s") % (ibdev_name, port))
> +
> +        rc = semanage_context_set_type(self.sh, con, type)
> +        if rc < 0:
> +            raise ValueError(_("Could not set type in ibendport context for %s/%s") % (ibdev_name, port))
> +
> +        if (is_mls_enabled == 1) and (serange != ""):
> +            rc = semanage_context_set_mls(self.sh, con, serange)
> +            if rc < 0:
> +                raise ValueError(_("Could not set mls fields in ibendport context for %s/%s") % (ibdev_name, port))
> +
> +        rc = semanage_ibendport_set_con(self.sh, p, con)
> +        if rc < 0:
> +            raise ValueError(_("Could not set ibendport context for %s/%s") % (ibdev_name, port))
> +
> +        rc = semanage_ibendport_modify_local(self.sh, k, p)
> +        if rc < 0:
> +            raise ValueError(_("Could not add ibendport %s/%s") % (ibdev_name, port))
> +
> +        semanage_context_free(con)
> +        semanage_ibendport_key_free(k)
> +        semanage_ibendport_free(p)
> +
> +    def add(self, ibendport, ibdev_name, serange, type):
> +        self.begin()
> +        self.__add(ibendport, ibdev_name, serange, type)
> +        self.commit()
> +
> +    def __modify(self, ibendport, ibdev_name, serange, setype):
> +        if serange == "" and setype == "":
> +            if is_mls_enabled == 1:
> +                raise ValueError(_("Requires setype or serange"))
> +            else:
> +                raise ValueError(_("Requires setype"))
> +
> +        if setype and setype not in self.valid_types:
> +            raise ValueError(_("Type %s is invalid, must be an ibendport type") % setype)
> +
> +        (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
> +
> +        (rc, exists) = semanage_ibendport_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +        if not exists:
> +            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
> +
> +        (rc, p) = semanage_ibendport_query(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not query ibendport %s/%s") % (ibdev_name, ibendport))
> +
> +        con = semanage_ibendport_get_con(p)
> +
> +        if (is_mls_enabled == 1) and (serange != ""):
> +            semanage_context_set_mls(self.sh, con, untranslate(serange))
> +        if setype != "":
> +            semanage_context_set_type(self.sh, con, setype)
> +
> +        rc = semanage_ibendport_modify_local(self.sh, k, p)
> +        if rc < 0:
> +            raise ValueError(_("Could not modify ibendport %s/%s") % (ibdev_name, ibendport))
> +
> +        semanage_ibendport_key_free(k)
> +        semanage_ibendport_free(p)
> +
> +    def modify(self, ibendport, ibdev_name, serange, setype):
> +        self.begin()
> +        self.__modify(ibendport, ibdev_name, serange, setype)
> +        self.commit()
> +
> +    def deleteall(self):
> +        (rc, plist) = semanage_ibendport_list_local(self.sh)
> +        if rc < 0:
> +            raise ValueError(_("Could not list the ibendports"))
> +
> +        self.begin()
> +
> +        for ibendport in plist:
> +            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
> +            port = semanage_ibendport_get_port(ibendport)
> +            (k, ibdev_name, port) = self.__genkey(str(port), ibdev_name)
> +            if rc < 0:
> +                raise ValueError(_("Could not create a key for %s/%d") % (ibdevname, port))
> +
> +            rc = semanage_ibendport_del_local(self.sh, k)
> +            if rc < 0:
> +                raise ValueError(_("Could not delete the ibendport %s/%d") % (ibdev_name, port))
> +            semanage_ibendport_key_free(k)
> +
> +        self.commit()
> +
> +    def __delete(self, ibendport, ibdev_name):
> +        (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
> +        (rc, exists) = semanage_ibendport_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +        if not exists:
> +            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
> +
> +        (rc, exists) = semanage_ibendport_exists_local(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
> +        if not exists:
> +            raise ValueError(_("ibendport %s/%s is defined in policy, cannot be deleted") % (ibdev_name, ibendport))
> +
> +        rc = semanage_ibendport_del_local(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not delete ibendport %s/%s") % (ibdev_name, ibendport))
> +
> +        semanage_ibendport_key_free(k)
> +
> +    def delete(self, ibendport, ibdev_name):
> +        self.begin()
> +        self.__delete(ibendport, ibdev_name)
> +        self.commit()
> +
> +    def get_all(self, locallist=0):
> +        ddict = {}
> +        if locallist:
> +            (rc, self.plist) = semanage_ibendport_list_local(self.sh)
> +        else:
> +            (rc, self.plist) = semanage_ibendport_list(self.sh)
> +        if rc < 0:
> +            raise ValueError(_("Could not list ibendports"))
> +
> +        for ibendport in self.plist:
> +            con = semanage_ibendport_get_con(ibendport)
> +            ctype = semanage_context_get_type(con)
> +            if ctype == "reserved_ibendport_t":
> +                continue
> +            level = semanage_context_get_mls(con)
> +            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
> +            port = semanage_ibendport_get_port(ibendport)
> +            ddict[(port, ibdev_name)] = (ctype, level)
> +        return ddict
> +
> +    def get_all_by_type(self, locallist=0):
> +        ddict = {}
> +        if locallist:
> +            (rc, self.plist) = semanage_ibendport_list_local(self.sh)
> +        else:
> +            (rc, self.plist) = semanage_ibendport_list(self.sh)
> +        if rc < 0:
> +            raise ValueError(_("Could not list ibendports"))
> +
> +        for ibendport in self.plist:
> +            con = semanage_ibendport_get_con(ibendport)
> +            ctype = semanage_context_get_type(con)
> +            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
> +            port = semanage_ibendport_get_port(ibendport)
> +            if (ctype, ibdev_name) not in ddict.keys():
> +                ddict[(ctype, ibdev_name)] = []
> +            ddict[(ctype, ibdev_name)].append("0x%x" % port)
> +        return ddict
> +
> +    def customized(self):
> +        l = []
> +        ddict = self.get_all(True)
> +        keys = ddict.keys()
> +        keys.sort()
> +        for k in keys:
> +            l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
> +        return l
> +
> +    def list(self, heading=1, locallist=0):
> +        ddict = self.get_all_by_type(locallist)
> +        keys = ddict.keys()
> +        if len(keys) == 0:
> +            return
> +        keys.sort()
> +
> +        if heading:
> +            print "%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number"))
> +        for i in keys:
> +            rec = "%-30s %-18s " % i
> +            rec += "%s" % ddict[i][0]
> +            for p in ddict[i][1:]:
> +                rec += ", %s" % p
> +            print rec
> +
>  class nodeRecords(semanageRecords):
>      try:
>          valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> -- 
> 1.7.1
> 
