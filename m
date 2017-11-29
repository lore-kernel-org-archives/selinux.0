Date: Wed, 29 Nov 2017 10:29:45 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <291642867.19424177.1511969385007.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Aman, 

----- Original Message -----
> From: "Aman Sharma" <amansh.sharma5@gmail.com>
> To: "Stephen Smalley" <sds@tycho.nsa.gov>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Sent: Wednesday, November 29, 2017 10:17:19 AM
> Subject: Re: Fwd: Qwery regarding Selinux Change Id context
> 
> Hi Stephen,
> 
> I tried all the three command i.e.
> semanage export > localchanges
> 
> semanage login -D
> semanage user -D
> 
> Then I reboot the system and after reboot , still its showing the root User
> as Same id context i.e.
> 
> *id*
> *uid=0(root) gid=0(root) groups=0(root)
> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> 
> * id -Z*
> *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> 

Are you using a 3rd party ssh client?

> 
> Also check the below output :
> *semanage user -l*
> 
> *                Labeling   MLS/       MLS/                          *
> *SELinux User    Prefix     MCS Level  MCS Range
> SELinux Roles*
> 
> *guest_u         user       s0         s0
>  guest_r*
> *root            user       s0         s0-s0:c0.c1023
>  staff_r sysadm_r system_r unconfined_r*
> *staff_u         user       s0         s0-s0:c0.c1023
>  staff_r sysadm_r system_r unconfined_r*
> *sysadm_u        user       s0         s0-s0:c0.c1023
>  sysadm_r*
> *system_u        user       s0         s0-s0:c0.c1023
>  system_r unconfined_r*
> *unconfined_u    user       s0         s0-s0:c0.c1023
>  system_r unconfined_r*
> *user_u          user       s0         s0
>  user_r*
> *xguest_u        user       s0         s0
>  xguest_r*
> *[root@cucm ~]# semanage login -l*
> 
> *Login Name           SELinux User         MLS/MCS Range        Service*
> 
> *__default__          unconfined_u         s0-s0:c0.c1023       **
> *root                 unconfined_u         s0-s0:c0.c1023       **
> *system_u             system_u             s0-s0:c0.c1023       **
> 
> *Please let me know your comments on this.*
> 
> *Thanks*
> *Aman*
> 
> On Wed, Nov 29, 2017 at 8:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Wed, 2017-11-29 at 20:11 +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > Thanks for the reply.
> > >
> > > Can you please let me know how to delete all local customizations
> > > (via semanage or manually) and revert
> > > to a default policy.
> >
> > First, save any local customizations in case you want to restore them
> > later:
> > semanage export > localchanges
> >
> > Then, delete them:
> > semanage login -D
> > semanage user -D
> >
> > Then logout and log back in.
> >
> > >
> > > Otherwise the output of semanage login -l and semanage user -l  :
> > >
> > > semanage user -l
> > >
> > >                 Labeling   MLS/       MLS/
> > > SELinux User    Prefix     MCS Level  MCS Range
> > > SELinux Roles
> > >
> > > admin_u         user       s0         s0-s0:c0.c1023
> > >  sysadm_r system_r
> > > guest_u         user       s0         s0
> > >  guest_r
> > > root            user       s0         s0-s0:c0.c1023
> > >  staff_r sysadm_r
> > > specialuser_u   user       s0         s0
> > >  sysadm_r system_r
> > > staff_u         user       s0         s0-s0:c0.c1023
> > >  staff_r sysadm_r system_r
> > > sysadm_u        user       s0         s0-s0:c0.c1023
> > >  sysadm_r
> > > system_u        user       s0         s0-s0:c0.c1023
> > >  system_r
> > > unconfined_u    user       s0         s0-s0:c0.c1023
> > >  system_r unconfined_r
> > > user_u          user       s0         s0
> > >  user_r
> > > xguest_u        user       s0         s0
> > >  xguest_r
> > >
> > >
> > >  semanage login -l
> > >
> > > Login Name           SELinux User         MLS/MCS Range
> > > Service
> > >
> > > __default__          sysadm_u             s0-s0:c0.c1023       *
> > > ccmservice           specialuser_u        s0                   *
> > > cucm                 admin_u              s0-s0:c0.c1023       *
> > > drfkeys              specialuser_u        s0                   *
> > > drfuser              specialuser_u        s0                   *
> > > informix             specialuser_u        s0                   *
> > > pwrecovery           specialuser_u        s0                   *
> > > root                 sysadm_u             s0-s0:c0.c1023       *
> > > sftpuser             specialuser_u        s0                   *
> > > system_u             sysadm_u             s0-s0:c0.c1023       *
> > >
> > > Please let me know if any comments are there.
> > >
> > > Thanks
> > > Aman
> > >
> > > On Wed, Nov 29, 2017 at 7:21 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > wrote:
> > > > On Wed, 2017-11-29 at 09:33 +0530, Aman Sharma wrote:
> > > > > Hi Stephen,
> > > > >
> > > > > Below is the output of command :
> > > > >
> > > > >  sestatus -v output
> > > > > SELinux status:                 enabled
> > > > > SELinuxfs mount:                /sys/fs/selinux
> > > > > SELinux root directory:         /etc/selinux
> > > > > Loaded policy name:             targeted
> > > > > Current mode:                   enforcing
> > > > > Mode from config file:          permissive
> > > > > Policy MLS status:              enabled
> > > > > Policy deny_unknown status:     allowed
> > > > > Max kernel policy version:      28
> > > > >
> > > > > Process contexts:
> > > > > Current context:
> > > > system_u:system_r:unconfined_t:s0-
> > > > > s0:c0.c1023
> > > > > Init context:                   system_u:system_r:init_t:s0
> > > > > /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-
> > > > > s0:c0.c1023
> > > > >
> > > > > File contexts:
> > > > > Controlling terminal:
> > > >  system_u:object_r:sshd_devpts_t:s0
> > > > > /etc/passwd
> > > >  system_u:object_r:passwd_file_t:s0
> > > > > /etc/shadow                     system_u:object_r:shadow_t:s0
> > > > > /bin/bash                       system_u:object_r:shell_exec_t:s0
> > > > > /bin/login                      system_u:object_r:login_exec_t:s0
> > > > > /bin/sh                         system_u:object_r:bin_t:s0 ->
> > > > > system_u:object_r:shell_exec_t:s0
> > > > > /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> > > > > /sbin/init                      system_u:object_r:bin_t:s0 ->
> > > > > system_u:object_r:init_exec_t:s0
> > > > > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> > > > > /lib/libc.so.6                  system_u:object_r:lib_t:s0 ->
> > > > > system_u:object_r:lib_t:s0
> > > > > /lib/ld-linux.so.2              system_u:object_r:lib_t:s0 ->
> > > > > system_u:object_r:ld_so_t:s0
> > > > >
> > > > > Also I am using ssh session for login.
> > > > >
> > > > > Please let me know how to change id command context to
> > > > unconfined_u
> > > > > or Sysadm_u.
> > > >
> > > > So from your earlier message, it is clear that you (or someone
> > > > else)
> > > > has heavily customized your semanage login and user mappings from
> > > > the
> > > > stock targeted policy.  The question is why, and whether you
> > > > want/need
> > > > to retain any of those customizations.  If not, then you could just
> > > > delete all local customizations (via semanage or manually) and
> > > > revert
> > > > to a stock policy.
> > > >
> > > > If you do need to retain some of those customizations, then please
> > > > show
> > > > your current semanage login -l and semanage user -l output since
> > > > you
> > > > said you ran some further semanage commands after the last output
> > > > you
> > > > showed.
> > > >
> > > >
> > >
> > >
> > >
> > > --
> > >
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >
> 
> 
> 
> --
> 
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> 

-- 
Simon Sekidde
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
