Message-ID: <1516113924.10453.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 16 Jan 2018 09:45:24 -0500
In-Reply-To: <20180111174427.24529-1-vmojzis@redhat.com>
References: <20180111174427.24529-1-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] python/semanage: Remove redundant and broken
 moduleRecords.modify()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-01-11 at 18:44 +0100, Vit Mojzis wrote:
> moduleRecords.modify() calls nonexistent function
> semanage_module_update_file (maybe it should have been
> semanage_module_upgrade_file which is now obsolete and calls
> semanage_module_install_file) and the job of updating a module is
> done
> by moduleRecords.add().
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.

> ---
>  python/semanage/seobject.py | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/python/semanage/seobject.py
> b/python/semanage/seobject.py
> index b927b18..740bd7c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -423,11 +423,6 @@ class moduleRecords(semanageRecords):
>                      raise ValueError(_("Could not disable module
> %s") % m)
>          self.commit()
>  
> -    def modify(self, file):
> -        rc = semanage_module_update_file(self.sh, file)
> -        if rc >= 0:
> -            self.commit()
> -
>      def delete(self, module, priority):
>          rc = semanage_set_default_priority(self.sh, priority)
>          if rc < 0:
