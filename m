Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com
In-Reply-To: <1156883110.22210.222.camel@moss-spartans.epoch.ncsc.mil>
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
	 <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil>
	 <1156880819.8075.14.camel@twoface.columbia.tresys.com>
	 <1156883110.22210.222.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 18:37:06 -0400
Message-Id: <1156891026.8075.21.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-29 at 16:25 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-29 at 15:46 -0400, Joshua Brindle wrote:
> > On Tue, 2006-08-29 at 15:37 -0400, Stephen Smalley wrote:
> > > On Tue, 2006-08-29 at 14:08 -0400, Joshua Brindle wrote:
> > > > I'm trying to use getpeercon() with a tcp stream socket over an ipsec
> > > > host2host connection and it isn't working, it always returns the context
> > > > of the local domain/socket:
> > > > 
> > > > 
> > > > [root@rawhide-clone ~]# runcon -t passwd_t ./server
> > > > server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255
> > > > 
> > > > [root@rawhide-clone ~]# runcon -t initrc_t ./server
> > > > server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255
> > > > 
> > > > the process connecting is unconfined_t
> > > > 
> > > > Am I doing something wrong or is something broken?
> > > 
> > > You didn't provide much information above.  Kernel version?  ipsec-tools
> > > version?  racoon version?  ipsec configuration?  setkey -D output?
> > > setkey -DP output?
> > 
> > Sorry,
> > 
> > Linux rawhide-clone 2.6.17-1.2586.fc6 #1 SMP Thu Aug 24 08:51:22 EDT
> > 2006 i686 i686 i386 GNU/Linux
> > 
> > ipsec-tools.i386                         0.6.5-3.1
> > 
> > [root@rawhide-clone ~]# setkey -D
> <snip>
> > [root@rawhide-clone ~]# setkey -D
> 
> One of those was supposed to be a setkey -DP.
> 

err, yea, i mispasted
[root@joker-rawhide-clone ~]# setkey -DP
10.1.13.104[any] 10.1.13.90[any] any
        in prio def ipsec
        esp/transport//require
        ah/transport//require
        created: Aug 15 08:25:20 2006  lastused: Aug 15 10:15:35 2006
        lifetime: 0(s) validtime: 0(s)
        spid=1192 seq=10 pid=10325
        refcnt=1
10.1.13.90[any] 10.1.13.104[any] any
        out prio def ipsec
        esp/transport//require
        ah/transport//require
        created: Aug 15 08:25:20 2006  lastused: Aug 15 10:15:35 2006
        lifetime: 0(s) validtime: 0(s)
        spid=1185 seq=9 pid=10325
        refcnt=1
10.1.13.104[any] 10.1.13.90[any] any
        fwd prio def ipsec
        esp/transport//require
        ah/transport//require
        created: Aug 15 08:25:20 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        spid=1202 seq=8 pid=10325
        refcnt=1
(per-socket policy)
        in none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1259 seq=7 pid=10325
        refcnt=1
(per-socket policy)
        in none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1243 seq=6 pid=10325
        refcnt=1
(per-socket policy)
        in none
        created: Aug 15 08:25:21 2006  lastused: Aug 15 11:03:34 2006
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1227 seq=5 pid=10325
        refcnt=1
(per-socket policy)
        in none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1211 seq=4 pid=10325
        refcnt=1
(per-socket policy)
        out none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1268 seq=3 pid=10325
        refcnt=1
(per-socket policy)
        out none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1252 seq=2 pid=10325
        refcnt=1
(per-socket policy)
        out none
        created: Aug 15 08:25:21 2006  lastused: Aug 15 11:03:34 2006
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1236 seq=1 pid=10325
        refcnt=1
(per-socket policy)
        out none
        created: Aug 15 08:25:21 2006  lastused:
        lifetime: 0(s) validtime: 0(s)
        security context doi: 1
        security context algorithm: 1
        security context length: 41
        security context: root:system_r:unconfined_t:s0-s0:c0.c255
        spid=1220 seq=0 pid=10325
        refcnt=1


> You did remember to specify a -ctx option when you added spd entries,
> right?
> 

I didn't add anything, I used system-config-network :) I'm pretty new to
ipsec actually so that was the only thing I could find on doing this in
Fedora. I found nothing on the selinux parts


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
