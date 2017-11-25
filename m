Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAPHPRMN010163
 for <selinux@tycho.nsa.gov>; Sat, 25 Nov 2017 12:25:27 -0500
Date: Sat, 25 Nov 2017 12:25:19 -0500 (EST)
From: Simon Sekidde <ssekidde@redhat.com>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: Ravi Kumar <nxp.ravi@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <1586230338.18867075.1511630719751.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPMH7-9UzFWtpCbJwkh5yvaq7G+wPMsB68gzvjpNVgSNn3j76g@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <CACikiw0K0ospvKt-midzSPYQegd3GR46mVjhwiPc3eUULV4oUg@mail.gmail.com>
 <CAPMH7-9UzFWtpCbJwkh5yvaq7G+wPMsB68gzvjpNVgSNn3j76g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Aman Sharma" <amansh.sharma5@gmail.com>
> To: "Ravi Kumar" <nxp.ravi@gmail.com>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Sent: Friday, November 24, 2017 2:09:05 AM
> Subject: Re: Qwery regarding Selinux Change Id context
> 
> Hi Ravi,
> 
> Thanks for your reply but SSH and Sysadm_login is already enabled.
> 
> Actually I need to change the root context
> from*System_u:system_r:unconfined_t
> to sysadm_u:sysadm_r or **unconfined_u:**unconfined_r**.*
> 
> *I found one command (**runcon
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash**) but that
> command will not work after reboot . Is there any parmanent solution for
> this.*
> 

It should be unconfined by default if you are running policy in targeted mode 

 # cat /etc/selinux/targeted/seusers 
root:unconfined_u:s0-s0:c0.c1023
system_u:system_u:s0-s0:c0.c1023
__default__:unconfined_u:s0-s0:c0.c1023

try something like `semanage login -m -s unconfined_u root; restorecon -RF /root` 


> On Fri, Nov 24, 2017 at 12:22 PM, Ravi Kumar <nxp.ravi@gmail.com> wrote:
> 
> > Based on the config  each type of login ( ssh ,shell  ) will have it own
> > role .  if this is just for testing you can try setting the  bool value  if
> > you are logging via ssh.
> >
> > setsebool -P ssh_sysadm_login 1
> >
> >
> >
> > Regards,
> > Ravi
> >
> > On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma <amansh.sharma5@gmail.com>
> > wrote:
> >
> >>
> >>
> >> Hi All,
> >>
> >> Currently Working on Cent OS 7.3 and login as a root User and my Id
> >> command output is :
> >>
> >> *id*
> >> *uid=0(root) gid=0(root) groups=0(root)
> >> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> >>
> >> I want to change *System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> >> or **unconfined_u:**unconfined_r**. *
> >>
> >> *Also showing the output of following command :*
> >>
> >> *semanage user -l*
> >>
> >> *                Labeling   MLS/       MLS/                          *
> >> *SELinux User    Prefix     MCS Level  MCS Range
> >> SELinux Roles*
> >>
> >> *admin_u         user       s0         s0-s0:c0.c1023
> >>  sysadm_r system_r*
> >> *guest_u         user       s0         s0
> >>  guest_r*
> >> *root            user       s0         s0-s0:c0.c1023
> >>  staff_r sysadm_r*
> >> *specialuser_u   user       s0         s0
> >>  sysadm_r system_r*
> >> *staff_u         user       s0         s0-s0:c0.c1023
> >>  staff_r sysadm_r system_r*
> >> *sysadm_u        user       s0         s0-s0:c0.c1023
> >>  sysadm_r*
> >> *system_u        user       s0         s0-s0:c0.c1023
> >>  system_r*
> >> *unconfined_u    user       s0         s0-s0:c0.c1023
> >>  system_r unconfined_r*
> >> *user_u          user       s0         s0
> >>  user_r*
> >> *xguest_u        user       s0         s0
> >>  xguest_r*
> >>
> >>
> >> * semanage login -l*
> >>
> >> *Login Name           SELinux User         MLS/MCS Range        Service*
> >>
> >> *__default__          sysadm_u             s0-s0:c0.c1023       **
> >> *ccmservice           specialuser_u        s0                   **
> >> *cucm                 admin_u              s0-s0:c0.c1023       **
> >> *drfkeys              specialuser_u        s0                   **
> >> *drfuser              specialuser_u        s0                   **
> >> *informix             specialuser_u        s0                   **
> >> *pwrecovery           specialuser_u        s0                   **
> >> *root                 sysadm_u             s0-s0:c0.c1023       **
> >> *sftpuser             specialuser_u        s0                   **
> >> *system_u             sysadm_u             s0-s0:c0.c1023       **
> >>
> >>
> >> *Can anybody Please help me.*
> >>
> >> --
> >>
> >> Thanks
> >> Aman
> >> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >>
> >>
> >
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
