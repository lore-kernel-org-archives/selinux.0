Subject: Re: [RFC] Obtaining PATH entry without audit userland
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, Alexander Viro <aviro@redhat.com>,
        linux-audit@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <200801101932.04581.sgrubb@redhat.com>
References: <20080110153237.GH16537@devserv.devel.redhat.com>
	 <200801101040.19032.sgrubb@redhat.com>
	 <20080111092505.FCD4.YNAKAM@hitachisoft.jp>
	 <200801101932.04581.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Jan 2008 08:40:09 -0500
Message-Id: <1200058809.29816.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-10 at 19:32 -0500, Steve Grubb wrote:
> On Thursday 10 January 2008 19:27:18 Yuichi Nakamura wrote:
> > One example of AVC message in 2.6.24.rc1 is below.
> > #Type is broken for testing, do not warry about that :)
> > audit(946684824.060:5): avc:  denied  { read } for  pid=796 comm="httpd"
> > name="index.html" dev=sda1 ino=61906 scontext=system_u:system_r:httpd_t
> > tcontext=system_u:object_r:etc_shadow_t tclass=file audit(946684824.060:5):
> > arch=2a syscall=5 per=800000 success=yes exit=5 a0=48d490 a1=0 a2=1b6
> > a3=1b6 items=1 ppid=795 pid=796 auid=4294967295 uid=99 gid=99 euid=99
> > suid=99 fsuid=99 egid=99 sgid=99 fsgid=99 tty=(none) comm="httpd"
> > exe="/usr/sbin/httpd" subj=system_u:system_r:httpd_t key=(null)
> >
> > File name appears as name="index.html".
> 
> How can we recreate the problem so that we can see what is going on?

Just trigger a denial on open(2) without any audit rules configured.
Then, audit system doesn't collect pathname info due to the
"optimization" to not collect information without syscall filters, and
SELinux doesn't get the vfsmount (reliably) in selinux_inode_permission,
so it cannot generate a path either.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
