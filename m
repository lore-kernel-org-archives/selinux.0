Subject: Re: [SEMANAGE] Commit numbers for ro database calls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43B97ACC.5080203@tresys.com>
References: <43ABDF45.7020900@cornell.edu> <43B97479.90101@tresys.com>
	 <43B95B30.4040108@cornell.edu>  <43B97ACC.5080203@tresys.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 15:39:27 -0500
Message-Id: <1136320767.27632.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-02 at 14:11 -0500, Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
> > Yes....
> > In general, is there any documentation about libsemanage (API?)
> > Or should we start writing that, and how? I don't know how to use any 
> > doc. software yet
> > (not even writing manpages), so I'd have to learn. Someone complained 
> > about lack of
> > documentation of the seusers format earlier.
> > 
> There is no API doc outside the headers. Man pages are probably prefered 
> but I don't really know how to make them either. Perhaps Steve has a 
> suggestion for this?

man pages are preferred (at least as a starting point; supplemental
documentation is fine as well, but man pages should always be
available).  Just copy an existing one from libselinux or libsepol and
use it as a template.  Prioritize them according to likelihood of use
outside of core SELinux code and actual use.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
