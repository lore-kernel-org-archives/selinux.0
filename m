Message-ID: <1507148678.1491.9.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 04 Oct 2017 16:24:38 -0400
In-Reply-To: <20171004153604.5817-3-vmojzis@redhat.com>
References: <1dcea489-7584-e7a3-aa50-99a974440734@redhat.com>
 <20171004153604.5817-1-vmojzis@redhat.com>
 <20171004153604.5817-3-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] python/semanage: Enable listing file_contexts.homedirs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-10-04 at 17:36 +0200, Vit Mojzis wrote:
> Include entries from file_contexts.homedirs when listing file
> contexts
> via "semanage fcontext -l"
> 
> "semanage fcontext -l" so far ignored content of
> file_contexts.homedirs
> file, which is confusing for users (more specific rules may be
> ignored in
> favor of rules unseen to the user since file_contexts.homedirs has
> higher priority than file_contexts).
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

For all three patches:
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

Queued for merging in a couple of days.

> ---
>  python/semanage/seobject.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/python/semanage/seobject.py
> b/python/semanage/seobject.py
> index 70fd192..1385315 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2566,10 +2566,15 @@ class fcontextRecords(semanageRecords):
>              if rc < 0:
>                  raise ValueError(_("Could not list file contexts"))
>  
> +            (rc, fchomedirs) =
> semanage_fcontext_list_homedirs(self.sh)
> +            if rc < 0:
> +                raise ValueError(_("Could not list file contexts for
> home directories"))
> +
>              (rc, fclocal) = semanage_fcontext_list_local(self.sh)
>              if rc < 0:
>                  raise ValueError(_("Could not list local file
> contexts"))
>  
> +            self.flist += fchomedirs
>              self.flist += fclocal
>  
>          ddict = {}
