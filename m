Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB3G2wIi009228
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 11:02:58 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB3G3168006865
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 16:03:01 GMT
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <20041128190139.GD4390@stusta.de>
References: <20041128190139.GD4390@stusta.de>
Content-Type: text/plain
Message-Id: <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Dec 2004 10:54:56 -0500
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
> 
> Please review and comment on which of these changes are correct and 
> which conflict with pending patches for in-kernel users of the functions 
> affected.

Thanks for working on these cleanups.  I've separately submitted a patch
to export security_member_sid via selinuxfs, as it is part of the
security policy API and is needed for further work on security
polyinstantiation (e.g. multi-level directory support), so please remove
the diffs related to removing that function.  Two other comments:
- Did you mean to make avtab_insert static (you only removed the
function prototype for it)?
- Shouldn't the AVC_CALLBACK_* definitions other than RESET be removed
since you are removing the other avc_ss interfaces?

Otherwise, the patch seems sane to me.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
