Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5GIxoAM023167
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 14:59:50 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5GIxowL025031
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 18:59:50 GMT
Subject: Re: New domain for qemu
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4831B565.50707@comcast.net>
References: <4831B565.50707@comcast.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Jun 2008 14:58:34 -0400
Message-Id: <1213642714.11146.68.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

﻿On Mon, 2008-05-19 at 13:14 -0400, Daniel J Walsh wrote:
> Gzip archive attachment (system_qemu.patch.gz)

﻿Merged.  There are some missing interfaces, so I commented out the
calls.

> +## <desc>
> +## <p>
> +## Allow qemu to connect fully to the network
> +## </p>
> +## </desc>
> +gen_tunable(allow_qemu_full_network,false)

I renamed this to qemu_full_network.  I'd like to make an effort to have
the first word in the boolean name to be the module name, as we do for
interfaces.  At least for booleans local to one module, like this one.

> +	term_use_ptmx($1_t)
> +	term_getattr_pty_fs($1_t)
> +	term_use_generic_ptys($1_t)

This leads me to believe that qemu opens up a pty.  Can you check that?
If it does, then it needs to have its own label.

> +optional_policy(`
> +	xserver_xdm_rw_shm(qemu_unconfined_t)
> +')

Not clear why this is needed, since we have this already:

allow unconfined_domain_type domain:{ sem msgq shm } *;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
