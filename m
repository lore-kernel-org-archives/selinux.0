Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA14561
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 20:43:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA16366
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 00:42:55 GMT
Received: from web40010.mail.yahoo.com (web40010.mail.yahoo.com [66.218.78.28])
	by jazzswing.ncsc.mil  with SMTP id AAA16362
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 00:42:54 GMT
Message-ID: <20020626004319.69515.qmail@web40010.mail.yahoo.com>
Date: Tue, 25 Jun 2002 17:43:19 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Configuration issues on a new installation
To: SELinux Mailinglist <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everyone,

     I have just started using SELinux on my 2.4.18 system. I found an enormous
number of avc: denied messages in my dmesg and attempted to remove them. So far
I have tweaked the devfs_contexts and the policy.conf files (using
scripts/newrules.pl for policy.conf) since most of the errors were related to
device files and system call commands. I have also installed the SELinux devfsd
extension and added the config entries to my devfsd.conf, to no apparent avail.

     What is the fastest way to eliminate most (if not preferably all) of these
messages and put me closer to activating enforcing mode?

Thanks,

Brad Chapman

=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
