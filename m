Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17220
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 14:07:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA28325
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:06:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA28321
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:06:38 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: [patch] Re: chattr
Date: Mon, 22 Jul 2002 20:06:56 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0207180911590.9066-200000@raven>
In-Reply-To: <Pine.GSO.4.33.0207180911590.9066-200000@raven>
MIME-Version: 1.0
Message-Id: <20020722180656.79B011549@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Jul 2002 15:35, Stephen Smalley wrote:
> > True, as long as you have setattr permission to the type (at least, with
> > ext2 and ext3).  So I think that the real issue is that 'setattr'
> > permission is unnecessarily included in the rw_file_perms and
> > rw_dir_perms macros.  For better control, we should probably remove it
> > from these macros and selectively grant it as needed.  It would still
> > remain in the create_file_perms and create_dir_perms macros.
>
> The attached patch (also committed to the sourceforge CVS tree) removes
> setattr permission from the rw_file_perms and rw_dir_perms macros and adds
> it explicitly to a number of allow rules where it is needed.  It is likely
> that you will encounter plenty of other cases where setattr permission
> must also be granted.

 # Write to /var/lib/slocate.db.
-allow system_crond_t var_lib_t:dir rw_dir_perms;
+allow system_crond_t var_lib_t:dir { setattr rw_dir_perms };

Does writing to slocate.db really require setattr access?

 # Used for /sbin/tmpwatch
-allow system_crond_t tmpfile:dir rw_dir_perms;
+allow system_crond_t tmpfile:dir { setattr rw_dir_perms };
 allow system_crond_t tmpfile:dir rmdir;
 allow system_crond_t tmpfile:notdevfile_class_set link_file_perms;
 allow system_crond_t catman_t:dir rw_dir_perms;

What is /sbin/tmpwatch?  Is this a program that periodically removes old 
files from /tmp?  If so then it probably doesn't need setattr access, and 
should be run in my tmpreaper_t domain.

 # Update /etc/mail.
-allow initrc_t etc_mail_t:file rw_file_perms;
+allow initrc_t etc_mail_t:file { setattr rw_file_perms };

I changed the above to the following in my tree:
ifdef(`sendmail.te', `
# Update /etc/mail.
allow initrc_t etc_mail_t:file { setattr rw_file_perms };
')

Currently postfix.te depends on sendmail.te, but not for long.  This 
/etc/mail is a sendmail specific thing apparently not used by other mail 
servers.

Also giving initrc access to that directory/file is a bad idea anyway, the 
sendmail start script in question should be run in the sendmail_t domain IMHO 
(as I have done for devfsd in Debian).

 # Rules for /proc/sys/kernel/tainted
-allow insmod_t sysctl_kernel_t:file rw_file_perms;
-allow insmod_t sysctl_t:file write;
+allow insmod_t sysctl_kernel_t:file { setattr rw_file_perms };

Is this really what you desire, removing the sysctl_t access?  I'm sure it 
was added for a reason...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
