Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i58GujrT013520
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 12:56:45 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i58GugIl026972
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 12:56:42 -0400 (EDT)
Subject: Re: How to handle tmpfiles under /home ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040607234412.GB2073@jmh.mhn.de>
References: <20040607234412.GB2073@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1086713793.32646.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 08 Jun 2004 12:56:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-07 at 19:44, Thomas Bleher wrote:
> I recently ran into a problem with tmpfiles in my homedir. I have
> configured mutt to store mails I write under ~/.mutt/tmp/.
> Unfortunately, current policy only allows postfix to read user_tmp_t.
> This leads to postfix sending totally empty mails in enforcing mode.
<snip>
> My next thought was to label say ~/.tmp/ as user_tmp_t and point $TMP
> there. Unfortunately there is no standard directory across distros for
> this.
> Ideally this should be configurable by the user, but I'm not sure if
> it's worth the trouble.
> 
> As I am not sure what the best thing to do is both practically and from
> a security POV I am posting this here.

Better to put the mail client into its own domain (which is also a good
idea for confining flawed mail clients), and define its own derived type
for files it creates.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
