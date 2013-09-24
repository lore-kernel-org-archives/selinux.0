Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8OGrjpi029205
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2013 12:53:45 -0400
Date: Tue, 24 Sep 2013 16:53:43 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <pmoore@redhat.com>
Cc: serge@hallyn.com, selinux@tycho.nsa.gov
Subject: Re: [selinux-testsuite RFC PATCH 4/4] test_policy: create a "build"
 target
Message-ID: <20130924165343.GD8126@mail.hallyn.com>
References: <20130924162401.27393.70353.stgit@localhost>
 <20130924163339.27393.82092.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130924163339.27393.82092.stgit@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (pmoore@redhat.com):
> Signed-off-by: Paul Moore <pmoore@redhat.com>

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

> ---
>  policy/Makefile |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 8763143..3a8a10d 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -25,7 +25,9 @@ ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te
>  endif
>  
> -all: $(TARGETS)
> +all: build
> +
> +build: $(TARGETS)
>  ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
>  	# RHEL specific policy build
>  	$(MAKE) -C redhat/$(RHEL_VERS) all \

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
