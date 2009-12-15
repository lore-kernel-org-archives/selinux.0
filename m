Message-ID: <4B27B377.1000506@t0mb.net>
Date: Tue, 15 Dec 2009 16:04:07 +0000
From: Tom Boland <tom@t0mb.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: CentOS 5.4 nfs home directories + cron
References: <4B225A8D.908@t0mb.net> <1260557420.26597.19.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1260557420.26597.19.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Thanks for the reply, and sorry for the spoon feed request here, but I'm 
a bit confused about these contexts.  If you're saying that I can have 
cron run jobs in the users context with the RHEL5 strict policy, or that 
I can emulate this behaviour by adding allow rules? 

I've tried altering /etc/selinux/strict/contexts/default_contexts:

system_r:crond_t:s0 user_r:user_crond_t:s0 staff_r:staff_crond_t:s0 
sysadm_r:sysadm_crond_t:s0 system_r:system_crond_t:s0 
mailman_r:user_crond_t:s0

is now

system_r:crond_t:s0 user_r:user_t:s0 staff_r:staff_crond_t:s0 
sysadm_r:sysadm_crond_t:s0 system_r:system_crond_t:s0 
mailman_r:user_crond_t:s0

But this seems to be causing labelling problems with crontab -e still 
creating the users crontab file in the user_crond_t context.  Was I 
missing the point of what you were saying here?

I also don't have anything other than root in the contexts/users 
folder.  All my users are in LDAP, and I'm happy with the way they work 
apart from the cron thing.

Many thanks for any assistance.

Cheers.  Tom.

Stephen Smalley wrote:
> On Fri, 2009-12-11 at 14:43 +0000, Tom Boland wrote:
>   
>> [resending to correct address!]
>>
>> Greetings,
>>
>> I am investigating using RedHats strict selinux policy.  Please accept 
>> my apologies if this isn't the correct place, but I'm hoping someone can 
>> help me clarify one or two things.  Basically, crond seems to run, but 
>> when attempting to run a job for an unprivileged user with their home 
>> folder on an NFS partition, pretty much every action that can interact 
>> with the home directory is denied.  The users themselves do not have the 
>> same problem via ssh, as I have the  'use_nfs_home_dirs' boolean set to 1:
>>
>> *cat /selinux/booleans/use_nfs_home_dirs
>> 1 1
>> *
>> I'm using the setroubleshoot daemon to try and diagnose the problem in 
>> permissive mode, and I have messages such as this when trying to use a 
>> job that simply touches a file in the users home directory: *
>>
>> Dec 11 12:21:01 ssh setroubleshoot: SELinux prevented touch from reading 
>> and writing files stored on a NFS filesytem. For complete SELinux 
>> messages. run sealert -l d445d52e-57bb-4ca6-a2ad-48cbd62f7e03
>>
>> =======
>>
>> Raw Audit Messages          
>> host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
>> denied  { write } for  pid=11342 comm="touch" name="user" dev=0:16 
>> ino=64192517 scontext=user_u:user_r:user_crond_t:s0 
>> tcontext=system_u:object_r:nfs_t:s0 tclass=dir
>>
>> host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
>> denied  { add_name } for  pid=11342 comm="touch" name="afile" 
>> scontext=user_u:user_r:user_crond_t:s0 
>> tcontext=system_u:object_r:nfs_t:s0 tclass=dir
>>
>> host=ssh.livedns.co.uk type=AVC msg=audit(1260534061.381:4716): avc:  
>> denied  { create } for  pid=11342 comm="touch" name="afile" 
>> scontext=user_u:user_r:user_crond_t:s0 tcontext=user_u:object_r:nfs_t:s0 
>> tclass=file
>>
>> host=ssh.livedns.co.uk type=SYSCALL msg=audit(1260534061.381:4716): 
>> arch=c000003e syscall=2 success=yes exit=0 a0=7fffa80e7f0a a1=941 a2=1b6 
>> a3=3d0d35210c items=2 ppid=11341 pid=11342 auid=217858 uid=217858 
>> gid=500 euid=217858 suid=217858 fsuid=217858 egid=500 sgid=500 fsgid=500 
>> tty=(none) ses=1129 comm="touch" exe="/bin/touch" 
>> subj=user_u:user_r:user_crond_t:s0 key=(null)
>>
>> host=ssh.livedns.co.uk type=CWD msg=audit(1260534061.381:4716): 
>> cwd="/home/fhlinux142/e/eschelon.co.uk/user"
>>
>> host=ssh.livedns.co.uk type=PATH msg=audit(1260534061.381:4716): item=0 
>> name="/home/webserver/site/user/" inode=64192517 dev=00:16 mode=040701 
>> ouid=217858 ogid=500 rdev=00:00 obj=system_u:object_r:nfs_t:s0
>>
>> host=ssh.livedns.co.uk type=PATH msg=audit(1260534061.381:4716): item=1 
>> name="**/home/webserver/site/user/**afile" inode=64194402 dev=00:16 
>> mode=0100644 ouid=217858 ogid=500 rdev=00:00 obj=system_u:object_r:nfs_t:s0*
>>
>>
>> I haven't pasted everything from sealert, i thought the raw logs would 
>> be enough.  I've used audit2allow to get a basic skeletal policy for 
>> crond+nfs and added a bit to it, which is like:
>>
>> *module crondreadnfs 1.0;
>>
>> require {
>>    type user_crond_t;
>>    type nfs_t;
>>    class dir { read write add_name create getattr search };
>>    class file { read write create getattr };
>> }
>>
>> require {
>>    type crond_t;
>>    type nfs_t;
>>    class dir { read write add_name create getattr search };
>>    class file { read write create getattr };
>> }
>>
>> #============= user_crond_t ==============
>> allow user_crond_t nfs_t:dir { read write add_name create getattr search };
>> allow user_crond_t nfs_t:file { read write create getattr };
>>
>> allow crond_t nfs_t:dir {read write add_name create getattr search };
>> allow crond_t nfs_t:file { read write create getattr };
>> *
>> But I'm actually a bit confused as to why it's necessary.  I thought 
>> cron would be running jobs _as_ the user, and under the users context?  
>> Is there something else wrong?  SSH is fine with the use_nfs_home_dirs 
>> boolean, so why not cron?  If there's a way for this to work without 
>> having to explicitly allow every single operation that cron is allowed 
>> to attempt, and to just run jobs with the access that the user who's 
>> cronjob it is has, I would be most appreciative!!
>>
>> Many thanks.  Tom.
>>     
>
> See http://marc.info/?l=selinux&m=121094043113003&w=2
>
> That has subsequently changed since RHEL5 so that user cron jobs just
> run in the user's own domain, I believe.  But you could change your
> policy likewise if that is the behavior you want.
>
> Modify the system_r:crond_t:s0 entry in
> your /etc/selinux/targeted/contexts/default_contexts file and in
> your /etc/selinux/targeted/contexts/users/* files, and add allow rules
> as needed.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
