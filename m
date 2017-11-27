Message-ID: <1511798379.23941.6.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 27 Nov 2017 10:59:39 -0500
In-Reply-To: <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-11-24 at 10:47 +0530, Aman Sharma wrote:
> 
> 
> Hi All,
> 
> Currently Working on Cent OS 7.3 and login as a root User and my Id
> command output is :
> 
> id
> uid=0(root) gid=0(root) groups=0(root)
> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> 
> I want to change System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> or unconfined_u:unconfined_r. 
> 
> Also showing the output of following command :
> 
> semanage user -l
> 
>                 Labeling   MLS/       MLS/                          
> SELinux User    Prefix     MCS Level  MCS Range                     
> SELinux Roles
> 
> admin_u         user       s0         s0-s0:c0.c1023               
>  sysadm_r system_r
> guest_u         user       s0         s0                           
>  guest_r
> root            user       s0         s0-s0:c0.c1023               
>  staff_r sysadm_r
> specialuser_u   user       s0         s0                           
>  sysadm_r system_r
> staff_u         user       s0         s0-s0:c0.c1023               
>  staff_r sysadm_r system_r
> sysadm_u        user       s0         s0-s0:c0.c1023               
>  sysadm_r
> system_u        user       s0         s0-s0:c0.c1023               
>  system_r
> unconfined_u    user       s0         s0-s0:c0.c1023               
>  system_r unconfined_r
> user_u          user       s0         s0                           
>  user_r
> xguest_u        user       s0         s0                           
>  xguest_r
> 
> 
>  semanage login -l
> 
> Login Name           SELinux User         MLS/MCS Range       
> Service
> 
> __default__          sysadm_u             s0-s0:c0.c1023       *
> ccmservice           specialuser_u        s0                   *
> cucm                 admin_u              s0-s0:c0.c1023       *
> drfkeys              specialuser_u        s0                   *
> drfuser              specialuser_u        s0                   *
> informix             specialuser_u        s0                   *
> pwrecovery           specialuser_u        s0                   *
> root                 sysadm_u             s0-s0:c0.c1023       *
> sftpuser             specialuser_u        s0                   *
> system_u             sysadm_u             s0-s0:c0.c1023       *
> 
> 
> Can anybody Please help me.

What is your sestatus -v output?  How are you logging in (console, gdm,
ssh, ...)?

You don't appear to be running the default policy, or if you are,
someone has heavily customized your user and login mappings.
