Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATGGJIi011791
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 11:16:19 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATGEkYd028281
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 16:14:46 GMT
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <20041128190139.GD4390@stusta.de>
References: <20041128190139.GD4390@stusta.de>
Content-Type: text/plain
Message-Id: <1101744496.13948.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 11:08:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-11-28 at 14:01, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - avc.c: avc_ss_grant
>   - avc.c: avc_ss_try_revoke
>   - avc.c: avc_ss_revoke
>   - avc.c: avc_ss_set_auditallow
>   - avc.c: avc_ss_set_auditdeny

These functions are part of an overall interface between the AVC and the
security server designed to support dynamic security policy
requirements, based on prior studies including some formal analysis. 
While the example security server does not presently use anything other
than avc_ss_reset, I'd be hesitant to completely remove the rest of the
interface, as that will leave a far less functional interface for future
security servers and may lead to further "optimization" of the AVC that
will preclude support for dynamic policy requirements (or at least make
it much harder to restore such support).

>   - ss/services.c: security_member_sid

There are patches under development for SELinux that make use of this
function, including exporting the interface to userspace via selinuxfs
and using it in-kernel for polyinstantiation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
