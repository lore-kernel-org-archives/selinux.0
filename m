Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1OEp0J7023721
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 09:51:05 -0500
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1OEp4GM013851
	for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 14:51:05 GMT
Received: by gyd10 with SMTP id 10so333813gyd.12
        for <selinux@tycho.nsa.gov>; Thu, 24 Feb 2011 06:51:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110224082252.GP20852@secunet.com>
References: <20110223115343.GH20852@secunet.com>
	<20110223115715.GL20852@secunet.com>
	<201102230956.53069.paul.moore@hp.com>
	<20110224082252.GP20852@secunet.com>
Date: Thu, 24 Feb 2011 09:51:04 -0500
Message-ID: <AANLkTimVMykzZDE07C4zxW=o+1_cWkrzDEHFOi5jAA0S@mail.gmail.com>
Subject: Re: [PATCH 4/4 v2] selinux: xfrm - notify users on dropped packets
From: Eric Paris <eparis@parisplace.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All printk() statement require a KERN_*.  I've often heard upstream
people say that every printk should only be printed if you expect the
user to do something with it.  If it doesn't give the user enough
information to fix whatever the problem is, or know how to fix
whatever the problem is, it's a bad printk.  I don't know this code at
all, but I'm pretty sure if I got those printk's I'd just feel
dumb....

-Eric

On Thu, Feb 24, 2011 at 3:22 AM, Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> In selinux_xfrm_state_pol_flow_match we have cases where we drop
> packets without asking the avc. No audit message is generated in
> this case. Lets at least print out a message to the logs, so the
> users don't need to dig in the code to find out why these packets
> are dropped.
>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  security/selinux/xfrm.c |   26 +++++++++++++++++---------
>  1 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 728c57e..b0dd401 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -118,25 +118,33 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>        int rc;
>
>        if (!xp->security)
> -               if (x->security)
> -                       /* unlabeled policy and labeled SA can't match */
> +               if (x->security) {
> +                       if (net_ratelimit())
> +                               printk("selinux: unlabeled policy and labeled SA can't match\n");
>                        return 0;
> -               else
> +               } else
>                        /* unlabeled policy and unlabeled SA match all flows */
>                        return 1;
>        else
> -               if (!x->security)
> -                       /* unlabeled SA and labeled policy can't match */
> +               if (!x->security) {
> +                       if (net_ratelimit())
> +                               printk("selinux: unlabeled SA and labeled policy can't match\n");
>                        return 0;
> -               else
> -                       if (!selinux_authorizable_xfrm(x))
> -                               /* Not a SELinux-labeled SA */
> +               } else {
> +                       if (!selinux_authorizable_xfrm(x)) {
> +                               if (net_ratelimit())
> +                                       printk("selinux: Not a SELinux-labeled SA\n");
>                                return 0;
> +                       }
> +               }
>
>        state_sid = x->security->ctx_sid;
>
> -       if (fl->secid != state_sid)
> +       if (fl->secid != state_sid) {
> +               if (net_ratelimit())
> +                       printk("selinux: Flow label does not match SA label\n");
>                return 0;
> +       }
>
>        rc = avc_has_perm(fl->secid, state_sid, SECCLASS_ASSOCIATION,
>                          ASSOCIATION__SENDTO,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
