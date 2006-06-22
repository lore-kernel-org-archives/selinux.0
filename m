Subject: Re: [PATCH] pam_namespace : allow use of X while polyinstantiating
	/tmp - v3
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Valdis.Kletnieks@vt.edu
Cc: Tomas Mraz <tmraz@redhat.com>, dwalsh@redhat.com, sgrubb@redhat.com,
        klaus@atsec.com, sds@tycho.nsa.gov, russell@coker.com.au,
        selinux@tycho.nsa.gov
In-Reply-To: <200606221539.k5MFdDSV004441@turing-police.cc.vt.edu>
References: <1150820592.31280.2.camel@localhost.localdomain>
	 <200606220735.k5M7ZOUI016994@turing-police.cc.vt.edu>
	 <1150965442.3351.7.camel@perun.kabelta.loc>
	 <200606221539.k5MFdDSV004441@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 14:05:48 -0400
Message-Id: <1150999548.30134.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-22 at 11:39 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 22 Jun 2006 10:37:22 +0200, Tomas Mraz said:
> 
> > > 	if (osighand == SIG_ERR) {
> > Of course it should be compared to SIG_ERR and not NULL. Thanks for
> > finding this.
> 
> OK, getting farther now. GDM comes up and I can login with a polyinstantiated
> copy of /tmp. :)
> 
> A few issues I ran into after I fixed that one:
> 
> 1) The current namespace.init:
> 
> if [ $1 = /tmp ]; then
>         if [ ! -f /.tmp/.X11-unix ]; then
> 
> Probably needs to be 'if [ ! -d /.tmp/.X11-unix'?
> 

ok. Will fix it in the next incarnation.

> 2) After a few login/logouts, I have in /etc/mtab:
> 
> none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0
> /tmp/.X11-unix /.tmp/.X11-unix none rw,bind 0 0
> /tmp/.X11-unix /.tmp/.X11-unix none rw,bind 0 0
> /tmp/.X11-unix /.tmp/.X11-unix none rw,bind 0 0

> /proc/mounts looks sane.  Probaby we need 'mount -n --bind' for this one.
> Otherwise, the "unmount everything at shutdown" spews messages for each
> attempted unmount.
> 

ok. Will fix it in the next incarnation.

> 3) I'm running in strict/permissive policy, and that whole script tosses
> zillions of AVC's because we're running in local_login_t which isn't
> allowed to play with xdm_tmp_t files and similar. Not sure what's supposed
> to happen here.

I have been testing using targeted policy in enforcing mode. I am not
sure about what needs to be done with strict policy as well. 

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
