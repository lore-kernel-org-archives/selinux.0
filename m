From: Zhi Xin <xinzhi@marvell.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Date: Wed, 6 May 2015 20:18:26 -0700
Subject: RE: Give out all the avc logs in ome time
Message-ID: <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
 <554A06E8.8030202@tycho.nsa.gov>
In-Reply-To: <554A06E8.8030202@tycho.nsa.gov>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks a lot~

I have another question: in last email, you mentioned two ways to eliminate the ratelimit.

(1) disable the audit ratelimit in logd by removing the AUDIT_STATUS_RATE_LIMIT flag from status.mask.
(2) use the kernel https://bitbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929135babb1dbba272e27

I can understand how the kernel part work. But why do you still need to set a user space process like logd ? I mean the avc log is given by kernel. Why a user space process can affect its output ? Is is because the kernel log brought to user by this logd and if I want to disable audit ratelimit, I have to apply both of them ? 

I also wonder do we have a more simple mechanism like a open/off switch during runtime ? 

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: 2015Äê5ÔÂ6ÈÕ 20:20
To: Zhi Xin; selinux@tycho.nsa.gov
Cc: seandroid-list@tycho.nsa.gov
Subject: Re: Give out all the avc logs in ome time

On 05/05/2015 10:18 PM, Zhi Xin wrote:
> Hi Stephen,
> 
> Thanks a lot for the suggestion. I will try them later. I have another question for this audit ratelimit. Why not always disable it ? Too much printk come up ? 

In general, the printk and audit ratelimits are to prevent a denial of service (DOS) by flooding the system with too many messages/denials.  In the case of Android, they started setting the audit ratelimit in logd (starting with 5.1.0) because of reported crashes that _might_ have been due to a large number of SELinux denials flooding the serial console and ultimately leading to a watchdog reset, although I am not sure if the exact cause was ever fully confirmed.
