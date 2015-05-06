Message-ID: <554A06E8.8030202@tycho.nsa.gov>
Date: Wed, 06 May 2015 08:19:52 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Zhi Xin <xinzhi@marvell.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Give out all the avc logs in ome time
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
Content-Type: text/plain; charset=gbk
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/2015 10:18 PM, Zhi Xin wrote:
> Hi Stephen,
> 
> Thanks a lot for the suggestion. I will try them later. I have another question for this audit ratelimit. Why not always disable it ? Too much printk come up ? 

In general, the printk and audit ratelimits are to prevent a denial of
service (DOS) by flooding the system with too many messages/denials.  In
the case of Android, they started setting the audit ratelimit in logd
(starting with 5.1.0) because of reported crashes that _might_ have been
due to a large number of SELinux denials flooding the serial console and
ultimately leading to a watchdog reset, although I am not sure if the
exact cause was ever fully confirmed.
