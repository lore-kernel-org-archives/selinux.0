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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D89C4332D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1012072C
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjY3eVRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgCSTFK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:05:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44884 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSTFJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:05:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id y24so2811048qtv.11;
        Thu, 19 Mar 2020 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vwHbNJGYUqnSYgAQsNv2iSkZHMRpiWsfpYk2YRWu8E=;
        b=QjY3eVRH1pJhrIt5lIIJa2vVfaib9ZkNGxKLz2k8ty2GH5e40BxK/WYqsE8sI1jwgD
         vUqypD1wFsukrzfkwcdEYO7uDIhEqq+HgPbXfP/yYg29iJl53E3tRl81lRvb4pFew8dg
         PmLqe8tRuJz/cmVvSFaqBKuyY98/7gEi/rMPg4XJss546Xm60d4yAh9c4Z2XeOyj9s2x
         u/Y9febGffXhIeBHgAVV96ahJshGQLpwbBbRsirEXG7rgvGHjHtH8Zp1x+Zv2hRqvJh8
         3GGbHFcYyAZkC6vGQp4o6DTZI2B5Pmz7YCmuoX+0/H7/OYzrk5pjJfNd89e4aGr0RD5n
         V1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vwHbNJGYUqnSYgAQsNv2iSkZHMRpiWsfpYk2YRWu8E=;
        b=FsqUzx259DARylc84D6ZTMyKUwIVM5qHQH01u/Hoa+bZUBZsN3wotNzjSBoQVWZvEG
         uIQqQjljfkQd8D88gABEqtfTH7RRn7TdQdtyCHW7sCFbdxh4JfcRbhZFaV56NCE64Lol
         WF/LF4zQB0jeSj0kS2W5navNN7x8YnWrHOrvQRi7aDySRkCDz+K5KzAEEZNLIiB49IIf
         J+yPcWhJI4OmPVBfPdVHCBzOq7HRWWdzAhS8foFMgJ7motlvz5TdGjaXRtTkZLuOBRRN
         KpEU/NbHS4BWbyJ36h0OS0vc98nIh3e/ptEVU+uSvrRlmXSFdHKmYn+isuUlEEyQoVp3
         H8IQ==
X-Gm-Message-State: ANhLgQ3JJcqrPlnKCc89ZKhkKg3M+R/2M5flP/GHSopW3zud5TKaAaZg
        0U4OL10pX4Lyrmei/WEyxEJqkO84XLs=
X-Google-Smtp-Source: ADFU+vtSPJsHEIzhjUJRhNzjDNGQzllL3aQYqQYpxvOngOHRk0gm/6qahP5rKaR4A2bsVE+xaFPDCQ==
X-Received: by 2002:ac8:7a96:: with SMTP id x22mr4784422qtr.0.1584644707237;
        Thu, 19 Mar 2020 12:05:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r6sm2114900qkf.71.2020.03.19.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:05:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65D4940F77; Thu, 19 Mar 2020 16:05:04 -0300 (-03)
Date:   Thu, 19 Mar 2020 16:05:04 -0300
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
Message-ID: <20200319190504.GG14841@kernel.org>
References: <b8a0669e-36e4-a0e8-fd35-3dbd890d2170@linux.intel.com>
 <f5ed60b2-4a61-dc72-bfd5-6d0af74bc152@linux.intel.com>
 <20200319190126.GF14841@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319190126.GF14841@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Thu, Mar 19, 2020 at 04:01:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Mar 19, 2020 at 09:23:30AM +0300, Alexey Budankov escreveu:
> > Is there any thougts, comments or questions so far?
> > Please share you mind.
 
> From a quick look, seems ok, I'll do some testing now,

> > On 13.03.2020 20:27, Alexey Budankov wrote:
> > > Extend Perf tool with the check of /sys/fs/selinux/enforce value and notify 
> > > in case access to perf_event_open() syscall is restricted by the enforced 
> > > SELinux policy settings.
> > > 
> > > Testing and evaluation (Fedora 31 x86_64 with enforced Targeted policy extended
> > > by perf_event class (see refpolicy [1] master branch)):

So I'll try the steps below with/without your patch, and then... what
are the steps that a tester needs to go thru to have that refpolicy in?
Install some new SELinux package or library, spelling out in detail the
steps one needs to go thru helps reviewing/testing,

- Arnaldo

> > > [root@host ~]# ps -Z
> > > LABEL                               PID TTY          TIME CMD
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 3960 pts/1 00:00:00 bash
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4167 pts/1 00:00:00 ps
> > > 
> > > [root@host ~]# ls -alhZ /usr/local/bin/
> > > total 56M
> > > drwxr-xr-x.  2 root root       system_u:object_r:bin_t:s0     4.0K Mar  4 12:27 .
> > > drwxr-xr-x. 12 root root       system_u:object_r:usr_t:s0     4.0K Jul 25  2019 ..
> > > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0     4.1M Jan 23  2017 bash
> > > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0     4.1M Jan 23  2017 bash.before_shellshock_patch
> > > ...
> > > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0      372 May 14  2019 flask
> > > -rwxr-xr-x.  1 root root       unconfined_u:object_r:bin_t:s0  24M Mar  4 12:15 perf     <== unprivileged users (perf_event_paranoid)
> > > -rwxr-x---.  1 root perf_users unconfined_u:object_r:bin_t:s0  24M Mar  4 12:19 perf.cap <== perf_users (CAP_SYS_ADMIN)
> > > -rwxr-xr-x.  1 root root       system_u:object_r:bin_t:s0      44K Dec  8  2016 spiff
> > > ...
> > > lrwxrwxrwx.  1 root root       system_u:object_r:bin_t:s0        4 Aug 21  2018 zstdmt -> zstd
> > > 
> > > [root@host ~]# getenforce
> > > Enforcing
> > > 
> > > === Access by unprivileged user ===
> > > 
> > > [user@host ~]$ ps -Z
> > > LABEL                               PID TTY          TIME CMD
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > > 
> > > [user@host ~]$ /usr/local/bin/perf stat -- ls
> > > Error:
> > > Access to performance monitoring and observability operations is limited.
> > > SELinux Enforcing mode is enabled and can limit access to performance
> > > monitoring and observability operations. Inspect system audit records
> > > for more perf_event access control information and adjusting the policy.
> > > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > > access to performance monitoring and observability operations for users
> > > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> > >   -1: Allow use of (almost) all events by all users
> > >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > >> = 0: Disallow raw and ftrace function tracepoint access
> > >> = 1: Disallow CPU event access
> > >> = 2: Disallow kernel profiling
> > > To make the adjusted perf_event_paranoid setting permanent preserve it
> > > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > > 
> > > [root@host ~]# journalctl --follow
> > > ... audit[4186]: AVC avc:  denied  { open } for  pid=4186 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > > ... audit[4186]: AVC avc:  denied  { open } for  pid=4186 comm="perf" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > > ... setroubleshoot[4194]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 9a6f3db2-3d8f-461e-afad-0b5c3a9c3b9d
> > > ... python3[4194]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
> > >                                           
> > >                                           *****  Plugin catchall (100. confidence) suggests   **************************
> > >                                           
> > >                                           If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
> > >                                           Then you should report this as a bug.
> > >                                           You can generate a local policy module to allow this access.
> > >                                           Do
> > >                                           allow this access for now by executing:
> > >                                           # ausearch -c 'perf' --raw | audit2allow -M my-perf
> > >                                           # semodule -X 300 -i my-perf.pp
> > >                                           
> > > === Access by perf privileged user ===
> > > 
> > > [user@host ~]$ ps -Z
> > > LABEL                               PID TTY          TIME CMD
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > > 
> > > [user@host ~]$ libcap/progs/getcap /usr/local/bin/perf.cap
> > > /usr/local/bin/perf.cap = cap_sys_ptrace,cap_syslog,cap_sys_admin+ep
> > > 
> > > [user@host ~]$ /usr/local/bin/perf.cap stat -- ls
> > > Error:
> > > Access to performance monitoring and observability operations is limited.
> > > SELinux Enforcing mode is enabled and can limit access to performance
> > > monitoring and observability operations. Inspect system audit records
> > > for more perf_event access control information and adjusting the policy.
> > > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > > access to performance monitoring and observability operations for users
> > > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> > >   -1: Allow use of (almost) all events by all users
> > >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > >> = 0: Disallow raw and ftrace function tracepoint access
> > >> = 1: Disallow CPU event access
> > >> = 2: Disallow kernel profiling
> > > To make the adjusted perf_event_paranoid setting permanent preserve it
> > > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > > 
> > > [root@host ~]# journalctl --follow
> > > 
> > > ... audit[3926]: AVC avc:  denied  { open } for  pid=3926 comm="perf.cap" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > > ... audit[3926]: AVC avc:  denied  { open } for  pid=3926 comm="perf.cap" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=perf_event permissive=0
> > > 
> > > ... setroubleshoot[3934]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t. For complete SELinux messages run: sealert -l 9a6f3db2-3d8f-461e-afad-0b5c3a9c3b9d
> > > ... python3[3934]: SELinux is preventing perf from open access on the perf_event labeled unconfined_t.
> > >                                           
> > >                                           *****  Plugin catchall (100. confidence) suggests   **************************
> > >                                           
> > >                                           If you believe that perf should be allowed open access on perf_event labeled unconfined_t by default.
> > >                                           Then you should report this as a bug.
> > >                                           You can generate a local policy module to allow this access.
> > >                                           Do
> > >                                           allow this access for now by executing:
> > >                                           # ausearch -c 'perf' --raw | audit2allow -M my-perf
> > >                                           # semodule -X 300 -i my-perf.pp
> > >                                           
> > > === Open access to performance monitoring and observability operations in unconfined_t domain ===
> > > 
> > > [root@host ~]# ausearch -c 'perf' --raw | audit2allow -M my-perf && cat my-perf.te
> > > 
> > > module my-perf 1.0;
> > > 
> > > require {
> > > 	type unconfined_t;
> > > 	class perf_event { cpu kernel open read tracepoint write };
> > > }
> > > 
> > > #============= unconfined_t ==============
> > > allow unconfined_t self:perf_event { cpu kernel open read tracepoint write };
> > > 
> > > [root@host ~]# semodule -X 300 -i my-perf.pp
> > > 
> > > [user@host ~]$ ps -Z
> > > LABEL                               PID TTY          TIME CMD
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4043 pts/2 00:00:00 bash
> > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 4168 pts/2 00:00:00 ps
> > > 
> > > [user@host ~]$ /usr/local/bin/perf stat -- ls
> > > Desktop  Documents  Downloads  intel  Music  perf.data	perf.data.old  Pictures  Public  Templates  Videos
> > > 
> > >  Performance counter stats for 'ls':
> > > 
> > >               0.72 msec task-clock:u              #    0.655 CPUs utilized          
> > >                  0      context-switches:u        #    0.000 K/sec                  
> > >                  0      cpu-migrations:u          #    0.000 K/sec                  
> > >                 98      page-faults:u             #    0.137 M/sec                  
> > >            908,356      cycles:u                  #    1.266 GHz                    
> > >            729,984      instructions:u            #    0.80  insn per cycle         
> > >            142,774      branches:u                #  198.968 M/sec                  
> > >              8,238      branch-misses:u           #    5.77% of all branches        
> > > 
> > >        0.001095239 seconds time elapsed
> > > 
> > >        0.001147000 seconds user
> > >        0.000000000 seconds sys
> > > 
> > > [user@host ~]$ /usr/local/bin/perf stat -a
> > > Error:
> > > Access to performance monitoring and observability operations is limited.
> > > SELinux Enforcing mode is enabled and can limit access to performance
> > > monitoring and observability operations. Inspect system audit records
> > > for more perf_event access control information and adjusting the policy.
> > > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > > access to performance monitoring and observability operations for users
> > > without CAP_SYS_ADMIN capability. perf_event_paranoid setting is -1:
> > >   -1: Allow use of (almost) all events by all users
> > >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > >> = 0: Disallow raw and ftrace function tracepoint access
> > >> = 1: Disallow CPU event access
> > >> = 2: Disallow kernel profiling
> > > To make the adjusted perf_event_paranoid setting permanent preserve it
> > > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> > > 
> > > [user@host ~]$ /usr/local/bin/perf.cap stat -a
> > > ^C
> > >  Performance counter stats for 'system wide':
> > > 
> > >          13,427.05 msec cpu-clock                 #    7.997 CPUs utilized          
> > >                783      context-switches          #    0.058 K/sec                  
> > >                 29      cpu-migrations            #    0.002 K/sec                  
> > >                  6      page-faults               #    0.000 K/sec                  
> > >        161,084,874      cycles                    #    0.012 GHz                    
> > >        146,823,131      instructions              #    0.91  insn per cycle         
> > >         12,164,802      branches                  #    0.906 M/sec                  
> > >            380,350      branch-misses             #    3.13% of all branches        
> > > 
> > >        1.678938906 seconds time elapsed
> > > 
> > > [1] https://github.com/SELinuxProject/refpolicy
> > > 
> > > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > > ---
> > >  tools/perf/util/cloexec.c |  4 ++--
> > >  tools/perf/util/evsel.c   | 40 +++++++++++++++++++++++----------------
> > >  2 files changed, 26 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> > > index a12872f2856a..9c8ec816261b 100644
> > > --- a/tools/perf/util/cloexec.c
> > > +++ b/tools/perf/util/cloexec.c
> > > @@ -65,7 +65,7 @@ static int perf_flag_probe(void)
> > >  		return 1;
> > >  	}
> > >  
> > > -	WARN_ONCE(err != EINVAL && err != EBUSY,
> > > +	WARN_ONCE(err != EINVAL && err != EBUSY && err != EACCES,
> > >  		  "perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error %d (%s)\n",
> > >  		  err, str_error_r(err, sbuf, sizeof(sbuf)));
> > >  
> > > @@ -83,7 +83,7 @@ static int perf_flag_probe(void)
> > >  	if (fd >= 0)
> > >  		close(fd);
> > >  
> > > -	if (WARN_ONCE(fd < 0 && err != EBUSY,
> > > +	if (WARN_ONCE(fd < 0 && err != EBUSY && err != EACCES,
> > >  		      "perf_event_open(..., 0) failed unexpectedly with error %d (%s)\n",
> > >  		      err, str_error_r(err, sbuf, sizeof(sbuf))))
> > >  		return -1;
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 816d930d774e..f03ce1d362d3 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2493,32 +2493,40 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
> > >  			      int err, char *msg, size_t size)
> > >  {
> > >  	char sbuf[STRERR_BUFSIZE];
> > > -	int printed = 0;
> > > +	int printed = 0, enforced = 0;
> > >  
> > >  	switch (err) {
> > >  	case EPERM:
> > >  	case EACCES:
> > > +		printed += scnprintf(msg + printed, size - printed,
> > > +			"Access to performance monitoring and observability operations is limited.\n");
> > > +
> > > +		if (!sysfs__read_int("fs/selinux/enforce", &enforced)) {
> > > +			if (enforced) {
> > > +				printed += scnprintf(msg + printed, size - printed,
> > > +					"SELinux Enforcing mode is enabled and can limit access to performance\n"
> > > +					"monitoring and observability operations. Inspect system audit records\n"
> > > +					"for more perf_event access control information and adjusting the policy.\n");
> > > +			}
> > > +		}
> > > +
> > >  		if (err == EPERM)
> > > -			printed = scnprintf(msg, size,
> > > -				"No permission to enable %s event.\n\n",
> > > +			printed += scnprintf(msg, size,
> > > +				"No permission to enable %s event.\n",
> > >  				perf_evsel__name(evsel));
> > >  
> > >  		return scnprintf(msg + printed, size - printed,
> > > -		 "You may not have permission to collect %sstats.\n\n"
> > > -		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
> > > -		 "which controls use of the performance events system by\n"
> > > -		 "unprivileged users (without CAP_SYS_ADMIN).\n\n"
> > > -		 "The current value is %d:\n\n"
> > > +		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
> > > +		 "access to performance monitoring and observability operations for users\n"
> > > +		 "without CAP_SYS_ADMIN capability. perf_event_paranoid setting is %d:\n"
> > >  		 "  -1: Allow use of (almost) all events by all users\n"
> > >  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
> > > -		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN\n"
> > > -		 "      Disallow raw tracepoint access by users without CAP_SYS_ADMIN\n"
> > > -		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
> > > -		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
> > > -		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
> > > -		 "	kernel.perf_event_paranoid = -1\n" ,
> > > -				 target->system_wide ? "system-wide " : "",
> > > -				 perf_event_paranoid());
> > > +		 ">= 0: Disallow raw and ftrace function tracepoint access\n"
> > > +		 ">= 1: Disallow CPU event access\n"
> > > +		 ">= 2: Disallow kernel profiling\n"
> > > +		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
> > > +		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
> > > +		 perf_event_paranoid());
> > >  	case ENOENT:
> > >  		return scnprintf(msg, size, "The %s event is not supported.",
> > >  				 perf_evsel__name(evsel));
> > > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
