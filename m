Subject: Re: [PATCH 03/10] MLSXFRM: Add security sid to sock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, jmorris@namei.org, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
In-Reply-To: <44B565D9.9090805@trustedcs.com>
References: <44B565D9.9090805@trustedcs.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:39:09 -0400
Message-Id: <1152797949.10075.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-12 at 16:12 -0500, Venkat Yekkirala wrote:
> This adds security for IP sockets at the sock level. Security at the
> sock level is needed to enforce the SELinux security policy for security
> associations even when a sock is orphaned (such as in the TCP LAST_ACK state).
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> ---
> 
>  include/linux/security.h          |   12 ++++++++++++
>  include/net/sock.h                |   13 +++++++++++++
>  net/core/sock.c                   |    2 +-
>  security/dummy.c                  |    5 +++++
>  security/selinux/hooks.c          |   27 +++++++++++++++++++++------
>  security/selinux/include/objsec.h |    1 +
>  6 files changed, 53 insertions(+), 7 deletions(-)
> 

> @@ -3564,6 +3574,10 @@ static unsigned int selinux_sk_getsid_se
>  
>  	if (isec)
>  		sock_sid = isec->sid;
> +	else {
> +		struct sk_security_struct *sksec = sk->sk_security;
> +		sock_sid = sksec->sid;
> +	}
>  
>  	read_unlock_bh(&sk->sk_callback_lock);
>  	return sock_sid;

Is it ever possible for the isec->sid and the sksec->sid to be
inconsistent with one another?  Could you just always return the
sksec->sid here and avoid the need to grab the isec altogether (dropping
the requirement for sk_callback_lock at the same time, since you no
longer need sk_socket)?

Likewise, given sksec->sid, why don't you change sock_rcv_skb to always
use it, and eliminate the need for the isec and the sk_callback_lock
there?   Similarly for postroute_last's use of isec->sid.  With direct
labeling of the sock, it is no longer necessary to extract the isec.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
