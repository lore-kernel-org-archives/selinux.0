Subject: Re: SELinux and SSH Timers ?...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252009947.13634.203.camel@moss-pluto.epoch.ncsc.mil>
References: <4A996106.4060604@martinorr.name>
	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9BCE45.7060704@martinorr.name>
	 <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name>
	 <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9E6406.5000501@martinorr.name>
	 <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9F90B1.3000908@martinorr.name>
	 <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0731CB89@de01exm68.ds.mot.com>
	 <1252009947.13634.203.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Sep 2009 07:49:04 -0400
Message-Id: <1252064944.13634.207.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-09-03 at 16:32 -0400, Stephen Smalley wrote:
> On Thu, 2009-09-03 at 16:17 -0400, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> > 
> > I have defined policy such that user_t cannot 'write' to certain
> > files/directories, e.g.  /etc/passwd.
> > 
> > I have Selinux Strict policy running in "Permissive" Mode, and lets just
> > say I am not at liberty to run it in "Enforcing" mode.
> > 
> > I also have  /selinux/avc/cache_threshold set to the default  "512".
> > 
> > And to test that my policy works, I SSH-login as a user "test" who has
> > default context  user_u:user_r:user_t
> > And I attempt to "vi /etc/passwd".
> > 
> > Given the above conditions: 
> > - I understand that SELinux will (and does) report a deny into audit.log
> > the first time I attempt the "vi /etc/passwd".
> > 
> > - The next time I do "vi /etc/passwd" within the same SSH-session, it
> > does NOT log the deny! I understand this is because of the Permissive
> > Mode + the cache_threshold value.
> > 
> > - If I exit my SSH session, and then create a new SSH-session and login
> > again with user "test", and then "vi /etc/passwd" again, I thought I
> > should see a deny in the audit.log ? Since this is a new SSH-Session...
> > But I DON'T see it ???
> 
> No.  In permissive mode, when the denial is encountered, the AVC adds
> that denied permission into the allowed vector in the corresponding AVC
> cache entry so that subsequent denials do not get logged.  It remains
> there until something causes the entry to be evicted, whether that is a
> due to a policy reload, changing a boolean, toggling enforcing mode, or
> just needing to reclaim an entry over time.  It doesn't have anything to
> do with ssh sessions.
> 
> You can force an AVC reset at any time by reloading policy, changing a
> boolean, or toggling enforcing mode.  Or you can set the threshold low
> to cause nodes to get reclaimed quickly for reuse (that sets the upper
> limit on the number of nodes to be used by the AVC).  Or you could just
> patch your kernel to _not_ add the denied permission to the AVC in the
> first place.

What kernel version are you using?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
