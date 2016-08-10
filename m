Subject: Re: [PATCH] libselinux/ChangeLog: Fix the author of the last
 libselinux change
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1470835732-9875-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <8b92b3a7-daab-341f-4259-e2d8708f42a7@tycho.nsa.gov>
Date: Wed, 10 Aug 2016 10:30:42 -0400
MIME-Version: 1.0
In-Reply-To: <1470835732-9875-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/10/2016 09:28 AM, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>  libselinux/ChangeLog | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/ChangeLog b/libselinux/ChangeLog
> index 675403f..c3e84bb 100644
> --- a/libselinux/ChangeLog
> +++ b/libselinux/ChangeLog
> @@ -1,4 +1,4 @@
> -	* Fix in tree compilation of utils that depend on libsepol, from Petr Lautrbach.
> +	* Fix in tree compilation of utils that depend on libsepol, from Laurent Bigonville.
>  	* Change the location of _selinux.so, from Petr Lautrbach.
>  	* Clarify is_selinux_mls_enabled() description, from David King.
>  	* Explain how to free policy type from selinux_getpolicytype(), from David King.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
