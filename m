Subject: Re: avtab reduction, binary policy format version change
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1123780887.7810.78.camel@moss-spartans.epoch.ncsc.mil>
References: <1123780887.7810.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 11:24:48 -0400
Message-Id: <1123860288.23483.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-11 at 13:21 -0400, Stephen Smalley wrote:
> Hi,
> 
> The patches to libsepol and checkpolicy for reducing the size and number
> of avtab nodes have been committed to the sourceforge CVS tree as of
> libsepol 1.7.13 and checkpolicy 1.25.8.  The kernel patch is going to be
> submitted soon for -mm, but will not go into mainline until 2.6.14.  The
> binary policy format version has been incremented to version 20.  To
> build a policy for older kernels, you will need to use the -c 19 option
> to checkpolicy.  The patches for the kernel, libsepol, and checkpolicy
> are also available from http://www.flux.utah.edu/~sds/, as are complete
> patched tarballs of libsepol and checkpolicy.
> 
> The policy Makefile will likely need to be adjusted again to generate
> both version 19 and version 20 policies during the transition, and to
> load the appropriate one based on the kernel policy version.

This patch for libsepol ensures that type_val_to_struct[i] is NULL for
attributes in the expanded policydb to avoid use of uninitialized data
in expand_avtab_node and expand_cond_av_node (when testing whether or
not the source and target types are attributes and thus need to be
expanded).  Detected by valgrind.  Could potentially cause checkpolicy
to fail to expand attributes when checking hierarchy constraints and
assertions, or when writing out older binary policy versions.  Committed
to libsepol 1.7.14, also requires a rebuild of checkpolicy since it is
statically linked to libsepol.

Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.20
diff -u -p -r1.20 policydb.c
--- libsepol/src/policydb.c	11 Aug 2005 15:43:15 -0000	1.20
+++ libsepol/src/policydb.c	12 Aug 2005 14:53:07 -0000
@@ -692,6 +692,8 @@ int policydb_index_others(policydb_t * p
             malloc(p->p_types.nprim * sizeof(type_datum_t *));
         if (!p->type_val_to_struct)
                 return -1;
+	memset(p->type_val_to_struct, 0, 
+	       p->p_types.nprim*sizeof(type_datum_t *));
 
 	cond_init_bool_indexes(p);
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
