Date: Fri, 11 Jan 2008 10:11:55 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC] Obtaining PATH entry without audit userland
Cc: ynakam@hitachisoft.jp, Alexander Viro <aviro@redhat.com>,
        linux-audit@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <200801101932.04581.sgrubb@redhat.com>
References: <20080111092505.FCD4.YNAKAM@hitachisoft.jp> <200801101932.04581.sgrubb@redhat.com>
Message-Id: <20080111100435.FCD7.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 10 Jan 2008 19:32:04 -0500
Steve Grubb  wrote:
> On Thursday 10 January 2008 19:27:18 Yuichi Nakamura wrote:
> > One example of AVC message in 2.6.24.rc1 is below.
> > #Type is broken for testing, do not warry about that :)
> > audit(946684824.060:5): avc: denied { read } for pid=796 comm="httpd"
> > name="index.html" dev=sda1 ino=61906 scontext=system_u:system_r:httpd_t
> > tcontext=system_u:object_r:etc_shadow_t tclass=file audit(946684824.060:5):
> > arch=2a syscall=5 per=800000 success=yes exit=5 a0=48d490 a1=0 a2=1b6
> > a3=1b6 items=1 ppid=795 pid=796 auid=4294967295 uid=99 gid=99 euid=99
> > suid=99 fsuid=99 egid=99 sgid=99 fsgid=99 tty=(none) comm="httpd"
> > exe="/usr/sbin/httpd" subj=system_u:system_r:httpd_t key=(null)
> How can we recreate the problem so that we can see what is going on?

Here is how to recreate on Fedora 8 PC.

(1) Check /etc/audit/audit.rules, and make sure no rules are registered.
If registered, remove them and reboot.

(2) Break security context to generate AVC message, and generate AVC.
# chcon -t shadow_t /etc/httpd/conf/httpd.conf
# /etc/init.d/httpd start

(3) It should fail, and following AVC message appears
--
# ausearch -m AVC
time->Fri Jan 11 09:58:55 2008
type=SYSCALL msg=audit(1200013135.944:60): arch=40000003 syscall=5 success=no exit=-13 a0=b999c158 a1=8000 a2=1b6 a3=8000 items=0 ppid=2586 pid=2587 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 comm="httpd" exe="/usr/sbin/httpd" subj=root:system_r:httpd_t:s0 key=(null)
type=AVC msg=audit(1200013135.944:60): avc:  denied  { read } for  pid=2587 comm="httpd" name="httpd.conf" dev=dm-0 ino=1109270 scontext=root:system_r:httpd_t:s0 tcontext=system_u:object_r:shadow_t:s0 tclass=file
---

"name" is httpd.conf.

(4) Register dummy audit rule and generate AVC message again.
---
# auditctl -a exit,always -S chdir -F obj_type=dummy_t
# /etc/init.d/httpd start
# ausearch -m AVC 
time->Fri Jan 11 10:03:46 2008
type=PATH msg=audit(1200013426.905:65): item=0 name="/etc/httpd/conf/httpd.conf" inode=1109270 dev=fd:00 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:shadow_t:s0
type=CWD msg=audit(1200013426.905:65):  cwd="/root"
type=SYSCALL msg=audit(1200013426.905:65): arch=40000003 syscall=5 success=no exit=-13 a0=b913f158 a1=8000 a2=1b6 a3=8000 items=1 ppid=2612 pid=2613 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 comm="httpd" exe="/usr/sbin/httpd" subj=root:system_r:httpd_t:s0 key=(null)
type=AVC msg=audit(1200013426.905:65): avc:  denied  { read } for  pid=2613 comm="httpd" name="httpd.conf" dev=dm-0 ino=1109270 scontext=root:system_r:httpd_t:s0 tcontext=system_u:object_r:shadow_t:s0 tclass=file
---

In type=PATH, full path name "/etc/httpd/conf/httpd.conf"  appeared.

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
