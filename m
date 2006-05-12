Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4C50bRx029746
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 01:00:37 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4C50Q6C016349
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 05:00:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Rogelio Serrano" <rogelio.serrano@gmail.com>
Subject: Re: pam_namespace
Date: Fri, 12 May 2006 15:00:28 +1000
Cc: "Janak Desai" <janak@us.ibm.com>, Valdis.Kletnieks@vt.edu,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@epoch.ncsc.mil>
References: <200605051623.25533.russell@coker.com.au> <44633C0D.3060101@us.ibm.com> <a9951d2a0605112114t6ae048f1l64a5a9b6768c6dc5@mail.gmail.com>
In-Reply-To: <a9951d2a0605112114t6ae048f1l64a5a9b6768c6dc5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605121500.33442.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 12 May 2006 14:14, "Rogelio Serrano" <rogelio.serrano@gmail.com> 
wrote:
> > >If the user gains access to the real version of /tmp by calling umount()
> > > then you are probably correct.  If however the user gains access to the
> > > real version of /tmp by exploiting a buggy login program (maybe the
> > > login program has a bug that skips some PAM session modules), by being
> > > granted such access to the system by an intentional action of the
> > > sys-admin (just because the sys-admin gave them some privs that most
> > > users don't get that doesn't mean they are trusted), by remaining
> > > logged in since before the administrator enabled namespaces in the
> > > configuration, or any of the other possible methods then having a .inst
> > > directory with mode 000 will save you.
> >
> > How? If an ordinary user is able to get access to real /tmp he or she
> > will be able rename
>
> How could ordinary user access real /tmp if /home/user/tmp is mounted
> over the real /tmp and other entries of the /dev is also mounted over
> by dummy entries and the user is not allowed to create new device
> nodes?

We are not planning to change /dev and other things, although I don't think it 
makes much difference in this regard.  Without SE Linux the permission to 
mount file systems goes along with the permission to create device nodes, and 
with SE Linux the permission to umount file systems goes along with the 
permission to mount file systems.

As mentioned above users can access /tmp by possibly exploiting a bug in a 
login program (note that not all security bugs grant ultimate access, 
sometimes a series of bugs providing excessive privs may be used by an 
attacker), by being granted non-PI access to /tmp by the sys-admin (either 
mistakenly or intentionally), be keeping a login session open since before 
the sys-admin enabled the use of namespaces, and probably other ways that I 
didn't think of.

Also note that renaming the /tmp/.inst directory requires dac_override 
capability (root) as well as suitable SE Linux privs (which won't be granted 
to user processes or daemons).  It has two layers of defense, just the way we 
want it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
