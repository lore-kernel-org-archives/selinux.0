Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LIsTWt029221
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:54:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LIsSIE012639
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:54:28 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9LIsR1J012635 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:54:27 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F9575DE.3010802@redhat.com>
References: <200310200148.15852.russell@coker.com.au>
	 <200310211052.28494.russell@coker.com.au>
	 <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
	 <200310220043.09925.russell@coker.com.au>
	 <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
	 <3F9575DE.3010802@redhat.com>
Content-Type: text/plain
Message-Id: <1066762458.27065.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 14:54:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 14:07, Daniel J Walsh wrote:
> Here is my patch to init to load initial policy.

> +#define POLICY_FILE "/etc/security/selinux/policy"
> +#define DEFAULT_POLICY_VERSION 15
> +#define SELINUXMNT "/selinux"
> +#define POLICY_VERSION_FILE "/selinux/policyvers"
> +#define SELINUX_ENFORCE_FILE "/selinux/enforce"

We should likely encapsulate these definitions in libselinux, and
provide functions for obtaining them, rather than hardcoding them in
/sbin/init.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
