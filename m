Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7EKNo4e014210
 for <selinux@tycho.nsa.gov>; Sun, 14 Aug 2016 16:23:50 -0400
Subject: Re: [PATCH] semanage: swap tcp and udp protocol numbers
To: Miroslav Vadkerti <mvadkert@redhat.com>, selinux@tycho.nsa.gov
References: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <d3269864-4abf-0f63-957c-dc0ee8f2e742@ieee.org>
Date: Sun, 14 Aug 2016 16:23:51 -0400
MIME-Version: 1.0
In-Reply-To: <1470818350-3637-1-git-send-email-mvadkert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/10/16 04:39, Miroslav Vadkerti wrote:
> The tcp/udp protocol numbers were accidentaly swapped in
> the original patch 'semanage: add auditing of changes in records'.
>
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
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

I realize this has already been merged, but why not use existing 
constants such as socket.IPPROTO_TCP and socket.AF_INET rather than hard 
coding the protocol numbers?

-- 
Chris PeBenito
