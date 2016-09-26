Subject: Re: [PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac
 build
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 brindle@quarksecurity.com
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
 <1474664152-18727-4-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4c38efe6-ed00-0904-9439-38888ac2146b@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 10:37:53 -0400
MIME-Version: 1.0
In-Reply-To: <1474664152-18727-4-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 04:55 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Fix this:
> genusers.c:63:14: warning: variable 'nread' is uninitialized when used here [-Wuninitialized]
>                 if (buffer[nread - 1] == '\n')
>                            ^~~~~
> genusers.c:40:15: note: initialize the variable 'nread' to silence this warning
>         ssize_t nread;
>                      ^
>                       = 0
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied all 3 patches.
NB none of this code is actually used on the Mac or elsewhere in Android
for that matter, and even on Linux, it is just legacy code (not used in
modern distributions).

> ---
>  libsepol/src/genusers.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
> index 57a9a2e..5568210 100644
> --- a/libsepol/src/genusers.c
> +++ b/libsepol/src/genusers.c
> @@ -53,6 +53,7 @@ static int load_users(struct policydb *policydb, const char *path)
>  	}
>  
>  	while(fgets(buffer, 255, fp) != NULL) {
> +		nread = strlen(buffer);
>  #else
>  	size_t len = 0;
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
> 
