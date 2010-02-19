Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A780DE6@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780280@EUSAACMS0703.eamcs.ericsson.se>
	 <1266437939.4945.132.camel@moss-pluto.epoch.ncsc.mil>
	 <1266438301.4945.134.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802A0@EUSAACMS0703.eamcs.ericsson.se>
	 <1266438910.4945.137.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7802D6@EUSAACMS0703.eamcs.ericsson.se>
	 <1266440973.4945.142.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780310@EUSAACMS0703.eamcs.ericsson.se>
	 <1266442158.4945.144.camel@moss-pluto.epoch.ncsc.mil>
	 <1266442637.4945.147.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78036F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266508987.21209.45.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780863@EUSAACMS0703.eamcs.ericsson.se>
	 <1266515620.21209.47.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A7808E8@EUSAACMS0703.eamcs.ericsson.se>
	 <1266590959.32011.43.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780DE6@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Fri, 19 Feb 2010 12:46:15 -0500
Message-Id: <1266601575.32011.83.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-19 at 10:29 -0500, Alan Rouse wrote:
> > ls -lR /etc/selinux/$SELINUXTYPE
> > strace load_policy
> 
> =======================================================================
> . /etc/selinux/config
> ls -lR /etc/selinux/$SELINUXTYPE
> =======================================================================
> /etc/selinux/refpolicy-standard:
> total 28
> -rw-r--r--. 1 root root 2029 Oct 19 17:09 booleans

What does this file contain?  It shouldn't exist at all with
modular/managed policy; it was the legacy way of providing
distribution-shipped custom boolean definitions with monolithic policy.
Delete it or put SETLOCALDEFS=0 in your /etc/selinux/config to ignore
it.

> /etc/selinux/refpolicy-standard/modules/active:
> total 3936
> -rw-r--r--. 1 root root   20377 Feb 18 16:36 base.pp
> -rw-------. 1 root root      32 Feb 18 16:36 commit_num
> -rw-------. 1 root root  139886 Feb 18 16:36 file_contexts
> -rw-r--r--. 1 root root    2663 Feb 18 16:36 file_contexts.homedirs
> -rw-------. 1 root root  142369 Feb 18 16:36 file_contexts.template
> -rw-------. 1 root root    2483 Feb 18 16:36 homedir_template
> drwx------. 2 root root   12288 Feb 18 16:36 modules
> -rw-------. 1 root root       0 Feb 18 16:36 netfilter_contexts
> -rw-r--r--. 1 root root 3687284 Feb 18 16:36 policy.kern
> -rw-------. 1 root root      47 Feb 18 16:36 seusers.final
> -rw-------. 1 root root     143 Feb 18 16:36 users_extra

Instead you should have a booleans.local file in this subdirectory if
you have run setsebool -P on any boolean.  Try running setsebool -P
init_upstart=1 again for me and check whether a booleans.local file was
created under modules/active, please?  If not, strace the setsebool
command for me.  That might be large, so make it an attachment.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
