Subject: cgiemail and senmail policy
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1119137931.11593.53.camel@rodan.ncc.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
Content-Type: text/plain
Message-Id: <1120169474.17769.60.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Thu, 30 Jun 2005 17:11:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running a CentOS 4.1 (Red Hat EL) box with an Apache web server. I
thought I'd worked out all the problems with my cgi scripts but a new
one cropped up today. We use the good ol' MIT cgiemail program to handle
form submissions that get sent via sendmail. When someone submits a
form, I get a series of avc errors and no email gets sent. What's the
best way to fix this (i.e. to make Apache able to use cgiemail to send
email via sendmail)?  Here are the errors I'm getting:
 
Jun 30 16:47:33 orac kernel: audit(1120168053.409:0): avc:  denied  {
write } for  pid=27969 comm=sendmail path=/tmp/filegvNeNa dev=dm-0
ino=948452 scontext=root:system_r:system_mail_t
tcontext=root:object_r:httpd_sys_script_rw_t tclass=file

Jun 30 16:47:33 orac kernel: audit(1120168053.410:0): avc:  denied  {
write } for  pid=27969 comm=sendmail path=/tmp/filegvNeNa dev=dm-0
ino=948452 scontext=root:system_r:system_mail_t
tcontext=root:object_r:httpd_sys_script_rw_t tclass=file

Jun 30 16:47:33 orac kernel: audit(1120168053.410:0): avc:  denied  {
write } for  pid=27969 comm=sendmail path=/tmp/filegvNeNa dev=dm-0
ino=948452 scontext=root:system_r:system_mail_t
tcontext=root:object_r:httpd_sys_script_rw_t tclass=file

Jun 30 16:47:33 orac kernel: audit(1120168053.410:0): avc:  denied  {
read write } for  pid=27969 comm=sendmail path=/tmp/tmpfKM8Top (deleted)
dev=dm-0 ino=948418 scontext=root:system_r:system_mail_t
tcontext=root:object_r:httpd_sys_script_rw_t tclass=file

Jun 30 16:47:33 orac kernel: audit(1120168053.510:0): avc:  denied  {
search } for  pid=27969 comm=sendmail name=www dev=dm-0 ino=556110
scontext=root:system_r:system_mail_t
tcontext=system_u:object_r:httpd_sys_content_t tclass=dir

Jun 30 16:47:33 orac kernel: audit(1120168053.511:0): avc:  denied  {
getattr }
for  pid=27969 comm=sendmail path=/var/www dev=dm-0 ino=556110
scontext=root:system_r:system_mail_t
tcontext=system_u:object_r:httpd_sys_content_t tclass=dir



The system is using selinux-policy-targeted-1.17.30-2.88.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
