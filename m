Message-ID: <1511970015.10464.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 29 Nov 2017 10:40:15 -0500
In-Reply-To: <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> I tried all the three command i.e.
> semanage export > localchanges
> 
> semanage login -D
> semanage user -D
> 
> Then I reboot the system and after reboot , still its showing the
> root User as Same id context i.e. 
> 
> id
> uid=0(root) gid=0(root) groups=0(root)
> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> 
>  id -Z
> system_u:system_r:unconfined_t:s0-s0:c0.c1023

That's interesting.  So what else does semanage export show now as
local changes?

> Also check the below output :
> semanage user -l
> 
>                 Labeling   MLS/       MLS/                          
> SELinux User    Prefix     MCS Level  MCS Range                     
> SELinux Roles
> 
> guest_u         user       s0         s0                           
>  guest_r
> root            user       s0         s0-s0:c0.c1023               
>  staff_r sysadm_r system_r unconfined_r
> staff_u         user       s0         s0-s0:c0.c1023               
>  staff_r sysadm_r system_r unconfined_r
> sysadm_u        user       s0         s0-s0:c0.c1023               
>  sysadm_r
> system_u        user       s0         s0-s0:c0.c1023               
>  system_r unconfined_r
> unconfined_u    user       s0         s0-s0:c0.c1023               
>  system_r unconfined_r
> user_u          user       s0         s0                           
>  user_r
> xguest_u        user       s0         s0                           
>  xguest_r
> [root@cucm ~]# semanage login -l
> 
> Login Name           SELinux User         MLS/MCS Range       
> Service
> 
> __default__          unconfined_u         s0-s0:c0.c1023       *
> root                 unconfined_u         s0-s0:c0.c1023       *
> system_u             system_u             s0-s0:c0.c1023       *
> 
> Please let me know your comments on this.
> 
> Thanks
> Aman
