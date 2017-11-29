Message-ID: <1511971345.10464.14.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 29 Nov 2017 11:02:25 -0500
In-Reply-To: <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 21:26 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> The output of semanage export is :
> 
> cat localchanges 
> boolean -D
> login -D
> interface -D
> user -D
> port -D
> node -D
> fcontext -D
> module -D
> boolean -m -1 domain_kernel_load_modules
> boolean -m -1 selinuxuser_ping
> boolean -m -1 ssh_sysadm_login
> boolean -m -1 tomcat_can_network_non_http_port
> port -a -t tomcat_shutdown_port_t -p tcp 8005
> port -a -t ils_port_t -p tcp 8006
> port -a -t clm_port_t -p tcp 8500
> port -a -t clm_port_t -p udp 8500
> port -a -t snmp_port_t -p udp 61441
> fcontext -a -f a -t tomcat_t '/home/tomcat(/.*)?'
> fcontext -a -f a -t db_t '/home/informix(/.*)?'
> fcontext -a -f a -t ipsec_exec_t '/root/.security/ipsec(/.*)?'
> fcontext -a -f a -t tomcat_exec_t
> '/root/.security/tomcat/tomcat_diagnostics.sh'
> module -d unconfined

Hmmm...someone disabled the unconfined module on your system?
So if you want to go back to using unconfined, you ought to re-enable
that, ala semodule -e unconfined.  It looks like someone locked down
that system and was trying to effectively apply a "strict" policy, but
it was left in a broken state.

> 
> 
> On Wed, Nov 29, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > I tried all the three command i.e.
> > > semanage export > localchanges
> > >
> > > semanage login -D
> > > semanage user -D
> > >
> > > Then I reboot the system and after reboot , still its showing the
> > > root User as Same id context i.e. 
> > >
> > > id
> > > uid=0(root) gid=0(root) groups=0(root)
> > > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> > >
> > >  id -Z
> > > system_u:system_r:unconfined_t:s0-s0:c0.c1023
> > 
> > That's interesting.  So what else does semanage export show now as
> > local changes?
> > 
> > > Also check the below output :
> > > semanage user -l
> > >
> > >                 Labeling   MLS/       MLS/                       
> >   
> > > SELinux User    Prefix     MCS Level  MCS Range                 
> >    
> > > SELinux Roles
> > >
> > > guest_u         user       s0         s0                         
> >  
> > >  guest_r
> > > root            user       s0         s0-s0:c0.c1023             
> >  
> > >  staff_r sysadm_r system_r unconfined_r
> > > staff_u         user       s0         s0-s0:c0.c1023             
> >  
> > >  staff_r sysadm_r system_r unconfined_r
> > > sysadm_u        user       s0         s0-s0:c0.c1023             
> >  
> > >  sysadm_r
> > > system_u        user       s0         s0-s0:c0.c1023             
> >  
> > >  system_r unconfined_r
> > > unconfined_u    user       s0         s0-s0:c0.c1023             
> >  
> > >  system_r unconfined_r
> > > user_u          user       s0         s0                         
> >  
> > >  user_r
> > > xguest_u        user       s0         s0                         
> >  
> > >  xguest_r
> > > [root@cucm ~]# semanage login -l
> > >
> > > Login Name           SELinux User         MLS/MCS Range       
> > > Service
> > >
> > > __default__          unconfined_u         s0-s0:c0.c1023       *
> > > root                 unconfined_u         s0-s0:c0.c1023       *
> > > system_u             system_u             s0-s0:c0.c1023       *
> > >
> > > Please let me know your comments on this.
> > >
> > > Thanks
> > > Aman
> > 
> 
> 
> 
> -- 
> 
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
