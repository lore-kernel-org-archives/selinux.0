Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13466
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 09:43:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05179
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:42:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA05175 for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:41:59 GMT
Date: Fri, 1 Nov 2002 09:42:55 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: <azeredo@qmc.ufsc.br>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems with policy in RH8
In-Reply-To: <Pine.LNX.4.33.0211011219430.2804-100000@quark.qmc.ufsc.br>
Message-ID: <Pine.LNX.4.33.0211010930310.16058-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Nov 2002 azeredo@qmc.ufsc.br wrote:

>
>
>   I saw at the  mail list someone was trying to get selinux to run in RH8.
> I am trying too. And got many audit messages. The first one was:
>
> avc: denied  {execute} for pid=9 exe=/bin/bash
> path=/lib/libnss_files-2.2.93.so dev=16:01 ino=159491
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:obeject_r:var_spool_t tclass=file
>

  It looks like the file '/lib/libnss_files-2.2.93.so' is labeled
incorrectly. Did you rerun 'make relabel' as shown in step 16 of the
README after booting into SELinux?

  If you look at the policy/file_contexts/types.fc, you'll see the
specification for labeling /lib, and that file should be labeled as
system_u:object_r:shlib_t.

  We have run SELinux with RH8.

-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
