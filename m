Subject: Re: [PATCH] semanage: swap tcp and udp protocol numbers
To: Miroslav Vadkerti <mvadkert@redhat.com>, selinux@tycho.nsa.gov
References: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <ab8df871-f779-4905-f3d8-d5e2bf821a78@tycho.nsa.gov>
Date: Wed, 10 Aug 2016 10:30:26 -0400
MIME-Version: 1.0
In-Reply-To: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/10/2016 04:39 AM, Miroslav Vadkerti wrote:
> The tcp/udp protocol numbers were accidentaly swapped in
> the original patch 'semanage: add auditing of changes in records'.
>
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>

Applied.

Thanks,
Jim

> ---
>  policycoreutils/semanage/seobject.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index 317b421..786ed0e 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -88,8 +88,8 @@ file_type_str_to_option = {"all files": "a",
>                             "symbolic link": "l",
>                             "named pipe": "p"}
>
> -proto_to_audit = {"tcp": 17,
> -                  "udp": 6,
> +proto_to_audit = {"tcp": 6,
> +                  "udp": 17,
>                    "ipv4": 4,
>                    "ipv6": 41}
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
