Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8IDVrhg026714
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 09:31:53 -0400
Subject: Re: http process running as initrc_t
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
References: <CA+=dQ-95Sob03WHZzjvJiiYS3RnaqB+1O2iGg7YHW5CpGd0_WA@mail.gmail.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <55FC1245.6040408@redhat.com>
Date: Fri, 18 Sep 2015 15:31:49 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <CA+=dQ-95Sob03WHZzjvJiiYS3RnaqB+1O2iGg7YHW5CpGd0_WA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2015 10:31 PM, Divya Vyas wrote:
> Hi,
> 
> run_init /usr/sbin/httpd -k start
> 
> leads to
> system_u:system_r:initrc_t:s0   root      3977     1  0 19:57 ?       
> 00:00:00 /usr/sbin/httpd -k start


Which is correct. run_init runs a script with a context defined in
/etc/selinux/POLICYTYPE/contexts/initrc_context. So if you run it
directly this way, you get httpd_t running as initrc_t according to
/etc/selinux/POLICYTYPE/contexts/initrc_context.

You should run it using a service script to make sure all proper
transitions will happen.


> 
> It should be httpd_t
> 
> sesearch -ACT -t httpd_exec_t has the transition
> type_transition initrc_t httpd_exec_t : process httpd_t;
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
