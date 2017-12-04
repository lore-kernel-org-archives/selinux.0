Message-ID: <1512405482.20988.32.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 04 Dec 2017 11:38:02 -0500
In-Reply-To: <CAPMH7--Sow6Pvkti+Dk_yL67CANPSZojRuAvGk8a2-dPonKxPw@mail.gmail.com>
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
 <1512402030.20988.22.camel@tycho.nsa.gov>
 <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
 <1512403784.20988.27.camel@tycho.nsa.gov>
 <CAPMH7--Sow6Pvkti+Dk_yL67CANPSZojRuAvGk8a2-dPonKxPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-12-04 at 22:04 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> Thanks alot for the help. 
> 
> I got the issue. Its due to the problem in /etc/pam.d/sshd file.
> 
> After fixing this, now is working fine. Thanks alot once again.

Ok, can you explain what exactly what wrong in your /etc/pam.d/sshd
file, so that if someone else encounters this behavior in the future,
they can find a solution in the list archives?

> 
> On Mon, Dec 4, 2017 at 9:39 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Mon, 2017-12-04 at 21:31 +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > I got the below logs from the file .Can you please if these logs
> > are
> > > fine or not :
> > >
> > > journalctl | grep selinux
> > > Dec 05 02:55:46 localhost.localdomain kernel: EVM:
> > security.selinux
> > > Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> > > type=USER_START msg=audit(1512402970.129:107): pid=7145 uid=0
> > auid=0
> > > ses=2 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > msg='op=PAM:session_open
> > >
> > grantors=pam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_key
> > in
> > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209
> > > addr=10.97.7.209 terminal=ssh res=success'
> > > Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> > > type=USER_START msg=audit(1512402970.131:108): pid=7568 uid=0
> > auid=0
> > > ses=3 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > msg='op=PAM:session_open
> > >
> > grantors=pam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_key
> > in
> > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209
> > > addr=10.97.7.209 terminal=ssh res=success'
> > >
> > > Please let me know if any comments are there.
> > 
> > Those are normal.  Check journalctl and /var/log/secure for any
> > errors
> > from sshd.
> > Also try the selinuxdefcon command I mentioned.
> > 
> > >
> > > On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.go
> > v>
> > > wrote:
> > > > On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
> > > > > Hi All,
> > > > >
> > > > > Thanks for the information.
> > > > >
> > > > > But after resetting the semanage User/login, and moving the
> > > > targeted
> > > > > folder to old one and then install the default target. then
> > also
> > > > its
> > > > > still showing the 
> > > > > Id context as context=system_u:system_r:unconfined_t:s0-
> > > > s0:c0.c1023.
> > > > >
> > > > > What I observed is after changing the permission using
> > semanage
> > > > > command also, its still showing the system_u:system_r. 
> > > > >
> > > > > Check the semanage login/User output :
> > > > >
> > > > > semanage login -l
> > > > >
> > > > > Login Name           SELinux User         MLS/MCS Range     
> >  
> > > > > Service
> > > > >
> > > > > __default__          unconfined_u         s0-s0:c0.c1023     
> >  *
> > > > > root                 unconfined_u         s0-s0:c0.c1023     
> >  *
> > > > > system_u             system_u             s0-s0:c0.c1023     
> >  *
> > > > >
> > > > >
> > > > > semanage user -l
> > > > >
> > > > >                 Labeling   MLS/       MLS/                   
> >    
> > > >   
> > > > > SELinux User    Prefix     MCS Level  MCS Range             
> >    
> > > >    
> > > > > SELinux Roles
> > > > >
> > > > > guest_u         user       s0         s0                     
> >    
> > > >  
> > > > >  guest_r
> > > > > root            user       s0         s0-s0:c0.c1023         
> >    
> > > >  
> > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > staff_u         user       s0         s0-s0:c0.c1023         
> >    
> > > >  
> > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > sysadm_u        user       s0         s0-s0:c0.c1023         
> >    
> > > >  
> > > > >  sysadm_r
> > > > > system_u        user       s0         s0-s0:c0.c1023         
> >    
> > > >  
> > > > >  system_r unconfined_r
> > > > > unconfined_u    user       s0         s0-s0:c0.c1023         
> >    
> > > >  
> > > > >  system_r unconfined_r
> > > > > user_u          user       s0         s0                     
> >    
> > > >  
> > > > >  user_r
> > > > > xguest_u        user       s0         s0                     
> >    
> > > >  
> > > > >  xguest_r
> > > > >
> > > > >
> > > > > Looks like its related to some other issue. What you think
> > about
> > > > > this.
> > > >
> > > > Do you have any relevant error messages in /var/log/secure or
> > > > journalctl -rb?  Look for anything that refers to selinux or
> > > > context.
> > > >
> > > > I'm guessing that pam_selinux is unable to determine a valid
> > > > context
> > > > for your login for some reason, and this is causing it to fall
> > back
> > > > to
> > > > this one.  Or something like that.
> > > >
> > > > You could try to emulate this process via selinuxdefcon,
> > although
> > > > I'm
> > > > not sure how closely it matches pam_selinux anymore.  Sample
> > usage:
> > > >
> > > > 1. See what context sshd is running in.
> > > >
> > > > ps -eZ | grep sshd
> > > >
> > > > It should be:
> > > > system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > >
> > > > 2. Run selinuxdefcon to compute the default context for root
> > when
> > > > logging in from sshd:
> > > >
> > > > # Second argument should be whatever was shown by ps -eZ | grep
> > > > sshd
> > > > above.
> > > > selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123
> > > >
> > > > It should be:
> > > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > >
> > > >
> > > >
> > >
> > >
> > >
> > > -- 
> > >
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > 
> 
> 
> 
> -- 
> 
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
