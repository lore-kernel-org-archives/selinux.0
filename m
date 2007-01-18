Subject: Re: Current/Future Plans to Support Stacking LSM Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: casey@schaufler-ca.com, Tom Fortmann <tfortmann@xcapesolutions.net>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <45AF5539.2020608@novell.com>
References: <20070116184620.75850.qmail@web36608.mail.mud.yahoo.com>
	 <45AF5539.2020608@novell.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 07:50:06 -0500
Message-Id: <1169124606.22731.202.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-18 at 22:08 +1100, Crispin Cowan wrote:
> Casey Schaufler wrote:
> > --- Tom Fortmann <tfortmann@xcapesolutions.net> wrote:
> >   
> >> Are their any current or future plans to support
> >> stacking additional
> >> security modules on the LSM interface?
> >>     
> > It has certainly been considered from
> > time to time. David Wheeler's early work
> > came pretty close.
> >   
> There is a module waiting in the wings called Stacker
> <http://sourceforge.net/projects/lsm-stacker> that is designed to
> automatically stack multiple modules. Considerable design,
> implementation, and measurement has gone into Stacker. The main thing
> stalling the upstreaming of Stacker is for some modules other than
> SELinux to be accepted upstream. With the number of modules vying for
> that, it seems just a matter of time.

Except that at the last kernel summit, the topic came up during the LSM
panel, and everyone on the panel, including the AppArmor person, agreed
that stacking wasn't necessary or desirable.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
