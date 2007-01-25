Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PKptIj010330
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 15:51:55 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PKqrGs024501
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 20:52:54 GMT
Message-ID: <45B9189C.1080807@redhat.com>
Date: Thu, 25 Jan 2007 15:52:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Antoine Martin <antoine@nagafix.co.uk>
CC: selinux@tycho.nsa.gov
Subject: Re: new postfix-script errors idr_remove
References: <45B8E456.5090501@nagafix.co.uk>
In-Reply-To: <45B8E456.5090501@nagafix.co.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Antoine Martin wrote:
> This message just started appearing on one of my servers. Any idea 
> what this means?
>
> [ 1766.037624] audit(1169838474.626:79): avc:  denied  { search } for 
> pid=13983 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.037694] idr_remove called for id=4 which is not allocated.
> [ 1766.037698]  [<c0266075>] sub_remove+0xe5/0xf0
> [ 1766.037710]  [<c0266098>] idr_remove+0x18/0x80
> [ 1766.037715]  [<c02a5b90>] release_dev+0x490/0x6d0
> [ 1766.037727]  [<c02a4186>] tty_ldisc_enable+0x26/0x30
> [ 1766.037731]  [<c02a5297>] init_dev+0x237/0x4e0
> [ 1766.037736]  [<c02a5f0f>] tty_open+0x13f/0x2b0
> [ 1766.037740]  [<c015f692>] chrdev_open+0x52/0x120
> [ 1766.037746]  [<c015f640>] chrdev_open+0x0/0x120
> [ 1766.037750]  [<c015643a>] __dentry_open+0x9a/0x170
> [ 1766.037755]  [<c0156625>] nameidata_to_filp+0x35/0x40
> [ 1766.037759]  [<c015654b>] filp_open+0x3b/0x50
> [ 1766.037762]  [<c01566f5>] get_unused_fd+0x45/0xb0
> [ 1766.037766]  [<c015680d>] do_sys_open+0x3d/0xd0
> [ 1766.037770]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
> [ 1766.038778] audit(1169838474.626:80): avc:  denied  { search } for 
> pid=13983 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.064173] audit(1169838474.654:81): avc:  denied  { search } for 
> pid=13985 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.064242] idr_remove called for id=4 which is not allocated.
> [ 1766.064246]  [<c0266075>] sub_remove+0xe5/0xf0
> [ 1766.064257]  [<c0266098>] idr_remove+0x18/0x80
> [ 1766.064261]  [<c02a5b90>] release_dev+0x490/0x6d0
> [ 1766.064272]  [<c02a4186>] tty_ldisc_enable+0x26/0x30
> [ 1766.064277]  [<c02a5297>] init_dev+0x237/0x4e0
> [ 1766.064281]  [<c02a5f0f>] tty_open+0x13f/0x2b0
> [ 1766.064286]  [<c015f692>] chrdev_open+0x52/0x120
> [ 1766.064291]  [<c015f640>] chrdev_open+0x0/0x120
> [ 1766.064295]  [<c015643a>] __dentry_open+0x9a/0x170
> [ 1766.064300]  [<c0156625>] nameidata_to_filp+0x35/0x40
> [ 1766.064304]  [<c015654b>] filp_open+0x3b/0x50
> [ 1766.064307]  [<c01566f5>] get_unused_fd+0x45/0xb0
> [ 1766.064311]  [<c015680d>] do_sys_open+0x3d/0xd0
> [ 1766.064315]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
> [ 1766.065227] audit(1169838474.654:82): avc:  denied  { search } for 
> pid=13985 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.071472] audit(1169838474.658:83): avc:  denied  { search } for 
> pid=13986 comm="sh" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.071550] idr_remove called for id=4 which is not allocated.
> [ 1766.071554]  [<c0266075>] sub_remove+0xe5/0xf0
> [ 1766.071565]  [<c0266098>] idr_remove+0x18/0x80
> [ 1766.071570]  [<c02a5b90>] release_dev+0x490/0x6d0
> [ 1766.071580]  [<c0103904>] apic_timer_interrupt+0x1c/0x24
> [ 1766.071586]  [<c02a4186>] tty_ldisc_enable+0x26/0x30
> [ 1766.071591]  [<c02a5297>] init_dev+0x237/0x4e0
> [ 1766.071595]  [<c02a5f0f>] tty_open+0x13f/0x2b0
> [ 1766.071600]  [<c015f692>] chrdev_open+0x52/0x120
> [ 1766.071606]  [<c015f640>] chrdev_open+0x0/0x120
> [ 1766.071610]  [<c015643a>] __dentry_open+0x9a/0x170
> [ 1766.071615]  [<c0156625>] nameidata_to_filp+0x35/0x40
> [ 1766.071619]  [<c015654b>] filp_open+0x3b/0x50
> [ 1766.071622]  [<c01566f5>] get_unused_fd+0x45/0xb0
> [ 1766.071626]  [<c015680d>] do_sys_open+0x3d/0xd0
> [ 1766.071630]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
> [ 1766.072744] audit(1169838474.662:84): avc:  denied  { search } for 
> pid=13986 comm="sh" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.504354] audit(1169838475.094:85): avc:  denied  { search } for 
> pid=14003 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.504425] idr_remove called for id=4 which is not allocated.
> [ 1766.504430]  [<c0266075>] sub_remove+0xe5/0xf0
> [ 1766.504442]  [<c0266098>] idr_remove+0x18/0x80
> [ 1766.504446]  [<c02a5b90>] release_dev+0x490/0x6d0
> [ 1766.504457]  [<c02a4186>] tty_ldisc_enable+0x26/0x30
> [ 1766.504462]  [<c02a5297>] init_dev+0x237/0x4e0
> [ 1766.504466]  [<c02a5f0f>] tty_open+0x13f/0x2b0
> [ 1766.504471]  [<c015f692>] chrdev_open+0x52/0x120
> [ 1766.504477]  [<c015f640>] chrdev_open+0x0/0x120
> [ 1766.504480]  [<c015643a>] __dentry_open+0x9a/0x170
> [ 1766.504486]  [<c0156625>] nameidata_to_filp+0x35/0x40
> [ 1766.504489]  [<c015654b>] filp_open+0x3b/0x50
> [ 1766.504493]  [<c01566f5>] get_unused_fd+0x45/0xb0
> [ 1766.504497]  [<c015680d>] do_sys_open+0x3d/0xd0
> [ 1766.504500]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
> [ 1766.504726] audit(1169838475.094:86): avc:  denied  { search } for 
> pid=14003 comm="postfix-script" name="/" dev=devpts ino=1 
> scontext=system_u:system_r:postfix_master_t 
> tcontext=system_u:object_r:devpts_t tclass=dir
> [ 1766.706517] idr_remove called for id=4 which is not allocated.
> [ 1766.706527]  [<c0266075>] sub_remove+0xe5/0xf0
> [ 1766.706540]  [<c0266098>] idr_remove+0x18/0x80
> [ 1766.706545]  [<c02a5b90>] release_dev+0x490/0x6d0
> [ 1766.706556]  [<c0147602>] free_pte_range+0x32/0x40
> [ 1766.706567]  [<c02a6217>] tty_release+0x7/0x10
> [ 1766.706572]  [<c0158147>] __fput+0x97/0x140
> [ 1766.706578]  [<c0156937>] filp_close+0x47/0x80
> [ 1766.706582]  [<c014c64e>] exit_mmap+0xae/0xd0
> [ 1766.706588]  [<c0120637>] put_files_struct+0x97/0xc0
> [ 1766.706593]  [<c01211b6>] do_exit+0x116/0x310
> [ 1766.706596]  [<c0121416>] do_group_exit+0x26/0x60
> [ 1766.706600]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Indicates postfix-script is not able to search /dev/ for pseudo terminals.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
