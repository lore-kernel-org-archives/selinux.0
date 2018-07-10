To: "Mclain, Warren" <warren_mclain@optum.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <26a19085-e4b2-a986-d377-ae05b19c40ed@tycho.nsa.gov>
Date: Tue, 10 Jul 2018 12:42:53 -0400
MIME-Version: 1.0
In-Reply-To: <8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: blocking / mount using containers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2018 10:00 AM, Mclain, Warren wrote:
> I am trying to find a solution for blocking the mounting of / from containers. This is a major security hole for Docker and all of those types of applications.
> 
>  
> 
> I found the mount_anyfile  Boolean but nothing that digs into that to show how to disable specific mountings.
> 
>  
> 
> Looking for any information that would help the container community in general.

Not sure if this answers your question, but Fedora/RHEL ships with a container policy that should already protect the host OS filesystem from the containers.

Even if you mount / into the container when you create it, it isn't writable due to SELinux policy, e.g.
$ sudo docker run -v /:/mnt -i -t fedora /bin/bash 
[root@fb83953335bb /]# cd mnt
[root@fb83953335bb mnt]# cat etc/shadow
cat: etc/shadow: Permission denied
[root@fb83953335bb mnt]# touch foo
touch: cannot touch 'foo': Permission denied
[root@fb83953335bb mnt]# exit
$ sudo ausearch -i -m AVC -ts recent
----
type=PROCTITLE msg=audit(07/10/2018 12:40:11.083:870570) : proctitle=cat etc/shadow 
type=PATH msg=audit(07/10/2018 12:40:11.083:870570) : item=0 name=etc/shadow inode=1311125 dev=fd:01 mode=file,000 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:shadow_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(07/10/2018 12:40:11.083:870570) : cwd=/mnt 
type=SYSCALL msg=audit(07/10/2018 12:40:11.083:870570) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffffffffffff9c a1=0x7fffe6c7b92f a2=O_RDONLY a3=0x0 items=1 ppid=1992 pid=2044 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts3 ses=unset comm=cat exe=/usr/bin/cat subj=system_u:system_r:container_t:s0:c138,c987 key=(null) 
type=AVC msg=audit(07/10/2018 12:40:11.083:870570) : avc:  denied  { read } for  pid=2044 comm=cat name=shadow dev="dm-1" ino=1311125 scontext=system_u:system_r:container_t:s0:c138,c987 tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=0 
----
type=PROCTITLE msg=audit(07/10/2018 12:40:19.859:870580) : proctitle=touch foo 
type=PATH msg=audit(07/10/2018 12:40:19.859:870580) : item=0 name=/mnt inode=2 dev=fd:01 mode=dir,555 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:root_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(07/10/2018 12:40:19.859:870580) : cwd=/mnt 
type=SYSCALL msg=audit(07/10/2018 12:40:19.859:870580) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffffffffffff9c a1=0x7ffc7550f932 a2=O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK a3=0x1b6 items=1 ppid=1992 pid=2053 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts3 ses=unset comm=touch exe=/usr/bin/touch subj=system_u:system_r:container_t:s0:c138,c987 key=(null) 
type=AVC msg=audit(07/10/2018 12:40:19.859:870580) : avc:  denied  { write } for  pid=2053 comm=touch name=/ dev="dm-1" ino=2 scontext=system_u:system_r:container_t:s0:c138,c987 tcontext=system_u:object_r:root_t:s0 tclass=dir permissive=0 
