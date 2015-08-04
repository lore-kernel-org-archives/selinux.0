Subject: Re: [PATCH] semanage_migrate_store: add -r <root> option for
 migrating inside chroots
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1438266154-23219-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55C0D6F2.1090308@tycho.nsa.gov>
Date: Tue, 4 Aug 2015 11:14:58 -0400
MIME-Version: 1.0
In-Reply-To: <1438266154-23219-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/30/2015 10:22 AM, Petr Lautrbach wrote:
> -r, --root
>   Set an alternative root for the migration (default: /)
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
> 
> In Fedora, we used this option in early phase of adopting 2.4 userspace to
> migrate SELinux modules in buildroots during build time. We don't use it anymore,
> but it might be useful for some other deployments.
> 
>  libsemanage/utils/semanage_migrate_store | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 6443002..539f469 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -180,7 +180,7 @@ def rebuild_policy():
>  
>  
>  def oldroot_path():
> -	return "/etc/selinux"
> +	return "%s/etc/selinux" % ROOT
>  
>  def oldstore_path(store):
>  	return "%s/%s/modules/active" % (oldroot_path(), store)
> @@ -192,7 +192,7 @@ def disabledmodules_path(store):
>  	return "%s/disabled" % newmodules_path(store)
>  
>  def newroot_path():
> -	return PATH
> +	return "%s%s" % (ROOT, PATH)
>  
>  def newstore_path(store):
>  	return "%s/%s/active" % (newroot_path(), store)
> @@ -219,6 +219,8 @@ if __name__ == "__main__":
>  			  help="Disable rebuilding policy after migration (default: no)")
>  	parser.add_option("-P", "--path", dest="path",
>  			  help="Set path for the policy store (default: /var/lib/selinux)")
> +	parser.add_option("-r", "--root", dest="root",
> +			  help="Set an alternative root for the migration (default: /)")
>  
>  	(options, args) = parser.parse_args()
>  
> @@ -231,6 +233,10 @@ if __name__ == "__main__":
>  	if PATH is None:
>  		PATH = "/var/lib/selinux"
>  
> +	ROOT = options.root
> +	if ROOT is None:
> +		ROOT = ""
> +
>  	# List of paths that go in the active 'root'
>  	TOPPATHS = [
>  		"commit_num",
> 
