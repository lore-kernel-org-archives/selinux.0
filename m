Message-ID: <1506534179.27095.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 27 Sep 2017 13:42:59 -0400
In-Reply-To: <20170927081645.32481-3-vmojzis@redhat.com>
References: <20170927081645.32481-1-vmojzis@redhat.com>
 <20170927081645.32481-3-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] python/semanage: Enable listing fcontexts.homedirs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-09-27 at 10:16 +0200, Vit Mojzis wrote:
> Include entries from fcontexts.homedirs when listing file contexts
> via "semanage fcontext -l"
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
> ---
>  python/semanage/seobject.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/python/semanage/seobject.py
> b/python/semanage/seobject.py
> index 70fd192..cf64e25 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2566,10 +2566,15 @@ class fcontextRecords(semanageRecords):
>              if rc < 0:
>                  raise ValueError(_("Could not list file contexts"))
>  
> +            (rc, fchomedirs) =
> semanage_fcontext_list_homedirs(self.sh)
> +            if rc < 0:
> +                raise ValueError(_("Could not list local file
> contexts"))
> +

The error message needs to match the actual failure (local vs
homedirs).

>              (rc, fclocal) = semanage_fcontext_list_local(self.sh)
>              if rc < 0:
>                  raise ValueError(_("Could not list local file
> contexts"))
>  
> +            self.flist += fchomedirs
>              self.flist += fclocal
>  
>          ddict = {}
