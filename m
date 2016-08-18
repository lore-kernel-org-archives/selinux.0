Subject: Re: [PATCH] semanage: fix error message for fcontext -m
To: Miroslav Vadkerti <mvadkert@redhat.com>, selinux@tycho.nsa.gov
References: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f5ba5611-d293-abfa-54b5-5f62d9c7ea2a@tycho.nsa.gov>
Date: Thu, 18 Aug 2016 15:26:40 -0400
MIME-Version: 1.0
In-Reply-To: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/18/2016 07:18 AM, Miroslav Vadkerti wrote:
> The type must be a file of device type, not a port type.
> 
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>

Thanks, applied.

> ---
>  policycoreutils/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index a6681f0..a34d20d 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1937,7 +1937,7 @@ class fcontextRecords(semanageRecords):
>          if serange == "" and setype == "" and seuser == "":
>              raise ValueError(_("Requires setype, serange or seuser"))
>          if setype and setype not in self.valid_types:
> -            raise ValueError(_("Type %s is invalid, must be a port type") % setype)
> +            raise ValueError(_("Type %s is invalid, must be a file or device type") % setype)
>  
>          self.validate(target)
>  
> 
