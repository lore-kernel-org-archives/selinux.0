Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AIverT000159
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:57:40 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AIvZP2019345
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:57:35 -0400 (EDT)
Subject: Re: too many sysadmfile?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1086884579.19414.30.camel@gorn.pebenito.net>
References: <1086884579.19414.30.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 14:57:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-06-10 at 12:22, Chris PeBenito wrote:
> One thing that hasn't sat well with me for a long time is that just
> about all file_types are sysadmfile in the strict policy.  To me, this
> sounds like an excessive amount of access for sysadm_t (with exception
> of the unrestricted_admin tunable being on).
> 
> Its true that since sysadm_t can already relabel almost everything, it
> makes this change moot from a security perspective, since it can relabel
> a file to something it can modify.  However, by limiting normal access,
> it affords some protection against accidental overwrites and deletions,
> and from malicious programs a sysadmin might accidentally run.  In my
> opinion, the packagers (rpm_t, etc) should be the only ones with access
> all file_types.
> 
> I haven't looked into it much, but my idea is eliminate sysadmfile
> except where its obviously warranted, such as in /etc/* types.  Then
> change the sysadmfile policy in admin_domain to something like:
> 
> ifdef(`unrestricted_admin',`
> create_dir_notdevfile($1_t,{ file_type -device_type -shadow_t })
> ',`
> create_dir_notdevfile($1_t,sysadmfile)
> ')
> 
> Or maybe use a boolean could be used, instead of a tunable.  Then change
> the relabeling rule to:
> 
> # Relabel all files except shadow_t.
> allow $1_t { file_type -shadow_t }:dir { getattr read search relabelfrom relabelto };
> allow $1_t { file_type -shadow_t }:file_class_set { getattr relabelfrom relabelto };
> 
> Comments?

A commendable goal, but you need to gradually migrate toward such a
scheme, as existing usage assumes direct access by admins running common
utilities, using shell redirection, etc.  The strict policy (with
unrestricted_admin disabled) does prevent direct access to some types
(e.g. devices), but certainly not many, as you noted.  With regard to
malicious programs, you can help reduce the risk by tightening the set
of types that are executable by sysadm_t.  You might also want to
consider restricting inputs to sysadm_t, e.g. preventing sysadm_t from
reading symlinks with non-system types to prevent an admin from
following a malicious symlink.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
