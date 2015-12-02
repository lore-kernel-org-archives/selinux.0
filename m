Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2M0a1w008209
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 17:01:44 -0500
Received: by oies6 with SMTP id s6so35040309oie.1
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 13:59:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6a9c04a259806de434a2ae5ea3142a6bb8868906.1448973992.git.jstancek@redhat.com>
References: <6a9c04a259806de434a2ae5ea3142a6bb8868906.1448973992.git.jstancek@redhat.com>
Date: Wed, 2 Dec 2015 16:59:57 -0500
Message-ID: <CAHC9VhQWSoai3tDXbZoSBW1p4bFKVy0hg1+pNhMFtaQ+VNomkg@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] net_socket: replace md5 with sha1 in
 ipsec-load
From: Paul Moore <paul@paul-moore.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 1, 2015 at 7:52 AM, Jan Stancek <jstancek@redhat.com> wrote:
> ipsec-load is currently passing 'auth md5 0123456789012345' to ip xfrm,
> which fails in FIPS mode:
>   RTNETLINK answers: Function not implemented
>
> According to [1], md5 is not on list of compliant hashes for FIPS 140-2.
> [1] http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexa.pdf
>
> This patch is replacing 'md5' with 'sha1'.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/inet_socket/ipsec-load | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks fine to me and passes on my test system.  Merged, thanks.

> diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
> index b9d2c6e43544..c72d4b9d2f95 100755
> --- a/tests/inet_socket/ipsec-load
> +++ b/tests/inet_socket/ipsec-load
> @@ -5,7 +5,7 @@ ip xfrm policy flush
>  ip xfrm state flush
>  goodclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_client_t:`secon -m --pid $$`
>  badclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_bad_client_t:`secon -m --pid $$`
> -ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth md5 0123456789012345
> -ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth md5 0123456789012345
> +ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
> +ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
>  ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
>  ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
