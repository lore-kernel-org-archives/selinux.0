Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATFgkIi011607
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 10:42:46 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATFeBYf025632
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 15:41:13 GMT
Date: Mon, 29 Nov 2004 10:41:47 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
cc: sds@epoch.ncsc.mil, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>
Subject: Re: [2.6 patch] selinux: possible cleanups
In-Reply-To: <20041128190139.GD4390@stusta.de>
Message-ID: <Xine.LNX.4.44.0411291040320.6506-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 28 Nov 2004, Adrian Bunk wrote:

> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - avc.c: avc_ss_grant
>   - avc.c: avc_ss_try_revoke
>   - avc.c: avc_ss_revoke
>   - avc.c: avc_ss_set_auditallow
>   - avc.c: avc_ss_set_auditdeny
>   - ss/avtab.c: avtab_map
>   - ss/ebitmap.c: ebitmap_or
>   - ss/hashtab.c: hashtab_remove
>   - ss/hashtab.c: hashtab_replace
>   - ss/hashtab.c: hashtab_map_remove_on_error
>   - ss/services.c: security_member_sid
>   - ss/sidtab.c: sidtab_remove
> - remove the following unused static functions:
>   - avc.c: avc_update_cache
>   - avc.c: avc_control
> 

I think these functions were going to be left in for possible future use, 
but it's probably better to remove them and add them back only if 
necessary.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
