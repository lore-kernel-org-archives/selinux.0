Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB31tXiG025958
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 20:55:35 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB31rngv015917
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 01:53:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 37B5AC4C08E
	for <selinux@tycho.nsa.gov>; Sun,  3 Dec 2006 02:55:58 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 29255-05 for <selinux@tycho.nsa.gov>;
	Sun, 3 Dec 2006 02:55:57 +0100 (CET)
Received: from hepcat.vitavonni.de (p57AE5724.dip.t-dialin.net [87.174.87.36])
	by legolas.drinsama.de (Postfix) with ESMTP id 20605C4C083
	for <selinux@tycho.nsa.gov>; Sun,  3 Dec 2006 02:55:56 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hepcat.vitavonni.de (Postfix) with ESMTP id 1261142819B
	for <selinux@tycho.nsa.gov>; Sun,  3 Dec 2006 02:55:53 +0100 (CET)
Subject: root home directory and system cron jobs
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 03 Dec 2006 02:55:51 +0100
Message-Id: <1165110951.19409.8.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
every now and then, system cron jobs will try to access /root
(as this is the $HOME for the root user)

However since that dir usually is labeled sysadm_r, it will generate an
audit error, and that is actually intended.

Does anyone have a good proposal on handling this issue?
Maybe using something like HOME=/var/lib/system-cron-home in all system
cron jobs? Any FHS information on that?

Apart from the SELinux issues, I believe that there are a couple of odd
bugs that can be triggered by setting up weird dotfiles in /root on
non-SELinux-systems. For example a cronjob using wget to download some
files can probably be broken by setting up a non-working proxy
in /root/.wgetrc

Also some cronjobs will try to use "su" to switch to a different userid.
(e.g. the amavisd-new cronjob to do maintainance on the spamassassin
bayes database); some might be able to be rewritten to use the other
userid directly, but some might not...
(e.g. because they're installed in /etc/cron.daily, which doesn't use
the cronjob syntax but is just a collection of shell scripts; they need
to use su to switch to a different user)

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Why waste time learning, when ignorance is instantaneous? --- Calvin //\
          Humor sollte immmer dabeisein, auch bei Problemen.          V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
