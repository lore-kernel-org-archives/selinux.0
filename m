Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29523
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:47:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA23924
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:47:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA23920
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:47:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
Date: Thu, 27 Jun 2002 14:47:20 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627180908.14427.qmail@web40018.mail.yahoo.com>
In-Reply-To: <20020627180908.14427.qmail@web40018.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627184720.E0872694@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 14:09, Brad Chapman wrote:
>        I was able to fix all the problems with your policy configuration at
> www.coker.com.au/selinux/policy.tgz. I compiled, installed and loaded it,
> and found that the number of errors had been slashed by at least a third,
> maybe half. However, there are still a significant number of errors that I
> don't know how to fix. Attached are two more dmesg outputs; one from
> bootup, the other after starting X and Netscape.

psidfiles_init:  error 22 in obtaining SID for context 
system_u:object_r:rmmod_exec_t (psid 42).

These are from removing types from the policy and then remounting a file 
system that uses the now non-existant contexts or which once used them.

avc:  denied  { mounton } for  pid=1 comm=swapper path=/dev dev=03:0a 
ino=10041
scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:file_t 
tclass=dir

This is a problem in that you can't change the type of /dev (unless you use 
some very experimental patches).  So all you can do is add a new rule to 
allow this.

avc:  denied  { write } for  pid=1 exe=/sbin/init dev=00:07 ino=1 
scontext=system_u:system_r:init_t tcontext=system_u:object_r:devfs_t 
tclass=dir

Use the following in init.te (something equivalent should already be in my 
policy):
ifdef(`devfsd.te', `file_type_auto_trans(init_t, devfs_t, initctl_t)')

avc:  denied  { read write } for  pid=12 exe=/sbin/devfsd path=/console 
dev=00:07 ino=17 scontext=system_u:system_r:devfsd_t 
tcontext=system_u:object_r:console_device_t tclass=chr_file

This is fixed in my latest policy files which I have just put online (lots of 
changes related to /dev/console).

avc:  denied  { read } for  pid=12 exe=/sbin/devfsd path=/.devfsd dev=00:07 
ino=2 scontext=system_u:system_r:devfsd_t tcontext=system_u:object_r:devfs_t 
tclass=chr_file

You need the following in the devfs_contexts file:
devfscon /.devfsd               system_u:object_r:devfs_control_t

avc:  denied  { read } for  pid=12 exe=/sbin/devfsd path=/etc/nsswitch.conf 
dev=03:0a ino=14073 scontext=system_u:system_r:devfsd_t 
tcontext=system_u:object_r:etc_t tclass=file

Should be solved by the following:
allow devfsd_t { etc_t etc_runtime_t proc_t }:file r_file_perms;

avc:  denied  { write } for  pid=22 exe=/sbin/minilogd dev=00:07 ino=1 
scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:devfs_t 
tclass=dir

/sbin/minilogd should be labelled the same as /usr/sbin/syslogd.

avc:  denied  { execute } for  pid=40 exe=/bin/bash path=/bin/echo dev=03:0a 
ino=6068 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:bin_t 
tclass=file
Put in can_exec(devfsd_t, bin_t)



-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
