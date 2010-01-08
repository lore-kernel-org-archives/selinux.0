Subject: Re: [PATCH 03/13] libsemanage: move the module store to
 /var/lib/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@tycho.nsa.gov
Cc: Caleb Case <ccase@tresys.com>, selinux@tycho.nsa.gov, csellers@tresys.com,
        kmacmillan@tresys.com, jbrindle@tresys.com
In-Reply-To: <1262962235.11210.25.camel@localhost>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
	 <1262960902.13162.1.camel@moss-pluto.epoch.ncsc.mil>
	 <1262962235.11210.25.camel@localhost>
Content-Type: text/plain
Date: Fri, 08 Jan 2010 10:19:12 -0500
Message-Id: <1262963952.13162.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-08 at 09:50 -0500, James Carter wrote:
> On Fri, 2010-01-08 at 09:28 -0500, Stephen Smalley wrote:
> > On Wed, 2009-12-23 at 18:25 -0500, Caleb Case wrote:
> > > This patch moves the module store from /etc/selinux/<store>/modules to
> > > /var/lib/selinux/<store>.
> > 
> > Can the path prefix (i.e. /var/lib/selinux) be made configurable?
> > 
> There would be no other prefixes other than /var/lib/selinux
> or /etc/selinux, or do you have something else in mind?
> 
> I guess that you are thinking of backwards compatibility, but you still
> won't have it even if you change the prefix because the directory
> structure is different (priority directories and such).  I don't see
> what you would gain with changing the prefix.

I just dislike the notion that to change the location one would have to
recompile the library.  Even worse, one would have to modify the sources
versus just altering a -D flag in the Makefile specifying the path
prefix.  We already have one such case in libsemanage with a FIXME
comment next to it; I didn't want to extend the set of such cases.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
