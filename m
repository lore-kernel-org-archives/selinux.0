Subject: Re: Propper labeling of files under /var/www
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1198059185.3342.3.camel@localhost6.localdomain6>
References: <1198003507.3705.15.camel@localhost6.localdomain6>
	 <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1198059185.3342.3.camel@localhost6.localdomain6>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 09:12:55 -0500
Message-Id: <1198073575.19081.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-19 at 10:13 +0000, Stefan Schulze Frielinghaus wrote:
> On Tue, 2007-12-18 at 13:55 -0500, Stephen Smalley wrote:
> [...]
> > Try restorecon -FRv /var/www
> 
> Yeah that solved the problem. The -F option is a little bit tricky ;-)
> Never expected something like that.

/etc/selinux/targeted/contexts/customizable_types was created to allow
programs like restorecon to omit files with certain types from being
relabeled by default, so that admin customizations wouldn't be lost.
The httpd-related types are a common case of this, where the admin wants
to manually manage the type under the web root and not have them
clobbered.  As to whether it still makes sense when we have semanage
fcontext, I'm not sure.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
