Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7C97Xx4000406
 for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2015 05:07:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 08FB3799CC
 for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2015 02:07:30 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id r9lnkEnSxtgb for <selinux@tycho.nsa.gov>;
 Wed, 12 Aug 2015 02:07:29 -0700 (PDT)
Received: from taipei.bbky.org (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id BC72C79763
 for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2015 02:07:29 -0700 (PDT)
Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
To: selinux@tycho.nsa.gov
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq> <55CA9B0E.9050109@jlbond.com>
 <55CABF6D.70408@jlbond.com>
From: Bond Masuda <bond.masuda@jlbond.com>
Message-ID: <55CB0CD0.4010603@jlbond.com>
Date: Wed, 12 Aug 2015 02:07:28 -0700
MIME-Version: 1.0
In-Reply-To: <55CABF6D.70408@jlbond.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 08/11/2015 08:37 PM, Bond Masuda wrote:
> So, further troubleshooting this myself, I found these errors from
> 'setfiles':
>
> /sbin/setfiles reset /usr/sbin/tzdata-update context
> system_u:object_r:bin_t:s0->system_u:object_r:tzdata_exec_t:s0
> /sbin/setfiles set context
> /usr/sbin/tzdata-update->system_u:object_r:tzdata_exec_t:s0
> failed:'Invalid argument'
> /sbin/setfiles reset /sbin/pam_timestamp_check context
> system_u:object_r:pam_timestamp_exec_t:s0->system_u:object_r:pam_exec_t:s0
> /sbin/setfiles reset /sbin/shutdown context
> system_u:object_r:bin_t:s0->system_u:object_r:shutdown_exec_t:s0
> /sbin/setfiles set context
> /sbin/shutdown->system_u:object_r:shutdown_exec_t:s0 failed:'Invalid
> argument'
> /sbin/setfiles reset /sbin/consoletype context
> system_u:object_r:bin_t:s0->system_u:object_r:consoletype_exec_t:s0
> /sbin/setfiles set context
> /sbin/consoletype->system_u:object_r:consoletype_exec_t:s0
> failed:'Invalid argument'
>
> I'm guessing this is because the "host" system doesn't have these types
> in it's own policy? The "host" is a Fedora 21 system, while the system
> mounted in /mnt/test is a CentOS6 system.
>
> Grepping the "types" above that give "invalid argument" on the host's
> file_context* files indeed comes up empty.
>
> So, I'm guessing this is where I need to use runcon -t setfiles_mac_t to
> run setfiles so it doesn't require the type to be one that is loaded in
> the host's SELinux policy?
>
> How do I use runcon? I tried:
>

Ok, figured this one out mostly, I think. Thanks to manpage
setfiles_selinux, I first had to set setfiles_mac_t to permissive with:

semanage permissive -a setfiles_mac_t

Then, I ran the setfiles commands under runcon as:

runcon -t setfiles_mac_t -- chroot /mnt /sbin/setfiles -v -F -e /proc -e
/sys -e /dev -e /selinux
/etc/selinux/targeted/contexts/files/file_contexts /

This fixes the previous "invalid argument" errors from setfiles. With
this process, there are still 2 labels that are wrong:

[root@localhost ~]# restorecon -v -n -r /
restorecon reset / context system_u:object_r:mnt_t:s0->system_u:object_r:root_t:s0
restorecon reset /.autofsck context system_u:object_r:mnt_t:s0->system_u:object_r:etc_runtime_t:s0

I think the /.autofsck is getting created during boot, and maybe just
inheriting from /. So, the question is why is / (root) still labeled as
mnt_t instead of root_t ? When the system is still mounted under
/mnt/test, /mnt/test (where / of the system is mounted) is correctly
labeled as root_t, but this seems to change once unmounted and i boot
the offline system?

Any insights?
-Bond
