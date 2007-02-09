Subject: Re: how to enable se linux for my app?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Greger <boss@gregerhaga.net>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <20070209202228.M65047@gregerhaga.net>
References: <20070209185428.M24608@gregerhaga.net>
	 <45CCC7B0.6080109@us.ibm.com>  <20070209202228.M65047@gregerhaga.net>
Content-Type: text/plain; charset=utf-8
Date: Fri, 09 Feb 2007 15:39:58 -0500
Message-Id: <1171053598.4975.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-09 at 22:25 +0200, Greger wrote:
> On Fri, 09 Feb 2007 13:12:48 -0600, Michael C Thompson wrote
> > Greger wrote:
> > > well just a quickie:
> > > I wrote an application, but can not run the linux executable nor libraries
> > > when selinux is activated. what command should i use to "include" the
> > > libraries and executable under selinux?
> > 
> > Its most likely a type enforcement issue. Your application need not 
> > be "SELinux aware" for it to execute at all. However, it must be 
> > labeled appropriately in the file system, with a type that is 
> > executable (e.g. bin_t). Common library types are lib_t and shlib_t.
> > 
> > What policy are you using (strict/targeted/custom)?
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to 
> > majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> > quotes as the message.
> hi, well not sure, 
> I have these options in the settings dialog:
> 1)"upprätthållande"( swedish) means sort of "maintained or 'protected' in english)
> 2)"tillåtande", which means "allowing" 
> 3)"inactiverad", inactivated.
> I'd like to have protection with the first option, but with that I can't run
> the app. So, what do I need to do on the executable and libs when I install
> them, to make them runnable?
> many thank's for any advice.

i.e. enforcing/permissive/disabled.  Those are system-wide settings, not
per-application.

What you should do is look at your audit logs (either /var/log/messages
if not running auditd or /var/log/audit/audit.log if running it) to see
the particular denials, and then we can decide how best to proceed with
your application.  Look for "avc:  denied" messages.  What is your base
distribution (e.g. Fedora Core 6?)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
