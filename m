Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QLqa9B030108
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 16:52:36 -0500
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QLqZ9c023256
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 21:52:35 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1927534wfc.30
        for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 13:52:34 -0800 (PST)
Message-ID: <7e0fb38c0802261352r52318774v562f8e635a3f44cc@mail.gmail.com>
Date: Tue, 26 Feb 2008 16:52:34 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "paul.moore@hp.com" <paul.moore@hp.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/5] New labeled networking permissions for 2.6.25
In-Reply-To: <20080226184032.834798290@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080226184032.834798290@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/26/08, paul.moore@hp.com <paul.moore@hp.com> wrote:
>  It is important to note that
>  while this patchset adds the permissions required it doesn't enable the
>  "network_peer_controls" policy capability.

Darn it, I'm trying to play with a new capability for something I'm
writing and I just read this whole patch set (before i read 0/5) to
see where you decided to define it so I could copy that in my policy.
Thanks for not doing the one thing I was hunting for!

So, does anyone have a good idea suggestions where we should turn
on/off these new capabilities?  I know it has to be in the base module
in the end, but I don't know what file to put them in.  I might just
throw it in kernel.te for now for me to keep testing but I assume we
are going to want all of these definitions in one place?  Are we going
to want them all over as long as they end up being built into base?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
