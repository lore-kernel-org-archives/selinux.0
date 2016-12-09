Subject: Re: [PATCH 2/2] python/sepolicy/sepolicy: optimise sepolicy gui
 loading
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1481296200-28904-1-git-send-email-vmojzis@redhat.com>
 <1481296200-28904-2-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a4e6cd0b-7256-9ee9-9163-5226477e13fb@tycho.nsa.gov>
Date: Fri, 9 Dec 2016 12:21:02 -0500
MIME-Version: 1.0
In-Reply-To: <1481296200-28904-2-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/09/2016 10:10 AM, Vit Mojzis wrote:
> Significantly speed up sepolicy gui loading by aggregating setools
> queries.

Thanks, applied both.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolicy/sepolicy/__init__.py | 17 +++++++++++++++++
>  python/sepolicy/sepolicy/gui.py      |  5 +++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index fee6438..22c72b2 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -663,6 +663,23 @@ def get_init_entrypoint(transtype):
>  
>      return entrypoints
>  
> +def get_init_entrypoints_str():
> +    q = setools.TERuleQuery(_pol,
> +                            ruletype=["type_transition"],
> +                            source="init_t",
> +                            tclass=["process"])
> +    entrypoints = {}
> +    for i in q.results():
> +        try:
> +            transtype = str(i.default)
> +            if transtype in entrypoints:
> +                entrypoints[transtype].append(str(i.target))
> +            else:
> +                entrypoints[transtype] = [str(i.target)]
> +        except AttributeError:
> +            continue
> +
> +    return entrypoints
>  
>  def get_init_entrypoint_target(entrypoint):
>      try:
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 115e18b..c9dd4c1 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -499,6 +499,8 @@ class SELinuxGui():
>  
>          loading_gui.show()
>          length = len(self.all_domains)
> +
> +        entrypoint_dict = sepolicy.get_init_entrypoints_str()
>          for domain in self.all_domains:
>              # After the user selects a path in the drop down menu call
>              # get_init_entrypoint_target(entrypoint) to get the transtype
> @@ -509,8 +511,7 @@ class SELinuxGui():
>              self.progress_bar.set_pulse_step(self.percentage)
>              self.idle_func()
>  
> -            entrypoints = [str(x) for x in sepolicy.get_init_entrypoint(domain)]
> -            for entrypoint in entrypoints:
> +            for entrypoint in entrypoint_dict.get(domain, []):
>                  path = sepolicy.find_entrypoint_path(entrypoint)
>                  if path:
>                      self.combo_box_add(path, domain)
> 
