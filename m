Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PEPGeB022526
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 10:25:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7PEOfut004087
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 14:24:42 GMT
Subject: Re: [PATCH] Add boolean controlling user access to kernel keyring
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        redhat-lspp-list <redhat-lspp@redhat.com>
In-Reply-To: <20060825005512.GA17489@w-m-p.com>
References: <20060825005512.GA17489@w-m-p.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 10:25:27 -0400
Message-Id: <1156515928.3199.14.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-24 at 19:55 -0500, Klaus Weidner wrote:
> This patch adds the boolean "allow_kernel_keyring_user_access" with the
> goal of implementing an on/off switch for the kernel keyring as far as
> unprivileged users are concerned. It defaults to true which corresponds
> to the original behavior without this patch.
> 
> The reason for the patch is that the kernel keyring is a fairly complex
> piece of code that would need testing and documentation if it were
> available in the evaluated configuration for LSPP (labeled security
> protection profile) compliant systems, and since it's unlikely to
> currently be useful on those systems it would greatly simplify things to
> have a way to disable the feature for unprivileged users at runtime.

I'm confused, there isn't any unprivileged user access that is disabled
by this policy, only login programs.  Besides that, I really don't think
this is needed because what you're saying is that you don't trust the
key code.  However, the code that enforces this policy is the code that
you don't trust, so this policy wouldn't gain anything.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
