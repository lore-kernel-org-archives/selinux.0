Message-ID: <4512A44B.2010908@us.ibm.com>
Date: Thu, 21 Sep 2006 09:40:11 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Serge E. Hallyn" <serue@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SSH pubkey authentication & MLS policy
References: <4511AAF2.8090809@us.ibm.com> <45129698.5080503@redhat.com>
In-Reply-To: <45129698.5080503@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Chris, how do you want to handle this?
> 
> 
> 
> Michael C Thompson wrote:
>> Hey Dan,
>>
>> We're trying to get ssh to use public key authentication to log in, 
>> and it seems that sshd can't access the various home directories for 
>> the contents of .ssh
>>
>> Is there something that we can change in the policy to permit this 
>> action?
>>
>> For root:
>>
>> type=AVC msg=audit(1158784742.480:63): avc:  denied  { getattr } for 
>> pid=1798 comm="sshd" name="root" dev=sda3 ino=11436033 
>> scontext=system_u:system_r:sshd_t:s0-s15:c0.c255 
>> tcontext=root:object_r:sysadm_home_dir_t:s0-s15:c0.c255 tclass=dir
>> type=SYSCALL msg=audit(1158784742.480:63): arch=c000003e syscall=6 
>> success=yes exit=0 a0=7fff8877e100 a1=7fff8877cf80 a2=7fff8877cf80 
>> a3=0 items=0 ppid=1554 pid=1798 auid=4294967295 uid=0 gid=0 euid=0 
>> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) comm="sshd" 
>> exe="/usr/sbin/sshd" subj=system_u:system_r:sshd_t:s0-s15:c0.c255 
>> key=(null)
>> type=AVC_PATH msg=audit(1158784742.480:63):  path="/root"
>>
>> For non-root users:
>>
>> type=AVC msg=audit(1158784771.664:76): avc:  denied  { getattr } for 
>> pid=1827 comm="sshd" name="mcthomps" dev=sda3 ino=9175059 
>> scontext=system_u:system_r:sshd_t:s0-s15:c0.c255 
>> tcontext=user_u:object_r:user_home_dir_t:s0-s15:c0.c255 tclass=dir
>> type=SYSCALL msg=audit(1158784771.664:76): arch=c000003e syscall=6 
>> success=yes exit=0 a0=7ffff3244bc0 a1=7ffff3243a40 a2=7ffff3243a40 
>> a3=0 items=0 ppid=1554 pid=1827 auid=4294967295 uid=0 gid=0 euid=503 
>> suid=0 fsuid=503 egid=503 sgid=0 fsgid=503 tty=(none) comm="sshd" 
>> exe="/usr/sbin/sshd" subj=system_u:system_r:sshd_t:s0-s15:c0.c255 
>> key=(null)
>> type=AVC_PATH msg=audit(1158784771.664:76):  path="/home/mcthomps"
>>
>>
>> Thanks,
>> Mike
>>
> Could you do this in permissive mode to capture all of the avc

I did, thats all the ones that were generated that seemed pertinant to 
sshd, I can re-do this and send you the complete transaction log if you 
want.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
