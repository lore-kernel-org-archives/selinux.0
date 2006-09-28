Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SEZEpZ018777
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 10:35:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8SEY8oX018496
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:34:09 GMT
Subject: Re: Latest diffs.  Trimmed down this time.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45183220.8090106@redhat.com>
References: <45183220.8090106@redhat.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 10:36:17 -0400
Message-Id: <1159454177.2850.9.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2006-09-25 at 15:46 -0400, Daniel J Walsh wrote:
> Corrected oddjob policy

The mkhomedir policy looks incomplete.

fixed the stray 

domain_auto_trans(unconfined_t,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)

in the module.

> Doesn't ssh need
> +       userdom_search_all_users_home_dirs(sshd_t)

See my response to Erich.

> Cups init script wants to clear the error_log

Does initrc_t need read on this still?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
