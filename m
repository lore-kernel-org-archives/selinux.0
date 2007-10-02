Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92JrIWc014948
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 15:53:18 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92JrHFm019034
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 19:53:17 GMT
Received: by wr-out-0506.google.com with SMTP id c8so2213621wra
        for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2007 12:53:17 -0700 (PDT)
Message-ID: <7e0fb38c0710021253x4c3a9bd2sd8006934801c2f74@mail.gmail.com>
Date: Tue, 2 Oct 2007 15:53:15 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [RFC PATCH v3 2/2] [SELINUX] Better integration between peer labeling subsystems
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071002183737.24760.64673.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071002183121.24760.92916.stgit@flek.americas.hpqcorp.net>
	 <20071002183737.24760.64673.stgit@flek.americas.hpqcorp.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/2/07, Paul Moore <paul.moore@hp.com> wrote:

> +               goto out_slowpath;
> +       }
> +       rc = mls_context_cmp(nlbl_ctx, xfrm_ctx);
> +
> +out_slowpath:
> +       POLICY_RDUNLOCK;
> +       if (rc == 0)
> +               /* at present NetLabel SIDs/labels really only carry MLS
> +                * information so if the MLS portion of the NetLabel SID
> +                * matches the MLS portion of the labeled XFRM SID/label
> +                * then pass along the XFRM SID as it has the most peer label
> +                * information */
> +               *peer_sid = xfrm_sid;
> +       else
> +               *peer_sid = SECSID_NULL;
> +       return rc;

Actually now that I look at it, doesn't mls_context_cmp return 1 if
they are the same and 0 if they are different?  So you'd need rc =
!mls_context_cmp ()  and we can then drop both the ss_initialized and
the mls_enabled stuff I was talking about before?

Am reading this wrong?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
