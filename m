Subject: Re: [PATCH] python/sepolicy/sepolicy/gui: Reflect sepolicy changes
 into gui
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <15202ae0-3133-0a2e-950c-1d4bf59c4eb9@redhat.com>
 <1481036313-11915-1-git-send-email-vmojzis@redhat.com>
 <1481036313-11915-2-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1a613398-107e-8916-de1b-c00582bc27d5@tycho.nsa.gov>
Date: Tue, 6 Dec 2016 12:43:07 -0500
MIME-Version: 1.0
In-Reply-To: <1481036313-11915-2-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/06/2016 09:58 AM, Vit Mojzis wrote:
> sepolicy.get_init_entrypoint() now returns list of Type objects
> instead of single string, which caused sepolicy gui to crash.

Thanks, applied.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolicy/sepolicy/gui.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 3c5a9d2..6ccd02a 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -512,8 +512,8 @@ class SELinuxGui():
>              self.progress_bar.set_pulse_step(self.percentage)
>              self.idle_func()
>  
> -            entrypoint = sepolicy.get_init_entrypoint(domain)
> -            if entrypoint:
> +            entrypoints = [str(x) for x in sepolicy.get_init_entrypoint(domain)]
> +            for entrypoint in entrypoints:
>                  path = sepolicy.find_entrypoint_path(entrypoint)
>                  if path:
>                      self.combo_box_initialize(path, None)
> 
