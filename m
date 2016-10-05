Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u959XCER002322
 for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2016 05:33:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id e6so30142947pfk.1
 for <selinux@tycho.nsa.gov>; Wed, 05 Oct 2016 02:33:10 -0700 (PDT)
Received: from localhost ([2404:e800:e600:540:e4c7:e123:7bab:ce0b])
 by smtp.gmail.com with ESMTPSA id y11sm61583160pfa.4.2016.10.05.02.33.08
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2016 02:33:08 -0700 (PDT)
Date: Wed, 5 Oct 2016 17:33:06 +0800
From: Jason Zaman <jason@perfinion.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Gold linker build failures
Message-ID: <20161005093306.GB8208@meriadoc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey all,

libsepol (and probably the rest) fail when using ld.gold for me. We should
probably start supporting gold since it looks like things are slowly moving
towards using it by default. Gentoo and fedora both look like they have a way
to switch to it but for now the default is still ld.bfd. I dont think I'll have
much time to take a stab at this for a quite a while and don't know much about
linker scripts and versioned symbols either.

On fedora this should switch: /usr/sbin/alternatives --set ld /usr/bin/ld.gold

On Gentoo:
# binutils-config --linker ld.gold
# ld --version
GNU gold (Gentoo 2.25.1 p1.1 2.25.1) 1.11
Copyright (C) 2014 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.


cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -fPIC -DSHARED -c -o ../cil/src/cil_verify.lo ../cil/src/cil_verify.c
cp libsepol.map.in libsepol.map
cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -g -shared -o libsepol.so.1 assertion.lo avrule_block.lo avtab.lo boolean_record.lo booleans.lo conditional.lo constraint.lo context.lo context_record.lo debug.lo ebitmap.lo expand.lo genbools.lo genusers.lo handle.lo hashtab.lo hierarchy.lo iface_record.lo interfaces.lo link.lo mls.lo module.lo module_to_cil.lo node_record.lo nodes.lo polcaps.lo policydb.lo policydb_convert.lo policydb_public.lo port_record.lo ports.lo roles.lo services.lo sidtab.lo symtab.lo user_record.lo users.lo util.lo write.lo ../cil/src/cil.lo ../cil/src/cil_binary.lo ../cil/src/cil_build_ast.lo ../cil/src/cil_copy_ast.lo ../cil/src/cil_find.lo ../cil/src/cil_fqn.lo ../cil/src/cil_lexer.lo ../cil/src/cil_list.lo ../cil/src/cil_log.lo ../cil/src/cil_mem.lo ../cil/src/cil_parser.lo ../cil/src/cil_policy.lo ../cil/src/cil_post.lo ../cil/src/cil_reset_ast.lo ../cil/src/cil_resolve_ast.lo ../cil/src/cil_stack.lo ../cil/src/cil_strpool.lo ../cil/src/cil_symtab.lo ../cil/src/cil_tree.lo ../cil/src/cil_verify.lo -Wl,-soname,libsepol.so.1,--version-script=libsepol.map,-z,defs
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: warning: wildcard match appears in both version 'LIBSEPOL_1.0' and 'LIBSEPOL_1.1' in script
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: symbol cil_build_policydb has undefined version 
collect2: error: ld returned 1 exit status
Makefile:42: recipe for target 'libsepol.so.1' failed
make[2]: *** [libsepol.so.1] Error 1


-- Jason
