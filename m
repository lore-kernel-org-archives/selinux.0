Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P1oE3E026820
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 21:50:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5P1oD5e012218
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 01:50:13 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
        by jazzband.ncsc.mil  with ESMTP id h5P1oC92012213 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 01:50:12 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 07B3AF63A
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 21:50:07 -0400 (EDT)
Subject: local policy changes, /var/lib access, syslogd
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1056505792.29159.43.camel@columbia>
Mime-Version: 1.0
Date: 24 Jun 2003 21:49:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have a few questions.  First, where is the best place to keep one's
local policy changes?  For example, I wanted to let user_t have general
access to httpd_sys_content_t, since almost all of my users maintain
their own websites.  So I just put 

# Since most of our users are also web admins, just allow this.
rw_dir_create_file(user_t,httpd_sys_content_t)
allow user_t httpd_sys_content_t:dir create_dir_perms;

in /etc/selinux/domains/misc/local.te.  Is there a more "standard" place
for this?

Secondly, I'm getting a lot of programs wanting search access to
/var/lib (var_lib_t).  At least sshd_t, user_ssh_t, syslogd_t,
postfix_master_t, etc.  I added a bunch of dontaudit rules, but I'm
wondering if anyone knew why these programs were trying to access
/var/lib?

Finally, I also get a number of denials from syslogd attempting to
access /dev/xconsole:

avc:  denied  { read write } for  pid=162 exe=/sbin/syslogd path=/dev/xconsole dev=03:01 ino=2310191 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:device_t tclass=fifo_file

I don't plan to use X on this machine, so I could just add a dontaudit I
suppose, but I'm curious why this isn't the default.

And thanks for SELinux, it's great!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
