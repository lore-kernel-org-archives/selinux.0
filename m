Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92JeDdp014058
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 15:40:13 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92JeAFm015045
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 19:40:10 GMT
Received: by ug-out-1314.google.com with SMTP id 30so2724715ugs
        for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2007 12:39:44 -0700 (PDT)
Message-ID: <7e0fb38c0710021239o41485a61u338ac760ab5adb3d@mail.gmail.com>
Date: Tue, 2 Oct 2007 15:39:42 -0400
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

> +       if (!ss_initialized || !selinux_mls_enabled) {
> +               *peer_sid = SECSID_NULL;
> +               return 0;
> +       }

Is it possible for both netlbl_sid and xfrm_sid to be != SECSID_NULL
if !ss_initialized?  What label to packets get while !ss_initialized?

The selinux_mls_enabled check is (i think) also useless at the moment
since if MLS is off won't netlbl_sid be null?  But I guess it doesn't
hurt to leave it in there.   We can't call mls_context_cmp() the way
you are below if !selinux_mls_enabled since apparently no MLS != no
MLS (which i wonder if it's right, but i didn't check all the callers
of it)

</nit picking>

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
