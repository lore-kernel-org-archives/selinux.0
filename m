To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180411092628.7178-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7c0df9c3-db88-47fd-aff4-f7ff900194b0@tycho.nsa.gov>
Date: Wed, 11 Apr 2018 13:37:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180411092628.7178-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] python/sepolgen: Try to translate SELinux contexts to raw
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/11/2018 05:26 AM, Vit Mojzis wrote:
> This allows sepolgen to generate policy from AVC messages that contain
> contexts translated by mcstrans.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1356149

Not friendly to cite a non-public bugzilla.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolgen/src/sepolgen/refpolicy.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
> index 2ee029c1..352b1878 100644
> --- a/python/sepolgen/src/sepolgen/refpolicy.py
> +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> @@ -284,6 +284,11 @@ class SecurityContext(Leaf):
>  
>          Raises ValueError if the string is not parsable as a security context.
>          """
> +        # try to translate the context string to raw form
> +        raw = selinux.selinux_trans_to_raw_context(context)
> +        if raw[0] == 0:
> +            context = raw[1]
> +
>          fields = context.split(":")
>          if len(fields) < 3:
>              raise ValueError("context string [%s] not in a valid format" % context)
> 
