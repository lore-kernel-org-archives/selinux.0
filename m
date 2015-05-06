From: Zhi Xin <xinzhi@marvell.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Date: Tue, 5 May 2015 19:18:14 -0700
Subject: RE: Give out all the avc logs in ome time
Message-ID: <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
In-Reply-To: <5548BA95.2040908@tycho.nsa.gov>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Stephen,

Thanks a lot for the suggestion. I will try them later. I have another question for this audit ratelimit. Why not always disable it ? Too much printk come up ? 

Sincerely
Alan Xin

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: 2015Äê5ÔÂ5ÈÕ 20:42
To: Zhi Xin; selinux@tycho.nsa.gov
Cc: seandroid-list@tycho.nsa.gov
Subject: Re: Give out all the avc logs in ome time

On 05/04/2015 10:06 PM, Zhi Xin wrote:
> Hi All,
> 
>  
> 
> In my daily work, I¡¯m always solving the selinux deny as presented by 
> avc log. But I found that, for one particular test, selinux cannot 
> give me all the avc deny log in one time, which has slowed down a lot 
> of my daily work.
> 
>  
> 
> For example, I trigger a process called test_daemon to access a 
> /dev/test_device in a particular test. Totally, it should have ¡°open, 
> read, write, ioctl¡± for permissions. But for one time test, I only 
> catch ¡°open, read¡± related avc log. And only after I have merged a 
> patch to give the ¡°open¡± and ¡°read¡± permission, I rerun the test. The 
> ¡°write ioctl¡± related avc  logs start to occur. So my question is how 
> can I get ¡°open, read, write, ioctl¡± avc log in one test.
> 
>  
> 
> I have done a little study on this issue. selinux avc log depends on 
> audit subsystem. In /kernel/kernel/audit.c, some code has indicated 
> that we may lost the records in five ways:
> 
> 115 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#115>/* Records can be lost in several ways:
> 
> 116 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#116>   0) [suppressed in audit_alloc]
> 
> 117 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#117>   1) out of memory in audit_log_start [kmalloc of struct audit_buffer]
> 
> 118 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#118>   2) out of memory in audit_log_move [alloc_skb]
> 
> 119 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#119>   3) suppressed due to audit_rate_limit
> 
> 120 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#120>   4) suppressed due to audit_backlog_limit
> 
> 121 
> <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audi
> t.c#121>*/
> 
>  
> 
> So is this the root-cause of my issue ? How can I modify kernel code 
> to archieve my purpose or there already is a open/off switch to help 
> me on giving all the logs in one time test ?

(cc'ing seandroid-list as you later mentioned that you are encountering this in the context of Android, although I don't know if it is truly specific to Android)

Generally you should see audit_lost= log messages in dmesg if audit log messages were lost, although those are also subject to the printk ratelimit and could be suppressed.

One thing you can try is to disable the audit ratelimit, which in Android is set by system/core/logd/libaudit.c.  Just remove the AUDIT_STATUS_RATE_LIMIT flag from status.mask and don't bother setting status.rate_limit.

We also carry a patch in our kernel branches for Nexus devices that disables the printk ratelimit for audit messages. e.g.
https://bitbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929135babb1dbba272e27
