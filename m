Message-ID: <554CB2A1.4030402@tycho.nsa.gov>
Date: Fri, 08 May 2015 08:57:05 -0400
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
 <554B61DB.1030103@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66612A3FE0@SC-VEXCH4.marvell.com>
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66612A3FE0@SC-VEXCH4.marvell.com>
Content-Type: text/plain; charset=gbk
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/08/2015 04:46 AM, Zhi Xin wrote:
> Thanks for details information!
> 
> For the switch question, I get your point. logd.auditd is the switch of whether logd can record selinux audit log. But I'm looking for the switch of ratelimit. I mean, removing ratelimit is really helpful for selinux debugging, especially in bringup stage. But meanwhile, removing it just opens the gate for potential DOS. So should we have a simple command that can disable ratelimit during bringup debugging and enable it for release. Just like we can switch to permissive mode by setenforce 0. 

For this, you'd need an audit boot parameter in order to fully disable
the printk ratelimit even before logd starts.  So it would require a
kernel patch to define such a parameter.  There are existing audit boot
parameters for enabling/disabling audit (audit=0|1) and for setting the
backlog limit (audit_backlog_limit=N).  Those are defined in
kernel/audit.c via __setup() calls.  You could add an audit_ratelimit=N
and/or an audit_printk_ratelimit=0|1 boot parameters.

Kernel audit patches would need to go to the audit maintainers (see the
MAINTAINERS entry for AUDIT) and the linux-audit@redhat.com mailing
list, subscribe via:
https://www.redhat.com/mailman/listinfo/linux-audit

Once the kernel audit patch was accepted, then you could submit it to
kernel/common in AOSP and also submit a patch for logd so that it would
check /proc/cmdline for the parameter and if set, honor it rather than
overriding it.
