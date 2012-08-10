Message-ID: <1344626388.10631.82.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Fri, 10 Aug 2012 15:19:48 -0400
In-Reply-To: <20120810191111.GL2296@telvanni>
References: <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810143656.GF2296@telvanni>
	 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810154454.GH2296@telvanni>
	 <1344614902.10631.70.camel@moss-pluto.epoch.ncsc.mil>
	 <1344615485.10631.72.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810170008.GI2296@telvanni>
	 <1344622106.10631.75.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810184653.GK2296@telvanni>
	 <1344624930.10631.78.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810191111.GL2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 21:11 +0200, Ole Kliemann wrote:
> On Fri, Aug 10, 2012 at 02:55:30PM -0400, Stephen Smalley wrote:
> > > If you want hard numbers, use the attached script. First start 
> > > off in system_r:unconfined_r:unconfined_t. Run the script 
> > > somewhere, /tmp e.g. For proper average value computation you 
> > > need 'bc' installed, otherwise it's rounded but doesn't matter.
> > 
> > Triggers a ton of error messages in dmesg from SELinux about unmapped
> > security contexts?
> > 
> > > Then switch to choke_u:choke_r:choke_t. Run the script here. If 
> > > it's inconclusive, start uncommenting additional attributes in 
> > > choke/src/support/choke.spt.
> 
> Sorry, my mistake, got confused. Here's the right stuff now. 
> The script is in choke/test/

Well, that certainly yielded very different numbers but also lots of AVC
denials, all of which look like this:
time->Fri Aug 10 15:12:33 2012
type=SYSCALL msg=audit(1344625953.002:10135): arch=c000003e syscall=188
success=yes exit=0 a0=125a0e0 a1=311e81646b a2=125b5b0 a3=1d items=0
ppid=10903 pid=18574 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=pts0 ses=1 comm="chcon" exe="/usr/bin/chcon"
subj=choke_u:choke_r:choke_t key=(null)
type=AVC msg=audit(1344625953.002:10135): avc:  denied  { associate }
for  pid=18574 comm="chcon" name="9448e490-297f-4856-8022-da19d91db9a4"
dev="dm-2" ino=1706648 scontext=choke_u:object_r:choke9x55_t
tcontext=system_u:object_r:unconfined_t tclass=filesystem

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
