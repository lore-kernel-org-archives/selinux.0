To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <20180504115146.19532-1-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <88080217-023d-370d-2ea1-77b081854b93@tycho.nsa.gov>
Date: Tue, 8 May 2018 08:15:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180504115146.19532-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] python/semanage/seobject.py: Fix undefined store check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2018 07:51 AM, Petr Lautrbach wrote:
> From: Vit Mojzis <vmojzis@redhat.com>
> 
> self.store is always a string (actual store name or "") because of
> semanageRecords.__init__. Fix check for not defined store.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1559174#c3
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index ac310ea6..c76dce85 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2651,7 +2651,7 @@ class booleanRecords(semanageRecords):
>              self.current_booleans = []
>              ptype = None
>  
> -        if self.store is None or self.store == ptype:
> +        if self.store == "" or self.store == ptype:
>              self.modify_local = True
>          else:
>              self.modify_local = False
> 

Applied.
