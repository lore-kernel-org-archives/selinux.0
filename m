Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HHUKTU026918
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 12:30:20 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HHUETY013520
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 17:30:19 GMT
Received: by fg-out-1718.google.com with SMTP id 16so675150fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 09:30:13 -0800 (PST)
Message-ID: <7e0fb38c0801170930l4a63e2c5v917a1dbcf926cf6a@mail.gmail.com>
Date: Thu, 17 Jan 2008 12:30:13 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080117172246.341834342@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080117172246.341834342@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/17/08, Paul Moore <paul.moore@hp.com> wrote:
> At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
> permissions were added to the "packet" class, most likely as part of the
> ill-fated secid-reconciliation effort.  Despite the fact that these permissions
> are not currently used they should be included in the Reference Policy as they
> are now a permanent fixture in Fedora and it is crucial that the FLASK
> defines be kept in sync.
>
> This patch needs to be applied before any other patches that affect the
> "packet" class, otherwise the resulting policy may not load.
>
> Signed-off-by: Paul Moore <paul.moore@hp.com>
Acked-by: Eric Paris <eparis@redhat.com>

And sorry about us getting a bit overzelous but as long as these are
in gen_requires statements we can't drop them  :(

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
