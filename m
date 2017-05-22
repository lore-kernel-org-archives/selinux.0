Message-ID: <1495479951.24649.12.camel@tycho.nsa.gov>
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Chris O'Neil" <anzavalley@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 22 May 2017 15:05:51 -0400
In-Reply-To: <1495478730.24649.10.camel@tycho.nsa.gov>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <1495477109.24649.6.camel@tycho.nsa.gov>
 <20170522182350.GC12310@julius.enp8s0.d30>
 <CAAung+a72_qvAaFz+XCiFDvatZR4TwKcWDWYttW4Tzf1qT_n9g@mail.gmail.com>
 <1495478730.24649.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-22 at 14:45 -0400, Stephen Smalley wrote:
> On Mon, 2017-05-22 at 11:32 -0700, Chris O'Neil wrote:
> > On Mon, May 22, 2017 at 11:23 AM, Dominick Grift <dac.override@gmai
> > l.
> > com> wrote:
> > > On Mon, May 22, 2017 at 02:18:29PM -0400, Stephen Smalley wrote:
> > > > On Mon, 2017-05-22 at 09:29 -0700, Chris O'Neil wrote:
> > > > > Hi, running latest RHEL 7.3 ... struggling with an SELinux
> > > > > issue
> > > > > related
> > > > > to Apache httpd that I just can't figure out.  I have always
> > > > > been
> > > > > able
> > > > > to tune policy or alter a boolean, this one has me stumped!
> > > > > 
> > > > > What I am trying to do: I am trying to deploy a simple, 3
> > > > > line
> > > > > CGI
> > > > > script in /var/www/cgi-bin/.  Runs fine with enforcement
> > > > > disabled
> > > > > (see
> > > > > output below).  My custom policy for Apache (see below) comes
> > > > > from my
> > > > > EL6 environment.
> > > > > 
> > > > > The normal setroubleshooting tools don't help, as there is
> > > > > only
> > > > > a
> > > > > single
> > > > > line in audit.log (of type=SELINUX_ERR)
> > > > > 
> > > > > This is not happening on latest RHEL 6.9 ...
> > > > > 
> > > > > Might be related to systemd?  I don't see any
> > > > > "NoNewPrivileges"
> > > > > directives inside /etc/systemd/ though ... weird!
> > > > 
> > > > Is the filesystem mounted nosuid?
> > > 
> > > If selinux also uses that message for that scenario then i find
> > > that confusing since the message, to me, implies that the issue
> > > can
> > > be find by adding a type bounds, but i don't think that would
> > > work
> > > for nosuid mounted slices
> > 
> > Stephen ... /var/www/ was mounted with the "nosuid" option.  I
> > forgot
> > about that ... if I remember correctly, when "nosuid" is set on a
> > mounted FS, SELinux trans will fail under this condition.  This bit
> > me
> > before, years ago... and I forgot about it.
> 
> I'm still puzzled though, because the transition shouldn't fail
> altogether; it should just fall back to staying in httpd_t instead of
> httpd_sys_script_t.  You'd get the log message but then it would just
> proceed under the old domain.

For example, on Fedora:
$ cat /var/www/cgi-bin/foo.cgi
#!/bin/sh
echo "Content-type: text/plain"
echo ""
id -Z
exit 0
$ curl localhost/cgi-bin/foo.cgi
system_u:system_r:httpd_sys_script_t:s0
$ sudo mount --bind /var/www /var/www
$ mount -o remount,nosuid,bind /var/www /var/www
$ sudo service httpd restart
$ curl localhost/cgi-bin/foo.cgi
system_u:system_r:httpd_t:s0
$ sudo umount /var/www
$ sudo ausearch -m SELINUX_ERR,AVC -ts recent
time->Mon May 22 15:03:56 2017
type=PROCTITLE msg=audit(1495479836.876:5483):
proctitle=2F62696E2F7368002F7661722F7777772F6367692D62696E2F666F6F2E636
769
type=PATH msg=audit(1495479836.876:5483): item=2 name="/lib64/ld-linux-
x86-64.so.2" inode=2623178 dev=fd:01 mode=0100755 ouid=0 ogid=0
rdev=00:00 obj=system_u:object_r:ld_so_t:s0 nametype=NORMAL
type=PATH msg=audit(1495479836.876:5483): item=1 name="/bin/sh"
inode=2646852 dev=fd:01 mode=0100755 ouid=0 ogid=0 rdev=00:00
obj=system_u:object_r:shell_exec_t:s0 nametype=NORMAL
type=PATH msg=audit(1495479836.876:5483): item=0 name="/var/www/cgi-
bin/foo.cgi" inode=538621 dev=fd:01 mode=0100755 ouid=0 ogid=0
rdev=00:00 obj=unconfined_u:object_r:httpd_sys_script_exec_t:s0
nametype=NORMAL
type=CWD msg=audit(1495479836.876:5483): cwd="/var/www/cgi-bin"
type=EXECVE msg=audit(1495479836.876:5483): argc=2 a0="/bin/sh"
a1="/var/www/cgi-bin/foo.cgi"
type=SYSCALL msg=audit(1495479836.876:5483): arch=c000003e syscall=59
success=yes exit=0 a0=560095ae07e8 a1=560095ae3d00 a2=560095ae3d18 a3=8
items=3 ppid=10885 pid=10925 auid=4294967295 uid=48 gid=48 euid=48
suid=48 fsuid=48 egid=48 sgid=48 fsgid=48 tty=(none) ses=4294967295
comm="foo.cgi" exe="/usr/bin/bash" subj=system_u:system_r:httpd_t:s0
key=(null)
type=SELINUX_ERR msg=audit(1495479836.876:5483):
op=security_bounded_transition seresult=denied
oldcontext=system_u:system_r:httpd_t:s0
newcontext=system_u:system_r:httpd_sys_script_t:s0

So I don't get a hard failure; it logs the error but just devolves to
staying in httpd_t.

Can you reproduce the above on your RHEL7.3 system?

> 
> > Everything is working as expected now.  If I want to mitigate some
> > risk, and still use "nosuid" for /var/www/ ....  I'll need to split
> > /var/www/cgi-bin away from /var/www/ ...
> 
> The other alternative would be to use typebounds, but that likely
> wouldn't be straightforward.
> 
> > 
> > Thank you both for your time and help
> > -chris
