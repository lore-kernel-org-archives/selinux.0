Message-ID: <5548C89D.2020601@tycho.nsa.gov>
Date: Tue, 05 May 2015 09:41:49 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Zhi Xin <xinzhi@marvell.com>, Gaurav Gangwar <gauravgangwaar@gmail.com>
Subject: Re: Give out all the avc logs in ome time
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
 <CACikiw07wGq+Pp_QjnXnUAhHsBe48X4Kpr25MzJyB5Xby_gQ9g@mail.gmail.com>
 <F766E4F80769BD478052FB6533FA745D66611C40DE@SC-VEXCH4.marvell.com>
 <CA+XqU8iaVZZM5Z2fwDMBtJeMS3OV4dQh797BTTQ8b91SOh-9Ew@mail.gmail.com>
 <F766E4F80769BD478052FB6533FA745D66611C4124@SC-VEXCH4.marvell.com>
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66611C4124@SC-VEXCH4.marvell.com>
Content-Type: text/plain; charset=windows-1252
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/2015 04:55 AM, Zhi Xin wrote:
> (1)  avc size
> 
> I’m reading the code under
> 
> /kernel/security/selinux/avc.c
> 
>  
> 
> I noticed that there are some macro like
> 
> #define      AVC_DEF_CACHE_THRESHOLD              512
> 
> #define      AVC_CACHE_SLOTS                                    512
> 
>  
> 
> Are they some kind of threshold ? If the size of avc log reported is
> bigger than that, new avc will be abandoned ?

No, that has nothing to do with auditing.  Just the size of the cache.

> (2) audit subsystem may drop some record when it’s satisfied with some
> condition like
> 
>  
> 
> /kernel/kernel/audit.c
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
> 121 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#121>*/
> 
>  
> 
> Any comments on these two ? 

Yes, one of the above cases is the most likely reason you are losing
audit messages.  You can set the audit_rate_limit to zero to disable
ratelimiting of audit messages by removing the code from
system/core/logd/libaudit.c that sets it.  You could set the
audit_backlog_limit to zero either by patching your kernel or by
modifying logd to set it.  You can patch your kernel to disable
printk_ratelimit from being applied when sending audit messages to the
kernel ring buffer.
