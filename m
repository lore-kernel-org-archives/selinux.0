Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3MFXJUL018187
 for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2015 11:33:19 -0400
Message-ID: <5537BF23.3000305@tresys.com>
Date: Wed, 22 Apr 2015 11:32:51 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Jason Zaman <jason@perfinion.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: do not copy contexts in
 semanage_migrate_store
References: <1429715502-25745-1-git-send-email-jason@perfinion.com>
In-Reply-To: <1429715502-25745-1-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Just two minor comments inline.

On 04/22/2015 11:11 AM, Jason Zaman wrote:
> The modules from the old store were previously copied to the new one
> using setfscreatecon and shutil.copy2(). Now that refpolicy has rules
> about the new policy location[1], copying the contexts is redundant.
> 
> More importantly, the setcreatefscon caused a constraint violation[2]
> which made the migration fail. In python3, shutil.copy2() copies xattrs
> as well which again causes problems. shutil.copy() is enough for our
> needs here as it will copy the file and permissions in both py2 and 3.
> We do not need the extra things that copy2() does (mtime, xattr, etc).
> 
> [1] http://oss.tresys.com/pipermail/refpolicy/2014-December/007511.html
> 
> [2]
> type=AVC msg=audit(1429438272.872:1869): avc:  denied  { create } for  pid=28739 comm="semanage_migrat" name="strict" scontext=staff_u:sysadm_r:semanage_t tcontext=system_u:object_r:semanage_store_t tclass=dir permissive=0
> 	constrain dir { create relabelfrom relabelto } ((u1 == u2 -Fail-)  or (t1 == can_change_object_identity -Fail-) ); Constraint DENIED
> allow semanage_t semanage_store_t:dir create;
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>  libsemanage/utils/semanage_migrate_store | 68 +++++++-------------------------
>  1 file changed, 14 insertions(+), 54 deletions(-)
> 
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 03b492e..3f7af1b 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -8,7 +8,6 @@ import shutil
>  import sys
>  from optparse import OptionParser
>  
> -import bz2
>  import ctypes
>  
>  sepol = ctypes.cdll.LoadLibrary('libsepol.so')
> @@ -21,41 +20,21 @@ except:
>  	exit(1)
>  
>  
> -
> -
>  # For some reason this function doesn't exist in libselinux :\

Remove this comment too? This function no longer uses selinux.

> -def copy_with_context(src, dst):
> +def copy_file(src, dst):
>  	if DEBUG:
>  		print("copying %s to %s" % (src, dst))
>  	try:
> -		con = selinux.lgetfilecon_raw(src)[1]
> -	except:
> -		print("Could not get file context of %s" % src, file=sys.stderr)
> -		exit(1)
> -
> -	try:
> -		selinux.setfscreatecon_raw(con)
> -	except:
> -		print("Could not set fs create context: %s" %con, file=sys.stderr)
> -		exit(1)
> -
> -	try:
> -		shutil.copy2(src, dst)
> +		shutil.copy(src, dst)
>  	except OSError as the_err:
>  		(err, strerr) = the_err.args
>  		print("Could not copy %s to %s, %s" %(src, dst, strerr), file=sys.stderr)
>  		exit(1)
>  
> -	try:
> -		selinux.setfscreatecon_raw(None)
> -	except:
> -		print("Could not reset fs create context. May need to relabel system.", file=sys.stderr)
>  
> -def create_dir_from(src, dst, mode):
> +def create_dir(dst, mode):
>  	if DEBUG: print("Making directory %s" % dst)
>  	try:
> -		con = selinux.lgetfilecon_raw(src)[1]
> -		selinux.setfscreatecon_raw(con)
>  		os.makedirs(dst, mode)
>  	except OSError as the_err:
>  		(err, stderr) = the_err.args
> @@ -65,28 +44,18 @@ def create_dir_from(src, dst, mode):
>  			print("Error creating %s" % dst, file=sys.stderr)
>  			exit(1)
>  
> -	try:
> -		selinux.setfscreatecon_raw(None)
> -	except:
> -		print("Could not reset fs create context. May need to relabel system.", file=sys.stderr)
>  
>  def create_file_from(src, dst):

For consistency, perhaps change create_file_from to create_file and not
take in a src, similar to how you changed create_dir_from to create_dir?
There isn't really a need for src in create_file_from anymore.

>  	if DEBUG: print("Making file %s" % dst)
>  	try:
> -		con = selinux.lgetfilecon_raw(src)[1]
> -		selinux.setfscreatecon_raw(con)
>  		open(dst, 'a').close()
>  	except OSError as the_err:
>  		(err, stderr) = the_err.args
>  		print("Error creating %s" % dst, file=sys.stderr)
>  		exit(1)
>  
> -	try:
> -		selinux.setfscreatecon_raw(None)
> -	except:
> -		print("Could not reset fs create context. May need to relabel system.", file=sys.stderr)
>  
> -def copy_module(store, name, con, base):
> +def copy_module(store, name, base):
>  	if DEBUG: print("Install module %s" % name)
>  	(file, ext) = os.path.splitext(name)
>  	if ext != ".pp":
> @@ -94,8 +63,6 @@ def copy_module(store, name, con, base):
>  		print("warning: %s has invalid extension, skipping" % name, file=sys.stderr)
>  		return
>  	try:
> -		selinux.setfscreatecon_raw(con)
> -
>  		if base:
>  			root = oldstore_path(store)
>  		else:
> @@ -105,7 +72,7 @@ def copy_module(store, name, con, base):
>  
>  		os.mkdir("%s/%s" % (bottomdir, file))
>  
> -		copy_with_context(os.path.join(root, name), "%s/%s/hll" % (bottomdir, file))
> +		copy_file(os.path.join(root, name), "%s/%s/hll" % (bottomdir, file))
>  
>  		# This is the ext file that will eventually be used to choose a compiler
>  		efile = open("%s/%s/lang_ext" % (bottomdir, file), "w+", 0o600)
> @@ -116,10 +83,6 @@ def copy_module(store, name, con, base):
>  		print("Error installing module %s" % name, file=sys.stderr)
>  		exit(1)
>  
> -	try:
> -		selinux.setfscreatecon_raw(None)
> -	except:
> -		print("Could not reset fs create context. May need to relabel system.", file=sys.stderr)
>  
>  def disable_module(file, root, name, disabledmodules):
>  	if DEBUG: print("Disabling %s" % name)
> @@ -138,17 +101,14 @@ def migrate_store(store):
>  	print("Migrating from %s to %s" % (oldstore, newstore))
>  
>  	# Build up new directory structure
> -	create_dir_from(oldstore, "%s/%s" % (newroot_path(), store), 0o755)
> -	create_dir_from(oldstore, newstore, 0o700)
> -	create_dir_from(oldstore, newmodules, 0o700)
> -	create_dir_from(oldstore, bottomdir, 0o700)
> -	create_dir_from(oldstore, disabledmodules, 0o700)
> -
> -	# use whatever the file context of bottomdir is for the module directories
> -	con = selinux.lgetfilecon_raw(bottomdir)[1]
> +	create_dir("%s/%s" % (newroot_path(), store), 0o755)
> +	create_dir(newstore, 0o700)
> +	create_dir(newmodules, 0o700)
> +	create_dir(bottomdir, 0o700)
> +	create_dir(disabledmodules, 0o700)
>  
>  	# Special case for base since it was in a different location
> -	copy_module(store, "base.pp", con, 1)
> +	copy_module(store, "base.pp", 1)
>  
>  	# Dir structure built, start copying files
>  	for root, dirs, files in os.walk(oldstore):
> @@ -161,7 +121,7 @@ def migrate_store(store):
>  						newname = "seusers.local"
>  					else:
>  						newname = name
> -					copy_with_context(os.path.join(root, name), os.path.join(newstore, newname))
> +					copy_file(os.path.join(root, name), os.path.join(newstore, newname))
>  
>  		elif root == oldmodules:
>  			# This should be the modules directory
> @@ -173,7 +133,7 @@ def migrate_store(store):
>  				elif ext == ".disabled":
>  					disable_module(file, root, name, disabledmodules)
>  				else:
> -					copy_module(store, name, con, 0)
> +					copy_module(store, name, 0)
>  
>  def rebuild_policy():
>  	# Ok, the modules are loaded, lets try to rebuild the policy
> @@ -287,7 +247,7 @@ if __name__ == "__main__":
>  		"preserve_tunables" ]
>  
>  
> -	create_dir_from(oldroot_path(), newroot_path(), 0o755)
> +	create_dir(newroot_path(), 0o755)
>  
>  	stores = None
>  	if TYPE is not None:
> 
