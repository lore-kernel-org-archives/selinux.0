Subject: Re: [PATCH] policycoreutils: replace string.join() with str.join()
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1448454080-30617-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <565E0515.8060201@tycho.nsa.gov>
Date: Tue, 1 Dec 2015 15:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <1448454080-30617-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/25/2015 07:21 AM, Petr Lautrbach wrote:
> Fixes Python 3 error:
>    AttributeError: module 'string' has no attribute 'join'
>
> Based on a patch by Tomas Radej <tradej@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>   policycoreutils/semanage/seobject.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index d29dba5..c52be75 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -846,7 +846,7 @@ class seluserRecords(semanageRecords):
>       def __modify(self, name, roles=[], selevel="", serange="", prefix=""):
>           oldserole = ""
>           oldserange = ""
> -        newroles = string.join(roles, ' ')
> +        newroles = " ".join(roles)
>           if prefix == "" and len(roles) == 0 and serange == "" and selevel == "":
>               if is_mls_enabled == 1:
>                   raise ValueError(_("Requires prefix, roles, level or range"))
> @@ -870,7 +870,7 @@ class seluserRecords(semanageRecords):
>           oldserange = semanage_user_get_mlsrange(u)
>           (rc, rlist) = semanage_user_get_roles(self.sh, u)
>           if rc >= 0:
> -            oldserole = string.join(rlist, ' ')
> +            oldserole = " ".join(rlist)
>
>           if (is_mls_enabled == 1) and (serange != ""):
>               semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
> @@ -980,7 +980,7 @@ class seluserRecords(semanageRecords):
>               if rc < 0:
>                   raise ValueError(_("Could not list roles for user %s") % name)
>
> -            roles = string.join(rlist, ' ')
> +            roles = " ".join(rlist)
>               ddict[semanage_user_get_name(u)] = (semanage_user_get_prefix(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
>
>           return ddict
>
