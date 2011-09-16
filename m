Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G4t5SX019000
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 00:55:05 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G4t4mU000709
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 04:55:04 GMT
Subject: Re: [PATCH 51/67] libsepol: Preserve tunables when required by
 semodule
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 06:55:00 +0200
In-Reply-To: <4E7257FE.6070703@redhat.com>
References: <4E7257FE.6070703@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316148900.2364.33.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 15:54 -0400, Daniel J Walsh wrote:
> From f2a839faa71dac0bc575615bfe0aafca94a00892 Mon Sep 17 00:00:00 2001
> From: Harry Ciao <qingtao.cao@windriver.com>
> Date: Thu, 1 Sep 2011 11:29:47 +0800
> Subject: [PATCH 51/67] libsepol: Preserve tunables when required by
> semodule
>  program.
> 
> If the "-P/--preserve_tunables" option is set for the semodule
> program,
> the preserve_tunables flag in sepol_handle_t would be set, then all
> tunables
> would be treated as booleans by having their TUNABLE flag bit cleared,
> resulting in all tunables if-else conditionals preserved for raw
> policy.
> 
> Note, such option would invalidate the logic to double-check if
> tunables
> ever mix with booleans in one expression, so skip the call to assert()
> when this option is passed.
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libsepol/src/expand.c |   36 ++++++++++++++++++++++++------------
>  1 files changed, 24 insertions(+), 12 deletions(-) 

Hello Dan.

The new option seems not fully enabled yet by parsing the option and
setting the preserve_tunables flag appropriately in main().

Is it going to be enabled elsewhere ?

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
