Message-ID: <1493992395.5745.3.camel@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: add a map permission check for mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, brindle@quarksecurity.com,
 pebenito@ieee.org, jwcart2@tycho.nsa.gov
Date: Fri, 05 May 2017 09:53:15 -0400
In-Reply-To: <20170505131448.8718-1-sds@tycho.nsa.gov>
References: <20170505131448.8718-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 09:14 -0400, Stephen Smalley wrote:
> Add a map permission check on mmap so that we can distinguish memory
> mapped
> access (since it has different implications for revocation). When a
> file
> is opened and then read or written via syscalls like
> read(2)/write(2),
> we revalidate access on each read/write operation via
> selinux_file_permission() and therefore can revoke access if the
> process context, the file context, or the policy changes in such a
> manner that access is no longer allowed. When a file is opened and
> then
> memory mapped via mmap(2) and then subsequently read or written
> directly
> in memory, we presently have no way to revalidate or revoke access.
> The purpose of a separate map permission check on mmap(2) is to
> permit
> policy to prohibit memory mapping of specific files for which we need
> to ensure that every access is revalidated, particularly useful for
> scenarios where we expect the file to be relabeled at runtime in
> order
> to reflect state changes (e.g. cross-domain solution, assured
> pipeline
> without data copying).
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> NB I chose not to define a new policy capability for this permission,
> since it is adequately covered by handle_unknown for compatibility
> and
> others seemed to agree that this does not fall into the category of
> changes requiring a new policy capability.  I also chose to define
> the
> permission for socket classes in addition to file classes and let it
> be checked for both.
> 
>  security/selinux/hooks.c            | 12 ++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..5432628 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3550,6 +3550,18 @@ static int selinux_mmap_addr(unsigned long
> addr)
>  static int selinux_mmap_file(struct file *file, unsigned long
> reqprot,
>  			     unsigned long prot, unsigned long
> flags)
>  {
> +	struct common_audit_data ad;
> +	int rc;
> +
> +	if (file) {
> +		ad.type = LSM_AUDIT_DATA_FILE;
> +		ad.u.file = file;
> +		rc = inode_has_perm(current_cred(),
> file_inode(file),
> +				    FILE__MAP, &ad);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (selinux_checkreqprot)
>  		prot = reqprot;
>  
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index 1e0cc9b..3e49a78 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -1,7 +1,7 @@
>  #include <linux/capability.h>
>  
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
> -    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> "append"
> +    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> "append", "map"
>  
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link",
> \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \

Below is the refpolicy patch (relative to the Fedora rawhide policy
source RPM) I used for testing.  I simply added the map permission
declaration to the common file and common socket definitions since I
wasn't concerned with compatibility for kernels that predate the
dynamic class/perm mapping support (< 2.6.33, RHEL < 6).  Not sure
whether that's acceptable for upstream refpolicy or not; if not, it
will need to be added at the end of the existing lists for all file and
socket classes.  With regard to allow rules, I initially tried just
adding map permission to mmap_file_perms and exec_file_perms, which
covered most shared libraries and executables, but quickly ran into a
number of cases where programs and libraries required it just for
mmap'ing data files.  I addressed several of those but more kept
popping up.  Abstractly, any domain that previously was allowed read
permission could have used mmap, so if the goal is to ensure 100%
backward compatibility in refpolicy, we would need to add it to every
rule that allows read permission.  In my limited testing, it seemed to
suffice to add it to the _file_perms and _chr_file_perms macros that
already allowed open (although technically a process that
inherits/receives a descriptor could mmap it as well).  I think it is
ok to allow map permission widely in refpolicy (as with open
permission), and leave restricting it to specialized domains (as with
sandbox domains for open) given its narrow use case.

diff -ru serefpolicy-3.13.1.orig/policy/flask/access_vectors serefpolicy-3.13.1/policy/flask/access_vectors
--- serefpolicy-3.13.1.orig/policy/flask/access_vectors	2017-05-03 16:25:32.750029182 -0400
+++ serefpolicy-3.13.1/policy/flask/access_vectors	2017-05-04 09:18:58.999737761 -0400
@@ -20,6 +20,7 @@
 	relabelfrom
 	relabelto
 	append
+	map
 	unlink
 	link
 	rename
@@ -47,6 +48,7 @@
 	relabelfrom
 	relabelto
 	append
+	map
 # socket-specific
 	bind
 	connect
diff -ru serefpolicy-3.13.1.orig/policy/support/obj_perm_sets.spt serefpolicy-3.13.1/policy/support/obj_perm_sets.spt
--- serefpolicy-3.13.1.orig/policy/support/obj_perm_sets.spt	2017-05-03 16:25:32.751029170 -0400
+++ serefpolicy-3.13.1/policy/support/obj_perm_sets.spt	2017-05-04 09:34:15.418877678 -0400
@@ -153,19 +153,19 @@
 define(`getattr_file_perms',`{ getattr }')
 define(`setattr_file_perms',`{ setattr }')
 define(`read_inherited_file_perms',`{ getattr read ioctl lock }')
-define(`read_file_perms',`{ open read_inherited_file_perms }')
-define(`mmap_file_perms',`{ getattr open read execute ioctl }')
-define(`exec_file_perms',`{ getattr open read execute ioctl execute_no_trans }')
+define(`read_file_perms',`{ open map read_inherited_file_perms }')
+define(`mmap_file_perms',`{ getattr open map read execute ioctl }')
+define(`exec_file_perms',`{ getattr open map read execute ioctl execute_no_trans }')
 define(`append_inherited_file_perms',`{ getattr append }')
 define(`append_file_perms',`{ open lock ioctl append_inherited_file_perms }')
 define(`write_inherited_file_perms',`{ getattr write append lock ioctl }')
-define(`write_file_perms',`{ open write_inherited_file_perms }')
+define(`write_file_perms',`{ open map write_inherited_file_perms }')
 define(`rw_inherited_file_perms',`{ getattr read write append ioctl lock }')
-define(`rw_file_perms',`{ open rw_inherited_file_perms }')
-define(`create_file_perms',`{ getattr create open }')
+define(`rw_file_perms',`{ open map rw_inherited_file_perms }')
+define(`create_file_perms',`{ getattr create open map }')
 define(`rename_file_perms',`{ getattr rename }')
 define(`delete_file_perms',`{ getattr unlink }')
-define(`manage_file_perms',`{ create open getattr setattr read write append rename link unlink ioctl lock }')
+define(`manage_file_perms',`{ create open map getattr setattr read write append rename link unlink ioctl lock }')
 define(`relabelfrom_file_perms',`{ getattr relabelfrom }')
 define(`relabelto_file_perms',`{ getattr relabelto }')
 define(`relabel_file_perms',`{ getattr relabelfrom relabelto }')
@@ -245,15 +245,15 @@
 #
 define(`getattr_chr_file_perms',`{ getattr }')
 define(`setattr_chr_file_perms',`{ setattr }')
-define(`read_chr_file_perms',`{ getattr open read lock ioctl }')
+define(`read_chr_file_perms',`{ getattr open map read lock ioctl }')
 define(`append_chr_file_perms',`{ getattr open append lock ioctl }')
-define(`write_chr_file_perms',`{ getattr open write append lock ioctl }')
+define(`write_chr_file_perms',`{ getattr open map write append lock ioctl }')
 define(`rw_inherited_chr_file_perms',`{ getattr read write append ioctl lock }')
-define(`rw_chr_file_perms',`{ open rw_inherited_chr_file_perms }')
+define(`rw_chr_file_perms',`{ open map rw_inherited_chr_file_perms }')
 define(`create_chr_file_perms',`{ getattr create }')
 define(`rename_chr_file_perms',`{ getattr rename }')
 define(`delete_chr_file_perms',`{ getattr unlink }')
-define(`manage_chr_file_perms',`{ create open getattr setattr read write append rename link unlink ioctl lock }')
+define(`manage_chr_file_perms',`{ create open map getattr setattr read write append rename link unlink ioctl lock }')
 define(`relabelfrom_chr_file_perms',`{ getattr relabelfrom }')
 define(`relabelto_chr_file_perms',`{ getattr relabelto }')
 define(`relabel_chr_file_perms',`{ getattr relabelfrom relabelto }')
