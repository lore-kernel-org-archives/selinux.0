Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3NEgdrm014897
 for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2014 10:42:39 -0400
Message-ID: <1398264152.2596.25.camel@flatline.rdu.redhat.com>
Subject: Re: [PATCH 0/6][v2] audit: implement multicast socket for journald
From: Eric Paris <eparis@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Date: Wed, 23 Apr 2014 10:42:32 -0400
In-Reply-To: <5357C2D2.5060700@redhat.com>
References: <20140422.161904.1187535812839850973.davem@davemloft.net>
 <cover.1398215388.git.rgb@redhat.com> <26389161.vp9iWSVLPX@x2>
 <1398225475.750.7.camel@localhost> <5357C2D2.5060700@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, jamal@mojatatu.com, Steve Grubb <sgrubb@redhat.com>,
 davem@davemloft.net
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2014-04-23 at 09:40 -0400, Daniel J Walsh wrote:
> Here are the capabilities we currently give to sysadm_t with
> sysadm_secadm    1.0.0    Disabled
> 
>    allow sysadm_t sysadm_t : capability { chown dac_override
> dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable
> net_bind_service net_broadcast net_admin net_raw ipc_lock ipc_owner
> sys_rawio sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice
> sys_resource sys_time sys_tty_config mknod lease audit_write setfcap } ;
>    allow sysadm_t sysadm_t : capability { setgid setuid sys_chroot }
> 
>    allow sysadm_t sysadm_t : capability2 { syslog block_suspend } ;
> 
> cap_audit_write might be a problem?

cap_audit_write is fine.

syslogd_t (aka journal) is going to need the new permission
cap_audit_read.  Also, as steve pointed out, someone may be likely to
want to be able to disable that permission easily.

-Eric
