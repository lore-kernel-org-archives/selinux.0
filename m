Message-ID: <1512402030.20988.22.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>, Simon Sekidde <ssekidde@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 04 Dec 2017 10:40:30 -0500
In-Reply-To: <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
 <20171130201920.GA32637@julius.enp8s0.d30>
 <CAPMH7-9zGFSRz3qPJup2y8=zNo6X1dRgNf8gUWv=d+UK1EdO9A@mail.gmail.com>
 <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
 <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
 <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
> Hi All,
> 
> Thanks for the information.
> 
> But after resetting the semanage User/login, and moving the targeted
> folder to old one and then install the default target. then also its
> still showing the 
> Id context as context=system_u:system_r:unconfined_t:s0-s0:c0.c1023.
> 
> What I observed is after changing the permission using semanage
> command also, its still showing the system_u:system_r. 
> 
> Check the semanage login/User output :
> 
> semanage login -l
> 
> Login Name           SELinux User         MLS/MCS Range       
> Service
> 
> __default__          unconfined_u         s0-s0:c0.c1023       *
> root                 unconfined_u         s0-s0:c0.c1023       *
> system_u             system_u             s0-s0:c0.c1023       *
> 
> 
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
> 
> 
> Looks like its related to some other issue. What you think about
> this.

Do you have any relevant error messages in /var/log/secure or
journalctl -rb?  Look for anything that refers to selinux or context.

I'm guessing that pam_selinux is unable to determine a valid context
for your login for some reason, and this is causing it to fall back to
this one.  Or something like that.

You could try to emulate this process via selinuxdefcon, although I'm
not sure how closely it matches pam_selinux anymore.  Sample usage:

1. See what context sshd is running in.

ps -eZ | grep sshd

It should be:
system_u:system_r:sshd_t:s0-s0:c0.c1023

2. Run selinuxdefcon to compute the default context for root when
logging in from sshd:

# Second argument should be whatever was shown by ps -eZ | grep sshd
above.
selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123

It should be:
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
