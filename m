Date: Tue, 14 Oct 2003 21:46:24 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: SELinux@tycho.nsa.gov
Subject: Re: selinux from user POV
Message-ID: <20031014194624.GA1655@suse.de>
References: <sf880644.030@atlas.snu.edu> <1066141498.5054.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066141498.5054.138.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 14, Stephen Smalley wrote:

> On Sat, 2003-10-11 at 14:29, Joshua Brindle wrote:
> > This is going to be contraversial, I know, but this is something that
> > is fairly important to me and others I know of on this list.
> > 
> > Being a user on an SELinux machine is currently not good.. Ideally
> > it should be totally transparent but there are some issues. Mainly, 
> > right now, a user can't even add a .ssh directory and put their
> > ssh key in authorized_keys2 and then log in with it without the 
> > admin having to relabel (or at least label those objects) . 
> 
> Put an empty .ssh directory in the /etc/skel directory and assign it the
> correct type there, and modify useradd to preserve types when copying
> the skeleton directory for new accounts.  Then when a user creates files

The useradd implementation from the next pwdutils release (2.3.96)
will preserve all extended attributes when copying /etc/skel, this
means ACLs and SELinux attributes.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
