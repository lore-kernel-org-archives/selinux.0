Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3GMIavL003506
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 18:18:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id i18-v6so9376604lfc.7
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 15:18:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180414153241.GA17844@jordon-HP-15-Notebook-PC>
References: <20180414153241.GA17844@jordon-HP-15-Notebook-PC>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Apr 2018 18:18:27 -0400
Message-ID: <CAHC9VhTEpHj=P-h3jC4J5MJHCySUe_H8HJwbnsqJfB38cKJkaw@mail.gmail.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 willy@infradead.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] security: selinux: Change return type to
 vm_fault_t
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Apr 14, 2018 at 11:32 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler
> in struct vm_operations_struct.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 00eed84..dfc31c6 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -418,7 +418,7 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
>         return ret;
>  }
>
> -static int sel_mmap_policy_fault(struct vm_fault *vmf)
> +static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
>  {
>         struct policy_load_memory *plm = vmf->vma->vm_file->private_data;
>         unsigned long offset;
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
