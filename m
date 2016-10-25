Date: Tue, 25 Oct 2016 12:26:37 +0800
From: Jason Zaman <perfinion@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jason Zaman <jason@perfinion.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Gold linker build failures
Message-ID: <20161025042637.GB25830@meriadoc.perfinion.com>
References: <20161005093306.GB8208@meriadoc>
 <870fc9a1-a187-f8e4-dd51-e648b1ed5b21@tycho.nsa.gov>
 <91d49ae1-92a2-a4e9-aaad-579bf2675763@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91d49ae1-92a2-a4e9-aaad-579bf2675763@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 05, 2016 at 01:27:50PM -0400, Stephen Smalley wrote:
> On 10/05/2016 01:02 PM, Stephen Smalley wrote:
> > On 10/05/2016 05:33 AM, Jason Zaman wrote:
> >> Hey all,
> >>
> >> libsepol (and probably the rest) fail when using ld.gold for me. We should
> >> probably start supporting gold since it looks like things are slowly moving
> >> towards using it by default. Gentoo and fedora both look like they have a way
> >> to switch to it but for now the default is still ld.bfd. I dont think I'll have
> >> much time to take a stab at this for a quite a while and don't know much about
> >> linker scripts and versioned symbols either.
> >>
> >> On fedora this should switch: /usr/sbin/alternatives --set ld /usr/bin/ld.gold
> >>
> >> On Gentoo:
> >> # binutils-config --linker ld.gold
> >> # ld --version
> >> GNU gold (Gentoo 2.25.1 p1.1 2.25.1) 1.11
> >> Copyright (C) 2014 Free Software Foundation, Inc.
> >> This program is free software; you may redistribute it under the terms of
> >> the GNU General Public License version 3 or (at your option) a later version.
> >> This program has absolutely no warranty.
> >>
> >>
> >> cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -fPIC -DSHARED -c -o ../cil/src/cil_verify.lo ../cil/src/cil_verify.c
> >> cp libsepol.map.in libsepol.map
> >> cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -g -shared -o libsepol.so.1 assertion.lo avrule_block.lo avtab.lo boolean_record.lo booleans.lo conditional.lo constraint.lo context.lo context_record.lo debug.lo ebitmap.lo expand.lo genbools.lo genusers.lo handle.lo hashtab.lo hierarchy.lo iface_record.lo interfaces.lo link.lo mls.lo module.lo module_to_cil.lo node_record.lo nodes.lo polcaps.lo policydb.lo policydb_convert.lo policydb_public.lo port_record.lo ports.lo roles.lo services.lo sidtab.lo symtab.lo user_record.lo users.lo util.lo write.lo ../cil/src/cil.lo ../cil/src/cil_binary.lo ../cil/src/cil_build_ast.lo ../cil/src/cil_copy_ast.lo ../cil/src/cil_find.lo ../cil/src/cil_fqn.lo ../cil/src/cil_lexer.lo ../cil/src/cil_list.lo ../cil/src/cil_log.lo ../cil/src/cil_mem.lo ../cil/src/cil_parser.lo ../cil/src/cil_policy.lo ../cil/src/cil_post.lo ../cil/src/cil_reset_ast.lo ../cil/src/cil_resolve_ast.lo ../cil/src/cil_stack.lo ../cil/src/cil_strpool.lo ../cil/src/cil_symtab.lo ../cil/src/cil_tree.lo ../cil/src/cil_verify.lo -Wl,-soname,libsepol.so.1,--version-script=libsepol.map,-z,defs
> >> /usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: warning: wildcard match appears in both version 'LIBSEPOL_1.0' and 'LIBSEPOL_1.1' in script
> >> /usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: symbol cil_build_policydb has undefined version 
> >> collect2: error: ld returned 1 exit status
> >> Makefile:42: recipe for target 'libsepol.so.1' failed
> >> make[2]: *** [libsepol.so.1] Error 1
> > 
> > I could reproduce and fix the wildcard match error - that's clearly a
> > bug in the map files.  I don't see the second error though on Fedora
> > with GNU gold version 2.26.1, and I'm not clear on what the underlying
> > issue is.
> 
> Actually, reading:
> https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_node/ld_25.html
> I'm thinking that libsepol/cil/src/cil.c is wrong and ought to have
> @LIBSEPOL_1.0 as the suffix rather than just @ for all of the old
> symbols there.  But as I said, I couldn't reproduce the error.
> 
> 

On master I get:

cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -g -shared -o libsepol.so.1 assertion.lo avrule_block.lo avtab.lo boolean_record.lo booleans.lo conditional.lo constraint.lo context.lo context_record.lo debug.lo ebitmap.lo expand.lo genbools.lo genusers.lo handle.lo hashtab.lo hierarchy.lo iface_record.lo interfaces.lo link.lo mls.lo module.lo module_to_cil.lo node_record.lo nodes.lo polcaps.lo policydb.lo policydb_convert.lo policydb_public.lo port_record.lo ports.lo roles.lo services.lo sidtab.lo symtab.lo user_record.lo users.lo util.lo write.lo ../cil/src/cil.lo ../cil/src/cil_binary.lo ../cil/src/cil_build_ast.lo ../cil/src/cil_copy_ast.lo ../cil/src/cil_find.lo ../cil/src/cil_fqn.lo ../cil/src/cil_lexer.lo ../cil/src/cil_list.lo ../cil/src/cil_log.lo ../cil/src/cil_mem.lo ../cil/src/cil_parser.lo ../cil/src/cil_policy.lo ../cil/src/cil_post.lo ../cil/src/cil_reset_ast.lo ../cil/src/cil_resolve_ast.lo ../cil/src/cil_stack.lo ../cil/src/cil_strpool.lo ../cil/src/cil_symtab.lo ../cil/src/cil_tree.lo ../cil/src/cil_verify.lo -Wl,-soname,libsepol.so.1,--version-script=libsepol.map,-z,defs
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: symbol cil_build_policydb has undefined version 
collect2: error: ld returned 1 exit status
Makefile:49: recipe for target 'libsepol.so.1' failed
make[2]: *** [libsepol.so.1] Error 1


Then I did the following:
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 929ab19..aed8c89 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -53,19 +53,19 @@
 #include "dso.h"
 
 #ifndef DISABLE_SYMVER
-asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
+asm(".symver cil_build_policydb_pdb,        cil_build_policydb@@LIBSEPOL_1.0");
 asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
 
-asm(".symver cil_compile_pdb,   cil_compile@");
+asm(".symver cil_compile_pdb,   cil_compile@@LIBSEPOL_1.0");
 asm(".symver cil_compile_nopdb, cil_compile@@LIBSEPOL_1.1");
 
-asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@");
+asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@@LIBSEPOL_1.0");
 asm(".symver cil_userprefixes_to_string_nopdb, cil_userprefixes_to_string@@LIBSEPOL_1.1");
 
-asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@");
+asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@@LIBSEPOL_1.0");
 asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSEPOL_1.1");
 
-asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
+asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@@LIBSEPOL_1.0");
 asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
 #endif
 

And now I get this instead:

cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I. -I../include -D_GNU_SOURCE -I../cil/include -g -shared -o libsepol.so.1 assertion.lo avrule_block.lo avtab.lo boolean_record.lo booleans.lo conditional.lo constraint.lo context.lo context_record.lo debug.lo ebitmap.lo expand.lo genbools.lo genusers.lo handle.lo hashtab.lo hierarchy.lo iface_record.lo interfaces.lo link.lo mls.lo module.lo module_to_cil.lo node_record.lo nodes.lo polcaps.lo policydb.lo policydb_convert.lo policydb_public.lo port_record.lo ports.lo roles.lo services.lo sidtab.lo symtab.lo user_record.lo users.lo util.lo write.lo ../cil/src/cil.lo ../cil/src/cil_binary.lo ../cil/src/cil_build_ast.lo ../cil/src/cil_copy_ast.lo ../cil/src/cil_find.lo ../cil/src/cil_fqn.lo ../cil/src/cil_lexer.lo ../cil/src/cil_list.lo ../cil/src/cil_log.lo ../cil/src/cil_mem.lo ../cil/src/cil_parser.lo ../cil/src/cil_policy.lo ../cil/src/cil_post.lo ../cil/src/cil_reset_ast.lo ../cil/src/cil_resolve_ast.lo ../cil/src/cil_stack.lo ../cil/src/cil_strpool.lo ../cil/src/cil_symtab.lo ../cil/src/cil_tree.lo ../cil/src/cil_verify.lo -Wl,-soname,libsepol.so.1,--version-script=libsepol.map,-z,defs
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: ../cil/src/cil.lo: multiple definition of 'cil_build_policydb'
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: ../cil/src/cil.lo: previous definition here
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: ../cil/src/cil.lo: multiple definition of 'cil_compile'
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: ../cil/src/cil.lo: previous definition here
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: ../cil/src/cil.lo: multiple definition of 'cil_userprefixes_to_string'
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: ../cil/src/cil.lo: previous definition here
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: ../cil/src/cil.lo: multiple definition of 'cil_selinuxusers_to_string'
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: ../cil/src/cil.lo: previous definition here
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: error: ../cil/src/cil.lo: multiple definition of 'cil_filecons_to_string'
/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/../../../../x86_64-pc-linux-gnu/bin/ld: ../cil/src/cil.lo: previous definition here
collect2: error: ld returned 1 exit status
Makefile:49: recipe for target 'libsepol.so.1' failed
make[2]: *** [libsepol.so.1] Error 1


I dont really know that much about symbol versioning tho. I am much less
busy now than I was the last couple weeks so I have time to test stuff
if you have other ideas? I get the same error using clang, that might
help you repro? But I think that just uses the same linker so probably
no diff. I will also try and update to a newer linker and see if 2.26
makes the issue go away cuz im on 2.25.

-- Jason
