Date: Fri, 11 Jan 2008 09:27:18 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC] Obtaining PATH entry without audit userland
Cc: ynakam@hitachisoft.jp, Alexander Viro <aviro@redhat.com>,
        linux-audit@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <200801101040.19032.sgrubb@redhat.com>
References: <20080110153237.GH16537@devserv.devel.redhat.com> <200801101040.19032.sgrubb@redhat.com>
Message-Id: <20080111092505.FCD4.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jan 2008 10:40:18 -0500
Steve Grubb  wrote:
> On Thursday 10 January 2008 10:32:37 Alexander Viro wrote:
> > On Thu, Jan 10, 2008 at 10:19:50AM -0500, Steve Grubb wrote:
> > > I was under the impression that Al Viro has already sent a patch allowing
> > > for PATH in all AVC messages. Al?
> >
> > In the mainline for quite a while...
> 
> That's what I thought.
> 
> Yuichi, what kernel are you testing against that is having the problem? Is 
> there a simple test case that shows the problem so we can check the kernel to 
> make sure its working properly?
I am using 2.6.22.1 and 2.6.24.rc1, and enabling syscall audit.

One example of AVC message in 2.6.24.rc1 is below.
#Type is broken for testing, do not warry about that :)
audit(946684824.060:5): avc:  denied  { read } for  pid=796 comm="httpd" name="index.html" dev=sda1 ino=61906 
scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:etc_shadow_t tclass=file
audit(946684824.060:5): arch=2a syscall=5 per=800000 success=yes exit=5 a0=48d490 a1=0 a2=1b6 a3=1b6 items=1 
ppid=795 pid=796 auid=4294967295 uid=99 gid=99 euid=99 suid=99 fsuid=99 egid=99 sgid=99 fsgid=99 tty=(none) comm="httpd" 
exe="/usr/sbin/httpd" subj=system_u:system_r:httpd_t key=(null)

File name appears as name="index.html".

By applying my patch or registering some audit rule, 
following will appear.

audit(946684824.060:5):  cwd="/"
audit(946684824.060:5): item=0 name="/var/www/htdocs/index.html" inode=61906 dev=08:01 mode=0100644 
ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:etc_shadow_t

Here, fullpath "/var/www/htdocs/index.html" is reported.

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
