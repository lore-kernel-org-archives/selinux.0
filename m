Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77Gbihb006274
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 12:37:44 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l77GbfAB004512
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 16:37:42 GMT
Subject: Re: [PATCH] refpolicy: kernel_filesystem changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022003.l72K3hC5029678@redsox.boston.devel.redhat.com>
References: <200708022003.l72K3hC5029678@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 12:37:11 -0400
Message-Id: <1186504631.18881.29.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:03 -0400, dwalsh@redhat.com wrote:
> anon_inodefs file system

> +type anon_inodefs_t;
> +fs_type(anon_inodefs_t)
> +files_mountpoint(anon_inodefs_t)
> +genfscon anon_inodefs / gen_context(system_u:object_r:anon_inodefs_t,s0)

Does this not work as task sid?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
