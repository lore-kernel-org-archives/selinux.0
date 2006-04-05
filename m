Subject: rsync resetting contexts in /var/www
From: "J. Simonetti" <jsimonetti@denit.net>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 12:50:18 +0200
Message-Id: <1144234218.7521.70.camel@jeroen.office.denit.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello list,

I'm running into a problem with selinux on FC4
(selinux-policy-targeted-1.27.1-2.22).

I'm using rsync to build a local fedora mirror. I'm rsyncing
to /var/www/mirror with has a context of
root:object_r:httpd_sys_content_t

However rsync seems to insist on writing the files synched in this
directory as root:object_r:var_t.
This results in a 403 error when trying to access the files via the web
because apache can't read the files.

Is there a way for me to force rsync to create files in a certain
context other then running chcon -R everytime rsync finishes?

-- 
Kind regards,
 
Jeroen Simonetti
Network Manager
 
Denit Internet Services BV
Contactweg 131
1014 BJ  Amsterdam
Tel: +31 (0)20 337 2560
Fax: +31 (0)20 337 1802

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
