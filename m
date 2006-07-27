Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6RAOAPM015094
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 06:24:10 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6RAO8m9004576
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 10:24:09 GMT
Received: by ug-out-1314.google.com with SMTP id u2so173380uge
        for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 03:24:09 -0700 (PDT)
Subject: Securing backup-shell-script
From: Thomas Reuss <thomas.reuss@gmail.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 12:24:05 +0200
Message-Id: <1153995846.5726.11.camel@angmar>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

we are trying to protect a backup-shell-script, using the targeted
policy under Fedora Core 5.
The script tars several directories
(/etc, /var/www, /var/lib/majordomo, /var/spool/mail), it dumps all
mysql-databases via mysqldump and stores the ldap-data via slapcat.
Finally, it computes md5 checksums over all /etc-Files. In case of any
error, the script notifies root via sendmail.

The script is started by cron. The executed programs run under
"unconfined_t". (I.e. tar for example runs in the domain "unconfined_t")

Which steps do we have to take, to secure the script, e.g. in an own
domain "backup_t" ?


Thank you very much,

Thomas



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
