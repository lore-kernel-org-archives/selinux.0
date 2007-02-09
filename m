From: "Greger" <boss@gregerhaga.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: how to enable se linux for my app?
Date: Sat, 10 Feb 2007 00:36:45 +0200
Message-Id: <20070209223449.M45949@gregerhaga.net>
In-Reply-To: <1171053598.4975.28.camel@moss-spartans.epoch.ncsc.mil>
References: <20070209185428.M24608@gregerhaga.net> <45CCC7B0.6080109@us.ibm.com>  <20070209202228.M65047@gregerhaga.net> <1171053598.4975.28.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 09 Feb 2007 15:39:58 -0500, Stephen Smalley wrote
> On Fri, 2007-02-09 at 22:25 +0200, Greger wrote:
> > On Fri, 09 Feb 2007 13:12:48 -0600, Michael C Thompson wrote
> > > Greger wrote:
> > > > well just a quickie:
> > > > I wrote an application, but can not run the linux executable nor libraries
> > > > when selinux is activated. what command should i use to "include" the
> > > > libraries and executable under selinux?
> > > 
> > > Its most likely a type enforcement issue. Your application need not 
> > > be "SELinux aware" for it to execute at all. However, it must be 
> > > labeled appropriately in the file system, with a type that is 
> > > executable (e.g. bin_t). Common library types are lib_t and shlib_t.
> > > 
> > > What policy are you using (strict/targeted/custom)?
> > > 
> > > --
> > > This message was distributed to subscribers of the selinux mailing list.
> > > If you no longer wish to subscribe, send mail to 
> > > majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> > > quotes as the message.
> > hi, well not sure, 
> > I have these options in the settings dialog:
> > 1)"upprätthållande"( swedish) means sort of "maintained or 'protected' in
english)
> > 2)"tillåtande", which means "allowing" 
> > 3)"inactiverad", inactivated.
> > I'd like to have protection with the first option, but with that I can't run
> > the app. So, what do I need to do on the executable and libs when I install
> > them, to make them runnable?
> > many thank's for any advice.
> 
> i.e. enforcing/permissive/disabled.  Those are system-wide settings, 
> not per-application.
> 
> What you should do is look at your audit logs (either /var/log/messages
> if not running auditd or /var/log/audit/audit.log if running it) to see
> the particular denials, and then we can decide how best to proceed with
> your application.  Look for "avc:  denied" messages.  What is your base
> distribution (e.g. Fedora Core 6?)?
yes, fc6, 
found this in /var/log/messages
Feb 10 02:35:41 localhost kernel: audit(1171067741.422:18): avc:  denied  {
execmod } for  pid=29429 comm="x" name="libqxrssapp.so" dev=dm-0 ino=2588491
scontext=user_u:system_r:unconfined_t:s0
tcontext=user_u:object_r:user_home_t:s0 tclass=file

qxrssapp is a library taht the application uses, the app is made of six
libraries plus the main func in the executable.


h
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> quotes as the message.


--
http://www.gregerhaga.net/
http://hack-space.biz/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
