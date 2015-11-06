Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6I7wG2027399
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 13:07:58 -0500
Received: by obdgf3 with SMTP id gf3so98323314obd.3
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 10:07:55 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [selinux-testsuite PATCH 2/4] inet_socket: secon: use current pid
Date: Fri, 06 Nov 2015 13:07:53 -0500
Message-ID: <8567804.nFH5H7f4bC@sifl>
In-Reply-To: <29545986657bf9e30f1e66630c20db84d22ed66d.1446805443.git.jstancek@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
 <29545986657bf9e30f1e66630c20db84d22ed66d.1446805443.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 06, 2015 02:07:22 PM Jan Stancek wrote:
> When running selinux-testsuite in automated environment,
> such as Beaker, stdin is usually /dev/null. This causes
> problem for inet_socket test:
>   secon:  Couldn't read security context: Inappropriate ioctl for device
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/inet_socket/ipsec-load | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me, merged.

> diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
> index ded6efb04722..b9d2c6e43544 100755
> --- a/tests/inet_socket/ipsec-load
> +++ b/tests/inet_socket/ipsec-load
> @@ -3,8 +3,8 @@ echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
>  echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
>  ip xfrm policy flush
>  ip xfrm state flush
> -goodclientcon=`secon -u`:`secon -r`:test_inet_client_t:`secon -m`
> -badclientcon=`secon -u`:`secon -r`:test_inet_bad_client_t:`secon -m`
> +goodclientcon=`secon -u --pid $$`:`secon -r --pid
> $$`:test_inet_client_t:`secon -m --pid $$` +badclientcon=`secon -u --pid
> $$`:`secon -r --pid $$`:test_inet_bad_client_t:`secon -m --pid $$` ip xfrm
> state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon
> auth md5 0123456789012345 ip xfrm state add src 127.0.0.1 dst 127.0.0.1
> proto ah spi 0x250 ctx $badclientcon auth md5 0123456789012345 ip xfrm
> policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx
> "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level
> required

-- 
paul moore
www.paul-moore.com
