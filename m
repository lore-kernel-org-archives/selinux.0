Subject: Re: libGL.so.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201007182309.58829.russell@coker.com.au>
References: <201007182309.58829.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Jul 2010 14:05:07 -0400
Message-ID: <1279735507.20469.16.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-07-18 at 23:09 +1000, Russell Coker wrote:
> type=AVC msg=audit(1279458495.111:24): avc:  denied  { execmem } for  pid=1801 
> comm="ksmserver" scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
> tclass=process
> type=SYSCALL msg=audit(1279458495.111:24): arch=40000003 syscall=192 
> success=no exit=-13 a0=b47ba000 a1=9000 a2=7 a3=812 items=0 ppid=1239 pid=1801 
> auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
> tty=pts0 ses=4294967295 comm="ksmserver" exe="/usr/bin/ksmserver" 
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> 
> # ksmserver 
> ksmserver: error while loading shared libraries: libGL.so.1: failed to map 
> segment from shared object: Permission denied
> 
> It seems that problems with libGL.so.1 have been around for a while, are these 
> solvable without a huge amount of coding?

Fedora has been carrying a patch to mesa to ensure that libGL.so isn't
marked with an executable stack for a long time, and I think the patch
has gone upstream in modern versions of mesa.

$ execstack -q /usr/lib64/libGL.so.1
- /usr/lib64/libGL.so.1

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
