Message-ID: <554B61DB.1030103@tycho.nsa.gov>
Date: Thu, 07 May 2015 09:00:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Zhi Xin <xinzhi@marvell.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Give out all the avc logs in ome time
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
 <554A06E8.8030202@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
Content-Type: text/plain; charset=gbk
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2015 11:18 PM, Zhi Xin wrote:
> Thanks a lot~
> 
> I have another question: in last email, you mentioned two ways to eliminate the ratelimit.
> 
> (1) disable the audit ratelimit in logd by removing the AUDIT_STATUS_RATE_LIMIT flag from status.mask.
> (2) use the kernel https://bitbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929135babb1dbba272e27
> 
> I can understand how the kernel part work. But why do you still need to set a user space process like logd ? I mean the avc log is given by kernel. Why a user space process can affect its output ? Is is because the kernel log brought to user by this logd and if I want to disable audit ratelimit, I have to apply both of them ? 
> 
> I also wonder do we have a more simple mechanism like a open/off switch during runtime ? 

Until logd (or auditd in Linux distributions like Fedora) starts running
and registers itself to receive audit messages, the kernel logs the
audit records directly via printk, and those calls are wrapped with
printk_ratelimit checks to avoid a potential DOS.

Once logd (or auditd) is registered to receive audit messages, the
kernel sends audit records via the netlink audit socket to logd, and
logd then writes them to /dev/kmsg (so that they are still available via
dmesg; this differs from auditd behavior in Linux distributions) and
also writes them to the logcat events and main log buffers (and this is
obviously Android-specific).  logd also grabs any previously logged
audit records from dmesg and writes them to the logcat buffers so that
even the audit records generated before logd started should be included
in the logcat buffers, not just the ones generated afterward.

The printk ratelimit is only relevant for the audit messages generated
before logd is started, and for any warning/error messages logged via
printk (e.g. printk limit exceeded, backlog limit exceeded, rate limit
exceeded, out of memory...).  It is not configurable and is always
applied by the audit system when logging messages via printk.  That's
why we need a kernel patch to disable it.

The audit ratelimit on the other hand is relevant for all audit
messages, whether logged via printk or sent over the netlink audit
socket, but is only set if logd explicitly sets it to something.  And
since logd only sets it if it is also registering itself to receive
audit messages, then effectively the audit ratelimit only applies to
audit messages sent over the netlink audit socket to logd.  Not to
messages logged before logd starts.

I hadn't noticed this before, but in just looking at the logd code, I
see that there are also a couple of system properties that you can set
to alter its behavior wrt to audit:
name                       type default  description
logd.auditd                 bool  true   Enable selinux audit daemon
logd.auditd.dmesg           bool  true   selinux audit messages
duplicated and sent on to dmesg log

So you could possibly disable logd's audit functionality altogether by
setting logd.auditd to false and rebooting.  At which point you would
only be concerned with the printk ratelimit.
