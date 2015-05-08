Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t48DViK1018311
 for <selinux@tycho.nsa.gov>; Fri, 8 May 2015 09:31:44 -0400
Received: by oiko83 with SMTP id o83so58466393oik.1
 for <selinux@tycho.nsa.gov>; Fri, 08 May 2015 06:31:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554CB2A1.4030402@tycho.nsa.gov>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
 <554A06E8.8030202@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
 <554B61DB.1030103@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66612A3FE0@SC-VEXCH4.marvell.com>
 <554CB2A1.4030402@tycho.nsa.gov>
Date: Fri, 8 May 2015 09:31:43 -0400
Message-ID: <CAHC9VhQ3Wm2kGzHe7o2sEE5SWNyMLvMid-g048uMz+twE2-v9w@mail.gmail.com>
Subject: Re: Give out all the avc logs in ome time
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 8, 2015 at 8:57 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/08/2015 04:46 AM, Zhi Xin wrote:
>> Thanks for details information!
>>
>> For the switch question, I get your point. logd.auditd is the switch of whether logd can record selinux audit log. But I'm looking for the switch of ratelimit. I mean, removing ratelimit is really helpful for selinux debugging, especially in bringup stage. But meanwhile, removing it just opens the gate for potential DOS. So should we have a simple command that can disable ratelimit during bringup debugging and enable it for release. Just like we can switch to permissive mode by setenforce 0.
>
> For this, you'd need an audit boot parameter in order to fully disable
> the printk ratelimit even before logd starts.  So it would require a
> kernel patch to define such a parameter.  There are existing audit boot
> parameters for enabling/disabling audit (audit=0|1) and for setting the
> backlog limit (audit_backlog_limit=N).  Those are defined in
> kernel/audit.c via __setup() calls.  You could add an audit_ratelimit=N
> and/or an audit_printk_ratelimit=0|1 boot parameters.

For the record, I don't have a problem with accepting a patch that
added a boot parameter to control the audit ratelimit.

-- 
paul moore
www.paul-moore.com
