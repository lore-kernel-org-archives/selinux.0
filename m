Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9EKOJrT001279
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 16:24:19 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9EKN7mT005796
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 20:23:07 GMT
Subject: Re: policy compile fixes
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041014113536.GC2540@jmh.mhn.de>
References: <20041014113536.GC2540@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1097785396.32077.92.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 16:23:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with the exception of the cups.fc stuff.

Currently, the policy Makefile is not set up so that the fc files can
use an ifdef(`somefile.te',

If there is interest in adding that support though, it can be done.

On Thu, 2004-10-14 at 07:35, Thomas Bleher wrote:
> This patch fixes a few compile problems with latest policy:
>         consoletype.te: firstboot.te may not be there
>         cups.fc: cupsd_config only exists if hald.te is available
>         apache_macros.te: allow_ypbind is only declared if ypbind.te is
>                           available
> 
> Add a few file_contexts.
> 
> Conditionalize the file_type_auto_trans rule in apache.te, otherwise log
> files get created with the wrong context.
> 
> Add can_exec($1_ssh_t, { shell_exec_t bin_t }), it is needed for some
> programs like x11-ssh-askpass (and I suspect sftp_server).
> 
> Please apply.
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
