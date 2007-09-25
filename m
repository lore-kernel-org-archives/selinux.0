Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PLbt9i004269
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 17:37:55 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PLbsRe008049
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 21:37:54 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1740276rvb
        for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 14:37:54 -0700 (PDT)
Message-ID: <7e0fb38c0709251437k66d2de62t3391eaad71e34b51@mail.gmail.com>
Date: Tue, 25 Sep 2007 17:37:53 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer labeling subsystems
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
	 <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/25/07, Paul Moore <paul.moore@hp.com> wrote:
> Rename the existing selinux_skb_extlbl_sid() function to
> selinux_skb_peerlbl_sid() and modify it's behavior such that it now reconciles
> multiple peer/external labels and if reconciliation is not possible it returns
> an error to the caller.

> -static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
> +static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
>  {
>         u32 xfrm_sid;
>         u32 nlbl_sid;
>
>         selinux_skb_xfrm_sid(skb, &xfrm_sid);
> -       if (selinux_netlbl_skbuff_getsid(skb,
> -                                        (xfrm_sid == SECSID_NULL ?
> -                                         SECINITSID_NETMSG : xfrm_sid),
> -                                        &nlbl_sid) != 0)
> -               nlbl_sid = SECSID_NULL;
> -       *sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> +       selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
> +
> +       if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL) {
> +               if (nlbl_sid != xfrm_sid &&

for now nlbl_sid will NEVER == xfrm_sid since netlbl_sid cannot be of
an interesting type, correct?  So this code works.  If the mls portion
is wrong bomb, if the mls portion is right allow.  Since that's all we
are testing lets get that misleading nlbl_sid != xfrm_sid out of there
they can never be the same and it implies we actually check something
other than the mls portion.

assuming one day it does carry interesting non-mls information do we
care to fix this to work today?

Your code:
xfrm_sid = type1_t:s0
netlbl_sid = type2_t:s0

xfrm_sid != netlbl_sid but mls_cmp will be 0, so our result is going
to be type1_t:s0?   Or do we really want to do this up front and say
(horrible psudo codish thing to follow, don't throw up or gouge your
eyes out)

if (xfrm_sid == netlbl_sid)
   return xfrm_sid
else if (xfrm_sid != netlbl_sid) && (netlbl_sid.type == UNSET) && (mls_cmp == 0)
   return xfrm_sid
else
   blow up because it isn't valid.

> +                   /* XXX - not sure if we should just compare the low end of
> +                    * the range or the whole range?  probably safest to
> +                    * compare the entire range ... */
> +                   security_sid_mls_cmp(nlbl_sid, xfrm_sid) != 0) {
> +                       *sid = SECSID_NULL;
> +                       return -EACCES;
> +               } else
> +                       /* at present NetLabel SIDs/labels really only carry
> +                        * MLS information so if the MLS portion of the
> +                        * NetLabel SID matches the MLS portion of the labeled
> +                        * XFRM SID/label then pass along the XFRM SID as it
> +                        * has the most peer label information */
> +                       *sid = xfrm_sid;
> +       } else if (nlbl_sid != SECSID_NULL)
> +               *sid = nlbl_sid;
> +       else if (xfrm_sid != SECSID_NULL)
> +               *sid = xfrm_sid;
> +       else
> +               *sid = SECSID_NULL;
> +
> +       return 0;
>  }
>
>  /* socket security operations */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
