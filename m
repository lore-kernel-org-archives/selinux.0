Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09288
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 10:28:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22393
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:27:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA22389
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:27:24 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Henrique de Moraes Holschuh <hmh@debian.org>,
        Thibault GODOUET <fcron@free.fr>
Subject: Security settings for fcron
Date: Mon, 5 Aug 2002 16:28:03 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020805142804.4209A120@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have written a patch for fcron to add SE Linux support.  This patch makes 
it check the security type label on crontab files to ensure that they are of 
a suitable type for the cron job in question (IE if an administrator 
accidentally makes your crontab file writable by someone else then the cron 
job will not run [1]).  It also makes the cron jobs run in the correct 
identity, role, and domain (so that your cron jobs get the same security 
limitations as your login sessions).

I have not published the patches yet because they still don't work properly 
(but I would be happy to send them privately to anyone who wants to look at 
them - especially the fcron people to make sure that I'm not doing anything 
silly).

One problem that I am having is determining the distinction between system 
cron jobs and system-administrator cron jobs.

System cron jobs are those such as the /etc/cron.{daily,weekly,monthly} jobs 
in Debian.  They are provided as part of the OS to maintain applications, and 
they are designed to run as the identity "system_u", as the role "system_r", 
and the domain "system_crond_t" giving the context 
system_u:system_r:system_crond_t.  Cron jobs applied by the administrator via 
"fcrontab -e" should be run in the same fashion as regular cron jobs applied 
by "crontab -e", in the context "root:sysadm_r:sysadm_crond_t".

The code to put the cron job in the correct domain is trivial.  For me to 
determine how to recognise the difference between the two is really difficult 
(in fact I'm not even certain it's possible).

Henrique and Thibault, I would appreciate any advice you can offer.

Also if you go to #selinux on irc.openprojects.net you will find the details 
for how to login to my SE play machine if you want to experiment with SE 
Linux and get a feel for what needs to be done.


[1]  This feature implemented in the regular crond prevented my SE play 
machine cose from being cracked in one instance.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
