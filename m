Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA11951
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 03:24:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA10677
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 07:22:18 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id HAA10673 for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 07:22:17 GMT
Date: Wed, 2 Oct 2002 09:24:04 +0200
From: Tom <tom@lemuria.org>
To: Tracy R Reed <treed@ultraviolet.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002092404.B4475@lemuria.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org> <20021001235017.B28686@ultraviolet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021001235017.B28686@ultraviolet.org>; from treed@ultraviolet.org on Tue, Oct 01, 2002 at 11:50:17PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 11:50:17PM -0700, Tracy R Reed wrote:
> It seemed like make relabel would be a good idea to ensure everything is
> labelled properly after all of the messing around I have done and I got
> this:

Absolutely, yes. You should relabel twice: Once before rebooting into
the SELinux kernel, once after (to label the files created during
shutdown and boot).


> home:/etc/selinux# make relabel
> /usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]|reiserfs)/{print $3}'`
> /usr/sbin/setfiles:  Running on a SELinux kernel, using new system calls /usr/sbin/setfiles:  read 767 specifications
> /usr/sbin/setfiles:  invalid context system_u:object_r:home_root_t on line number 86
> /usr/sbin/setfiles:  invalid context system_u:object_r:games_exec_t on line number 616
> /usr/sbin/setfiles:  invalid context system_u:object_r:var_log_inetd_t on line number 647
> /usr/sbin/setfiles:  invalid context system_u:object_r:rndc_conf_t on line number 759
> /usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on line number 995
> /usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on line number 996
> /usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on line number 997
> /usr/sbin/setfiles:  invalid context system_u:object_r:useradd_exec_t on line number 998
> /usr/sbin/setfiles:  invalid context system_u:object_r:vmware_user_conf_t on line number 1053
> /usr/sbin/setfiles:  invalid context system_u:object_r:xauth_exec_t on line number 1058
> make: *** [relabel] Error 1

I've seen these during my yesterday burnout, too. Check if your loaded
policy, policy on disk and kernel all match in versions. Did it load
the policy correctly? Try make load again. Also, I think you can delete
the /etc/selinux/file_contexts/file_contexts file since it should be
created from the .fc files.
Also, when you remove .te files, don't forget to remove the
corresponding .fc files, too.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
