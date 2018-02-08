Message-ID: <1518098942.21656.17.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Callaway <matt.callaway@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 08 Feb 2018 09:09:02 -0500
In-Reply-To: <CALWSt-Q3Vcn1Vz9Huj_VJjQaBumdxET6s5L7YpUwrH9dNm0_PQ@mail.gmail.com>
References: <CALWSt-Q3Vcn1Vz9Huj_VJjQaBumdxET6s5L7YpUwrH9dNm0_PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Does selinux work with kernel namespaces?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-02-07 at 15:10 -0600, Matt Callaway wrote:
> Hello,
> 
> I am attempting to run Docker on CentOS 7.4 with selinux and kernel
> namespaces enabled. When I do so I observe an error that leads me to
> an issue filed in github and a kernel patch that suggests that the
> cause should be fixed in kernel 4.11+. Yet I cannot run docker
> containers in this fashion on a 4.15 kernel.
> 
> Should docker with selinux-enabled work on a 4.15.1 kernel on CentOS
> 7.4 with namespaces enabled?

(cc Dan Walsh for insight on docker)

I would say yes, although it seems you are using third party packages
for both your kernel and your docker rather than the CentOS packages,
and those are coming from two different sources, so it is hard to know
how those might interact.  Did you actually try just using the stock
CentOS kernel and docker first?

> 
> This might be a docker question, but the details I'll present below
> suggest it might be more appropriate for this forum.
> 
> Details about the host and environment:
> 
> [root@localhost ~]# uname -r
> 4.15.1-1.el7.elrepo.x86_64
> 
> [root@localhost ~]# cat /etc/redhat-release
> CentOS Linux release 7.4.1708 (Core)
> 
> [root@localhost ~]# docker --version
> Docker version 17.12.0-ce, build c97c6d6
> 
> This is the latest docker-ce package from Docker's repository:

Why are you using this package rather than the docker provided by
CentOS? Do you need specific functionality it provides that is lacking
in CentOS?

> [root@localhost ~]# repoquery -i docker-ce
> 
> Name        : docker-ce
> Version     : 17.12.0.ce
> Release     : 1.el7.centos
> Architecture: x86_64
> Size        : 128453687
> Packager    : Docker <support@docker.com>
> Group       : Tools/Docker
> URL         : https://www.docker.com
> Repository  : docker-ce-stable
> Summary     : The open-source application container engine
> Source      : docker-ce-17.12.0.ce-1.el7.centos.src.rpm
> 
> The kernel is 4.15.1 from ElRepo, because that seems to be the
> accepted way to get a 4.x kernel on CentOS, which I did because data
> suggested I needed at least 4.11+

By "data", do you mean the fact that the SELinux patch you cite below
wasn't included until 4.11?  But that patch in turn was a fix for a
patch that was first included in 4.8 (so it wasn't necessary/relevant
for kernels < 4.8, e.g. the stock CentOS kernel).  And all of that is
only relevant if performing context mounts within user namespaces.  

> 
> [root@localhost ~]# repoquery -i kernel-ml
> 
> Name        : kernel-ml
> Version     : 4.15.1
> Release     : 1.el7.elrepo
> Architecture: x86_64
> Size        : 204626242
> Packager    : Alan Bartlett <ajb@elrepo.org>
> Group       : System Environment/Kernel
> URL         : https://www.kernel.org/
> Repository  : elrepo-kernel
> Summary     : The Linux kernel. (The core of any Linux-based
> operating system.)
> Source      : kernel-ml-4.15.1-1.el7.elrepo.src.rpm
> 
> 
> Here we see selinux-enabled is true and userns-remap is set to
> default:
> 
> [root@localhost ~]# cat /etc/docker/daemon.json
> {
>   "debug": true,
>   "selinux-enabled": true,
>   "userns-remap": "default"
> }
> 
> [root@localhost ~]# docker info 2>&1 | grep -A3 Security
> Security Options:
>  seccomp
>   Profile: default
>  selinux
> 
> 
> So when I try it I get:
> 
> [root@localhost ~]# docker run hello-world
> docker: Error response from daemon: OCI runtime create failed:
> container_linux.go:296: starting container process caused
> "process_linux.go:301: running exec setns process for init caused
> \"exit status 40\"": unknown.
> 
> When running in Permissive mode I see a different error:
> 
> [root@localhost ~]# setenforce 0

Since you get the same error while enforcing but a different error in
permissive, that implies that there is a SELinux permission denial when
enforcing.  You should be able to see the specific denial by checking
journalctl for messages with "avc:  denied" (or if running auditd,
ausearch -m AVC,SELINUX_ERR).  However, since you still get an error
while permissive, that implies that there is still a separate error
that is not a SELinux permission denial.

> 
> [root@localhost ~]# docker run hello-world
> docker: Error response from daemon: OCI runtime create failed:
> container_linux.go:296: starting container process caused
> "process_linux.go:398: container init caused \"rootfs_linux.go:58:
> mounting \\\"devpts\\\" to rootfs
> \\\"/var/lib/docker/1001.1001/overlay2/6798981d1cf925a748187e0f2e9151
> f47bca9352457aa5b933a2bcb55eff9570/merged\\\"
> at
> \\\"/var/lib/docker/1001.1001/overlay2/6798981d1cf925a748187e0f2e9151
> f47bca9352457aa5b933a2bcb55eff9570/merged/dev/pts\\\"
> caused \\\"invalid argument\\\"\"": unknown.

You got an "invalid argument" from the mount, or EINVAL.
The patch you cited was instead fixing a case where EACCES (Permission
denied) was being returned and instead allowing that to happen for
specific whitelisted filesystem types.  The EINVAL cases in the SELinux
mount option processing code should have caused a kernel warning to be
logged in your dmesg or journalctl output with a SELinux: prefix. 
Absent that, I'm not sure SELinux is the culprit for this error.  A
quick way to check would be to disable SELinux altogether (edit
/etc/selinux/config to specify SELINUX=disabled by hand or via system-
config-selinux and reboot) and retry.  

> 
> 
> Looking around for these symptoms I find these references...
> 
> First message goes here:
> 
> https://github.com/moby/moby/issues/35336
> 
> Suggests the namespace.unpriv_enable=1 flag. I have already enabled
> that:
> 
> [root@localhost ~]# grep unpriv /boot/grub2/grub.cfg
> linux16 /vmlinuz-4.15.1-1.el7.elrepo.x86_64
> root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0
> console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto
> rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb
> quiet
> LANG=en_US.UTF-8 namespace.unpriv_enable=1
> 
> 
> Then I do setenforce 0 and we get the second devpts error which leads
> to:
> 
> https://github.com/opencontainers/runc/issues/1215
> 
> which leads to:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1401537
> 
> which leads to a kernel patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c
> ommit/?id=01593d3299a1cfdb5e08acf95f63ec59dd674906
> 
> I've since discovered via the author that that patch was included in
> kernel 4.11.
> 
> So... what am I missing? All signs suggest that this *should* work,
> and yet does not.

Can we back up?  Do you truly need to use docker-ce instead of the
CentOS docker?  If not, don't.  If so, what happened when you tried
using docker-ce on the stock CentOS kernel?  And can you confirm that
it is in fact SELinux that is preventing the operation above from
succeeding, as described above by disabling SELinux and retrying?
