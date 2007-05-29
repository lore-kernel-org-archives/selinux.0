Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TIbxaP014086
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 14:37:59 -0400
Received: from smtp4.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4TIbwIh026861
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 18:37:58 GMT
Received: from BLUMS0022.bluelnk.net (blums0022.na.baesystems.com [10.40.96.145])
	by smtp4.na.baesystems.com (8.13.6/8.13.6) with ESMTP id l4TIbXmL008480
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 14:37:33 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: redefining the numer of sensitivities and reconfiguring usersand login
Date: Tue, 29 May 2007 11:37:56 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBEE8F@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Cc: <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, May 29, 2007 11:21 AM
To: Clarkson, Mike R (US SSA)
Subject: Re: redefining the numer of sensitivities and reconfiguring
usersand login

On Wed, 2007-05-23 at 17:29 -0700, Clarkson, Mike R (US SSA) wrote:
> I'm trying to reduce the number of sensitivities from 16 to 5 (s0 -
s4)

Suggest posting to selinux list, cc Chris PeBenito
<cpebenito@tresys.com>

This is a general question for selinux policy.

I suspect you have to rebuild the policy package with your modified
notion of SystemHigh to make it take effect throughout.

> 
> Looks like I can redefine the number of sensitivities in the
build.conf
> file and Makefile file and then use "make load" to make the change
take
> effect. Is that correct?
> 
> I assume that I'll need to use fixfiles to relabel any files that have
> contexts with sensitivity levels greater than s4. Is that correct?
> 
> Before reducing the number of sensitivities, I wanted to reconfigure
the
> users and login using semanage. I've defined SystemHigh to be
s4:c0.c255
> in the setrans.conf file. This is what "semanage user -l" returns:
> 
> # semanage user -l
> 
>                 Labeling   MLS/       MLS/
> SELinux User    Prefix     MCS Level  MCS Range
> SELinux Roles
> 
> m2_u            user       SystemLow  SystemLow-s15:c0.c255
> system_r user_r
> root            user       SystemLow  SystemLow-s15:c0.c255
> system_r sysadm_r user_r
> system_u        user       SystemLow  SystemLow-s15:c0.c255
> system_r
> user_u          user       SystemLow  SystemLow-s15:c0.c255
> system_r user_r
> 
> I can change both the m2_u and user_u users to have a range of
> SystemLow-SystemHigh, but only in permissive mode. If in enforcing
mode,
> I get the following error:
> 
> # semanage user -m -r SystemLow-SystemHigh user_u
> libsepol.mls_from_string: invalid MLS context SystemLow-SystemHigh
> libsepol.mls_from_string: could not construct mls context structure
> libsepol.sepol_user_modify: could not load (null) into policy
> libsemanage.dbase_policydb_modify: could not modify record value
> libsemanage.semanage_base_merge_components: could not merge local
> modifications into policy
> /usr/sbin/semanage: Could not modify SELinux user user_u
> 
> Even in permissive mode I can not change the root or system_u users.
In
> permissive mode I get the following error message:
> 
> # semanage user -m -r SystemLow-SystemHigh system_u
> libsepol.context_read_and_validate: invalid security context
> libsepol.policydb_from_image: policy image is invalid
> /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> libsemanage.semanage_reload_policy: load_policy returned error code 2.
> /usr/sbin/semanage: Could not modify SELinux user system_u
> 
> "policy image is invalid" sounds particularly bad
> 
> I'm running as Linux user root and SELinux user root. Here is an
output
> of id:
> 
> uid=0(root) gid=0(root)
>
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),101(pkcs
> 11) context=root:system_r:unconfined_t:SystemLow-s15:c0.c255
> 
> Can anyone help with what I need to do?
> 
> Thanks
> 
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
-- 
Stephen Smalley
National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
