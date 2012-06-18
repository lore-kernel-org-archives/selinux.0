Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5IFPVN5001500
	for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2012 11:25:31 -0400
Received: by yhp26 with SMTP id 26so4054455yhp.12
        for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2012 08:25:30 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Cc: method@manicmethod.com
Subject: Re: [PATCH external/sepolicy] Add iptables script to policy
Date: Mon, 18 Jun 2012 11:25:25 -0400
Message-ID: <1523270.GXfVyoc8BM@sifl>
In-Reply-To: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday, June 16, 2012 02:56:34 PM Joshua Brindle wrote:
> diff --git a/iptables-selinux.sh b/iptables-selinux.sh
> new file mode 100755
> index 0000000..e9ac7d1
> --- /dev/null
> +++ b/iptables-selinux.sh
> @@ -0,0 +1,18 @@
> +#!/system/bin/sh
> +
> +IPTABLES="/system/bin/iptables"
> +
> +#$IPTABLES -t mangle -A INPUT -i wlan0 -j SECMARK --selctx ...

Perhaps we should use the security table instead of the mangle table?

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
