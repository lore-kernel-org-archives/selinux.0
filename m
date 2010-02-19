Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E316B05F@EUSAACMS0703.eamcs.ericsson.se>
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
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B05F@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Fri, 19 Feb 2010 16:37:14 -0500
Message-Id: <1266615434.32011.111.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-19 at 16:30 -0500, Alan Rouse wrote:
> Stephen wrote:
> > Why is it necessary to download and rebuild the source policy?  Did they build it as a monolithic policy?
> 
> Yes, the policy rpm from OpenSuse 11.2 is monolithic.
> 
> >> setsebool -P init_upstart=on
> >> setsebool -P xdm_sysadm_login=on
> >> setsebool -P xserver_object_manager=on
> > I think you only need the first boolean setting.
> > And we should likely introduce an ifdef for suse in refpolicy that always disables that 
> > transition so that you don't have to artificially turn on that boolean.
> 
> Ok
> 
> > It would be useful to see the raw audit message with what directory/file is being accessed.  
> > tmpfs_t indicates a tmpfs mount, which might mean you have a mislabeled tmpfs mount (e.g. 
> > /dev is a tmpfs mount that should be relabeled by rc.sysinit via restorecon -R /dev).
> 
> See attached raw audit messages from the most recent boot.

Can you move aside the audit.log, add the line below to the end
of /etc/audit/audit.rules, reboot, and then send the new audit.log?

-a exit,always -S chroot

That will turn on syscall auditing and should provide more complete
information, including PATH= and SYSCALL= records.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
