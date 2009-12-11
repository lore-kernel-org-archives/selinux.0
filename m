Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBBEpZZ5018354
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 09:51:35 -0500
Received: from mail.t0mb.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBBErrqG025450
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 14:53:53 GMT
Received: from localhost (mail.t0mb.net [127.0.0.1])
	by mail.t0mb.net (Postfix) with ESMTP id CCF34102607
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 14:51:32 +0000 (GMT)
Received: from mail.t0mb.net ([127.0.0.1])
	by localhost (mail.t0mb.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnQvQ8iEkeQQ for <selinux@tycho.nsa.gov>;
	Fri, 11 Dec 2009 14:51:24 +0000 (GMT)
Received: from [10.44.248.77] (unknown [213.171.217.184])
	by mail.t0mb.net (Postfix) with ESMTP id B950C1025FF
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 14:51:24 +0000 (GMT)
Message-ID: <4B225A8D.908@t0mb.net>
Date: Fri, 11 Dec 2009 14:43:25 +0000
From: Tom Boland <tom@t0mb.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: CentOS 5.4 nfs home directories + cron
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[resending to correct address!]

Greetings,

I am investigating using RedHats strict selinux policy.  Please accept 
my apologies if this isn't the correct place, but I'm hoping someone can 
help me clarify one or two things.  Basically, crond seems to run, but 
when attempting to run a job for an unprivileged user with their home 
folder on an NFS partition, pretty much every action that can interact 
with the home directory is denied.  The users themselves do not have the 
same problem via ssh, as I have the  'use_nfs_home_dirs' boolean set to 1:

*cat /selinux/booleans/use_nfs_home_dirs
1 1
*
I'm using the setroubleshoot daemon to try and diagnose the problem in 
permissive mode, and I have messages such as this when trying to use a 
job that simply touches a file in the users home directory: *

Dec 11 12:21:01 ssh setroubleshoot: SELinux prevented touch from reading 
and writing files stored on a NFS filesytem. For complete SELinux 
messages. run sealert -l d445d52e-57bb-4ca6-a2ad-48cbd62f7e03

=======

Raw Audit Messages          
host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
denied  { write } for  pid=11342 comm="touch" name="user" dev=0:16 
ino=64192517 scontext=user_u:user_r:user_crond_t:s0 
tcontext=system_u:object_r:nfs_t:s0 tclass=dir

host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
denied  { add_name } for  pid=11342 comm="touch" name="afile" 
scontext=user_u:user_r:user_crond_t:s0 
tcontext=system_u:object_r:nfs_t:s0 tclass=dir

host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
denied  { create } for  pid=11342 comm="touch" name="afile" 
scontext=user_u:user_r:user_crond_t:s0 tcontext=user_u:object_r:nfs_t:s0 
tclass=file

host=ssh.livedns.co.uk type=SYSCALL msg=audit(1260534061.381:4716): 
arch=c000003e syscall=2 success=yes exit=0 a0=7fffa80e7f0a a1=941 a2=1b6 
a3=3d0d35210c items=2 ppid=11341 pid=11342 auid=217858 uid=217858 
gid=500 euid=217858 suid=217858 fsuid=217858 egid=500 sgid=500 fsgid=500 
tty=(none) ses=1129 comm="touch" exe="/bin/touch" 
subj=user_u:user_r:user_crond_t:s0 key=(null)

host=ssh.livedns.co.uk type=CWD msg=audit(1260534061.381:4716): 
cwd="/home/fhlinux142/e/eschelon.co.uk/user"

host=ssh.livedns.co.uk type=PATH msg=audit(1260534061.381:4716): item=0 
name="/home/webserver/site/user/" inode=64192517 dev=00:16 mode=040701 
ouid=217858 ogid=500 rdev=00:00 obj=system_u:object_r:nfs_t:s0

host=ssh.livedns.co.uk type=PATH msg=audit(1260534061.381:4716): item=1 
name="**/home/webserver/site/user/**afile" inode=64194402 dev=00:16 
mode=0100644 ouid=217858 ogid=500 rdev=00:00 obj=system_u:object_r:nfs_t:s0*


I haven't pasted everything from sealert, i thought the raw logs would 
be enough.  I've used audit2allow to get a basic skeletal policy for 
crond+nfs and added a bit to it, which is like:

*module crondreadnfs 1.0;

require {
   type user_crond_t;
   type nfs_t;
   class dir { read write add_name create getattr search };
   class file { read write create getattr };
}

require {
   type crond_t;
   type nfs_t;
   class dir { read write add_name create getattr search };
   class file { read write create getattr };
}

#============= user_crond_t ==============
allow user_crond_t nfs_t:dir { read write add_name create getattr search };
allow user_crond_t nfs_t:file { read write create getattr };

allow crond_t nfs_t:dir {read write add_name create getattr search };
allow crond_t nfs_t:file { read write create getattr };
*
But I'm actually a bit confused as to why it's necessary.  I thought 
cron would be running jobs _as_ the user, and under the users context?  
Is there something else wrong?  SSH is fine with the use_nfs_home_dirs 
boolean, so why not cron?  If there's a way for this to work without 
having to explicitly allow every single operation that cron is allowed 
to attempt, and to just run jobs with the access that the user who's 
cronjob it is has, I would be most appreciative!!

Many thanks.  Tom.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
