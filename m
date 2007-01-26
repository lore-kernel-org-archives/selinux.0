Subject: Re: new postfix-script errors idr_remove
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <45B91E81.6010106@nagafix.co.uk>
References: <45B8E456.5090501@nagafix.co.uk> <45B9189C.1080807@redhat.com>
	 <45B91E81.6010106@nagafix.co.uk>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 07:24:53 -0500
Message-Id: <1169814293.15390.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-25 at 21:17 +0000, Antoine Martin wrote:
> Daniel J Walsh wrote:
> > Antoine Martin wrote:
> >> This message just started appearing on one of my servers. Any idea 
> >> what this means?
> >>
> >> [ 1766.037624] audit(1169838474.626:79): avc:  denied  { search } for 
> >> pid=13983 comm="postfix-script" name="/" dev=devpts ino=1 
> >> scontext=system_u:system_r:postfix_master_t 
> >> tcontext=system_u:object_r:devpts_t tclass=dir
> >> [ 1766.037694] idr_remove called for id=4 which is not allocated.
> >> [ 1766.037698]  [<c0266075>] sub_remove+0xe5/0xf0
> >> [ 1766.037710]  [<c0266098>] idr_remove+0x18/0x80
> >> [ 1766.037715]  [<c02a5b90>] release_dev+0x490/0x6d0
> >> [ 1766.037727]  [<c02a4186>] tty_ldisc_enable+0x26/0x30
> >> [ 1766.037731]  [<c02a5297>] init_dev+0x237/0x4e0
> >> [ 1766.037736]  [<c02a5f0f>] tty_open+0x13f/0x2b0
> >> [ 1766.037740]  [<c015f692>] chrdev_open+0x52/0x120
> >> [ 1766.037746]  [<c015f640>] chrdev_open+0x0/0x120
> >> [ 1766.037750]  [<c015643a>] __dentry_open+0x9a/0x170
> >> [ 1766.037755]  [<c0156625>] nameidata_to_filp+0x35/0x40
> >> [ 1766.037759]  [<c015654b>] filp_open+0x3b/0x50
> >> [ 1766.037762]  [<c01566f5>] get_unused_fd+0x45/0xb0
> >> [ 1766.037766]  [<c015680d>] do_sys_open+0x3d/0xd0
> >> [ 1766.037770]  [<c0102ebb>] sysenter_past_esp+0x54/0x75
> >> [ 1766.038778] audit(1169838474.626:80): avc:  denied  { search } for 
> (...)
> > Indicates postfix-script is not able to search /dev/ for pseudo terminals.
> I was going to just allow that (although I am not too sure why this only 
> just started now).
> Why does it come with a stack trace?

See:
http://marc.theaimsgroup.com/?l=selinux&m=112419712132326&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
