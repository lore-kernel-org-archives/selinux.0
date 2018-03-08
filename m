To: Jan Zarsky <jzarsky@redhat.com>, selinux@tycho.nsa.gov
References: <20180307091620.15232-1-jzarsky@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <96e3cf05-832e-cefe-02fb-0edc6da1bf5f@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 14:57:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180307091620.15232-1-jzarsky@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] python/sepolgen: fix typo in PolicyGenerator
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/07/2018 04:16 AM, Jan Zarsky wrote:
> ---
>  python/sepolgen/src/sepolgen/policygen.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
> index 34c84010..ee664fb7 100644
> --- a/python/sepolgen/src/sepolgen/policygen.py
> +++ b/python/sepolgen/src/sepolgen/policygen.py
> @@ -77,7 +77,7 @@ class PolicyGenerator:
>          self.explain = NO_EXPLANATION
>          self.gen_requires = False
>          if module:
> -            self.moduel = module
> +            self.module = module
>          else:
>              self.module = refpolicy.Module()

Applied.  Remember Signed-off-by in the future, please.
