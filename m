Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC920C4332B
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744522072C
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQh2PNeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSTBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:01:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39724 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSTBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:01:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id t17so4298899qkm.6;
        Thu, 19 Mar 2020 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFB+lzHCbE1DK5By9Y3xZlY01purzz7hc00dVLSCdts=;
        b=mQh2PNehvZflK4zfunz9/MHov+oI/e5y57/TeoydeNxDs9PKjHIJ1LNged0zPaMQUX
         HX33EgqNYPa6etcpmLbBmN03z4TmzS2ICamPDRJhwWY7rUSCyDpSq+XP8IpwCTIoX81v
         n7q4KKfX2WuZh2C4vNTmEwpitCFY1IuyRwCITyxgEHY/ikFqH0Qb81RDWEd04DtCXKK4
         Ri/RxR7g4Uepeti8YNnzs57ZmTDnlja4Q3rY8Iuc15RrhA3+B84GOV3Pk02PP5VL+FU2
         +1S/mIa0Fy/W7paAyKFsXCRYVZdJg4Jd0A5SDf2iyBNMwbFuWFTfjCYgZ5eSoUc7iVCc
         wEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFB+lzHCbE1DK5By9Y3xZlY01purzz7hc00dVLSCdts=;
        b=E0nIqut64Ue8g0JuYv4ubwqlGbv7YDmpC/UttKnE6OE0sBH4Oo0ZKIyLdB1xXgL0lX
         YXsBcTyWI30/ecDyVZJukstWtLnufb9j+o/KN7LVnyW5jcMh8GduvA098QxO2cnXkU/k
         qtYtGeS770GnSvrgHgRA9pz2yaPQtlWZTFP0UshDhM35UtiFb6EsGkklRrGaY+NxWjWf
         Io7E5NUsX5XEtYrn9rO0frHwrc47qI0ssOoORQFGqMBbVcS1OvdKM61PAISLjgVYWuz4
         L6a/t5O6pmT9uim2zEPtLq9fLLogsIYKnH9F289RscxmBgfbcXYvoDxvIG4Fcp9coQlY
         SR5w==
X-Gm-Message-State: ANhLgQ1VYos0wUK73dKT3WJ1NBI48bVcU4tzloHASPe+ytgKxQhI6zXU
        BqGEurqT0ol6+NN0h1SlPUiGjYFjkow=
X-Google-Smtp-Source: ADFU+vuDjvde6TTCEQ2RVIz9GA3O/a7oAtGOFWTZsflrVCxYc3WPHF5l5vrJ9kB7aFt+rjLmDt91wQ==
X-Received: by 2002:a37:a057:: with SMTP id j84mr4543212qke.108.1584644489501;
        Thu, 19 Mar 2020 12:01:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p38sm2384495qtf.50.2020.03.19.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:01:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71B4740F77; Thu, 19 Mar 2020 16:01:26 -0300 (-03)
Date:   Thu, 19 Mar 2020 16:01:26 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1] perf tool: make Perf tool aware of SELinux access
 control
Message-ID: <20200319190126.GF14841@kernel.org>
References: <b8a0669e-36e4-a0e8-fd35-3dbd890d2170@linux.intel.com>
 <f5ed60b2-4a61-dc72-bfd5-6d0af74bc152@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ed60b2-4a61-dc72-bfd5-6d0af74bc152@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Thu, Mar 19, 2020 at 09:23:30AM +0300, Alexey Budankov escreveu:
> Hi,
> 
> Is there any thougts, comments or questions so far?
> Please share you mind.

From a quick look, seems ok, I'll do some testing now,

- Arnaldo
 
> Thanks,
> Alexey
> 
> On 13.03.2020 20:27, Alexey Budankov wrote:
> > 
> > Extend Perf tool with the check of /sys/fs/selinux/enforce value and notify 
> > in case access to perf_event_open() syscall is restricted by the enforced 
> > SELinux policy settings.
> > 
> > Testing and evaluation (Fedora 31 x86_64 with enforced Targeted policy extended
> > by perf_event class (see refpolicy [1] master branch)):
> > 
> > [root@host ~]# ps -Z
> > LABEL                               PID TTY          TIME CMD
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 3960 pts/1 00:00:00 bash
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4167 pts/1 00:00:00 ps
> > 
> > [root@host ~]# ls -alhZ /usr/local/bin/
> > total 56M
> > drwxr-xr-x.  2 root root       system_u:object_r:bin_t:s0     4.0K Mar  4 12:27 .
> > drwxr-xr-x. 12 root root       system_u:object_r:usr_t:s0     4.0K Jul 25  2019 ..
> > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0     4.1M Jan 23  2017 bash
> > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0     4.1M Jan 23  2017 bash.before_shellshock_patch
> > ...
> > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0      372 May 14  2019 flask
> > -rwxr-xr-x.  1 root root       unconfined_u:object_r:bin_t:s0  24M Mar  4 12:15 perf     <== unprivileged users (perf_event_paranoid)
> > -rwxr-x---.  1 root perf_users unconfined_u:object_r:bin_t:s0  24M Mar  4 12:19 perf.cap <== perf_users (CAP_SYS_ADMIN)
> > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0      44K Dec  8  2016 spiff
> > ...
> > lrwxrwxrwx.  1 root root       system_u:object_r:bin_t:s0        4 Aug 21  2018 zstdmt -> zstd
> > 
> > [root@host ~]# getenforce
> > Enforcing
> > 
> > === Access by unprivileged user ===
> > 
> > [user@host ~]$ ps -Z
> > LABEL                               PID TTY          TIME CMD
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > 
> > [user@host ~]$ /usr/local/bin/perf stat -- ls
> > Error:
> > Access to performance monitoring and observability operations is limited.
> > SELinux Enforcing mode is enabled and can limit access to performance
> > monitoring and observability operations. Inspect system audit records
> > for more perf_event access control information and adjusting the policy.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for users
> > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> >   -1: Allow use of (almost) all events by all users
> >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> = 0: Disallow raw and ftrace function tracepoint access
> >> = 1: Disallow CPU event access
> >> = 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > 
> > [root@host ~]# journalctl --follow
> > ... audit[4186]: AVC avc:  denied  { open } for  pid=4186 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > ... audit[4186]: AVC avc:  denied  { open } for  pid=4186 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > ... setroubleshoot[4194]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 9a6f3db2-3d8f-461e-afad-0b5c3a9c3b9d
> > ... python3[4194]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
> >                                           
> >                                           *****  Plugin catchall (100. confidence) suggests   **************************
> >                                           
> >                                           If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
> >                                           Then you should report this as a bug.
> >                                           You can generate a local policy module to allow this access.
> >                                           Do
> >                                           allow this access for now by executing:
> >                                           # ausearch -c 'perf' --raw | audit2allow -M my-perf
> >                                           # semodule -X 300 -i my-perf.pp
> >                                           
> > === Access by perf privileged user ===
> > 
> > [user@host ~]$ ps -Z
> > LABEL                               PID TTY          TIME CMD
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > 
> > [user@host ~]$ libcap/progs/getcap /usr/local/bin/perf.cap
> > /usr/local/bin/perf.cap = cap_sys_ptrace,cap_syslog,cap_sys_admin+ep
> > 
> > [user@host ~]$ /usr/local/bin/perf.cap stat -- ls
> > Error:
> > Access to performance monitoring and observability operations is limited.
> > SELinux Enforcing mode is enabled and can limit access to performance
> > monitoring and observability operations. Inspect system audit records
> > for more perf_event access control information and adjusting the policy.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for users
> > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> >   -1: Allow use of (almost) all events by all users
> >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> = 0: Disallow raw and ftrace function tracepoint access
> >> = 1: Disallow CPU event access
> >> = 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > 
> > [root@host ~]# journalctl --follow
> > 
> > ... audit[3926]: AVC avc:  denied  { open } for  pid=3926 comm="perf.cap" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > ... audit[3926]: AVC avc:  denied  { open } for  pid=3926 comm="perf.cap" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > 
> > ... setroubleshoot[3934]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 9a6f3db2-3d8f-461e-afad-0b5c3a9c3b9d
> > ... python3[3934]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
> >                                           
> >                                           *****  Plugin catchall (100. confidence) suggests   **************************
> >                                           
> >                                           If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
> >                                           Then you should report this as a bug.
> >                                           You can generate a local policy module to allow this access.
> >                                           Do
> >                                           allow this access for now by executing:
> >                                           # ausearch -c 'perf' --raw | audit2allow -M my-perf
> >                                           # semodule -X 300 -i my-perf.pp
> >                                           
> > === Open access to performance monitoring and observability operations in unconfined_t domain ===
> > 
> > [root@host ~]# ausearch -c 'perf' --raw | audit2allow -M my-perf && cat my-perf.te
> > 
> > module my-perf 1.0;
> > 
> > require {
> > 	type unconfined_t;
> > 	class perf_event { cpu kernel open read tracepoint write };
> > }
> > 
> > #============= unconfined_t ==============
> > allow unconfined_t self:perf_event { cpu kernel open read tracepoint write };
> > 
> > [root@host ~]# semodule -X 300 -i my-perf.pp
> > 
> > [user@host ~]$ ps -Z
> > LABEL                               PID TTY          TIME CMD
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > 
> > [user@host ~]$ /usr/local/bin/perf stat -- ls
> > Desktop  Documents  Downloads  intel  Music  perf.data	perf.data.old  Pictures  Public  Templates  Videos
> > 
> >  Performance counter stats for 'ls':
> > 
> >               0.72 msec task-clock:u              #    0.655 CPUs utilized          
> >                  0      context-switches:u        #    0.000 K/sec                  
> >                  0      cpu-migrations:u          #    0.000 K/sec                  
> >                 98      page-faults:u             #    0.137 M/sec                  
> >            908,356      cycles:u                  #    1.266 GHz                    
> >            729,984      instructions:u            #    0.80  insn per cycle         
> >            142,774      branches:u                #  198.968 M/sec                  
> >              8,238      branch-misses:u           #    5.77% of all branches        
> > 
> >        0.001095239 seconds time elapsed
> > 
> >        0.001147000 seconds user
> >        0.000000000 seconds sys
> > 
> > [user@host ~]$ /usr/local/bin/perf stat -a
> > Error:
> > Access to performance monitoring and observability operations is limited.
> > SELinux Enforcing mode is enabled and can limit access to performance
> > monitoring and observability operations. Inspect system audit records
> > for more perf_event access control information and adjusting the policy.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for users
> > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> >   -1: Allow use of (almost) all events by all users
> >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> = 0: Disallow raw and ftrace function tracepoint access
> >> = 1: Disallow CPU event access
> >> = 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > 
> > [user@host ~]$ /usr/local/bin/perf.cap stat -a
> > ^C
> >  Performance counter stats for 'system wide':
> > 
> >          13,427.05 msec cpu-clock                 #    7.997 CPUs utilized          
> >                783      context-switches          #    0.058 K/sec                  
> >                 29      cpu-migrations            #    0.002 K/sec                  
> >                  6      page-faults               #    0.000 K/sec                  
> >        161,084,874      cycles                    #    0.012 GHz                    
> >        146,823,131      instructions              #    0.91  insn per cycle         
> >         12,164,802      branches                  #    0.906 M/sec                  
> >            380,350      branch-misses             #    3.13% of all branches        
> > 
> >        1.678938906 seconds time elapsed
> > 
> > [1] https://github.com/SELinuxProject/refpolicy
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > ---
> >  tools/perf/util/cloexec.c |  4 ++--
> >  tools/perf/util/evsel.c   | 40 +++++++++++++++++++++++----------------
> >  2 files changed, 26 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> > index a12872f2856a..9c8ec816261b 100644
> > --- a/tools/perf/util/cloexec.c
> > +++ b/tools/perf/util/cloexec.c
> > @@ -65,7 +65,7 @@ static int perf_flag_probe(void)
> >  		return 1;
> >  	}
> >  
> > -	WARN_ONCE(err != EINVAL && err != EBUSY,
> > +	WARN_ONCE(err != EINVAL && err != EBUSY && err != EACCES,
> >  		  "perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error %d (%s)\n",
> >  		  err, str_error_r(err, sbuf, sizeof(sbuf)));
> >  
> > @@ -83,7 +83,7 @@ static int perf_flag_probe(void)
> >  	if (fd >= 0)
> >  		close(fd);
> >  
> > -	if (WARN_ONCE(fd < 0 && err != EBUSY,
> > +	if (WARN_ONCE(fd < 0 && err != EBUSY && err != EACCES,
> >  		      "perf_event_open(..., 0) failed unexpectedly with error %d (%s)\n",
> >  		      err, str_error_r(err, sbuf, sizeof(sbuf))))
> >  		return -1;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 816d930d774e..f03ce1d362d3 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2493,32 +2493,40 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
> >  			      int err, char *msg, size_t size)
> >  {
> >  	char sbuf[STRERR_BUFSIZE];
> > -	int printed = 0;
> > +	int printed = 0, enforced = 0;
> >  
> >  	switch (err) {
> >  	case EPERM:
> >  	case EACCES:
> > +		printed += scnprintf(msg + printed, size - printed,
> > +			"Access to performance monitoring and observability operations is limited.\n");
> > +
> > +		if (!sysfs__read_int("fs/selinux/enforce", &enforced)) {
> > +			if (enforced) {
> > +				printed += scnprintf(msg + printed, size - printed,
> > +					"SELinux Enforcing mode is enabled and can limit access to performance\n"
> > +					"monitoring and observability operations. Inspect system audit records\n"
> > +					"for more perf_event access control information and adjusting the policy.\n");
> > +			}
> > +		}
> > +
> >  		if (err == EPERM)
> > -			printed = scnprintf(msg, size,
> > -				"No permission to enable %s event.\n\n",
> > +			printed += scnprintf(msg, size,
> > +				"No permission to enable %s event.\n",
> >  				perf_evsel__name(evsel));
> >  
> >  		return scnprintf(msg + printed, size - printed,
> > -		 "You may not have permission to collect %sstats.\n\n"
> > -		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
> > -		 "which controls use of the performance events system by\n"
> > -		 "unprivileged users (without CAP_SYS_ADMIN).\n\n"
> > -		 "The current value is %d:\n\n"
> > +		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
> > +		 "access to performance monitoring and observability operations for users\n"
> > +		 "without CAP_SYS_ADMIN capability. perf_event_paranoid setting is %d:\n"
> >  		 "  -1: Allow use of (almost) all events by all users\n"
> >  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
> > -		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN\n"
> > -		 "      Disallow raw tracepoint access by users without CAP_SYS_ADMIN\n"
> > -		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
> > -		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
> > -		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
> > -		 "	kernel.perf_event_paranoid = -1\n" ,
> > -				 target->system_wide ? "system-wide " : "",
> > -				 perf_event_paranoid());
> > +		 ">= 0: Disallow raw and ftrace function tracepoint access\n"
> > +		 ">= 1: Disallow CPU event access\n"
> > +		 ">= 2: Disallow kernel profiling\n"
> > +		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
> > +		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
> > +		 perf_event_paranoid());
> >  	case ENOENT:
> >  		return scnprintf(msg, size, "The %s event is not supported.",
> >  				 perf_evsel__name(evsel));
> > 

-- 

- Arnaldo
