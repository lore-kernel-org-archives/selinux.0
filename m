Subject: Re: chcon v. setfilecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rich turner <rich@storix.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1123191498.4481.76.camel@rich>
References: <1123191498.4481.76.camel@rich>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 08:44:01 -0400
Message-Id: <1123505041.13654.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 14:38 -0700, rich turner wrote:
> what is the difference between these commands? it seems they both do the
> same thing.
> 
> is setfilecon deprecated and replaced with chcon?
> 
> on my fedora core3 system i have the setfilecon command but not the
> chcon command. on fc4 i have the chcon command.

setfilecon was a trivial example utility provided with libselinux to
demonstrate usage of its setfilecon() function.  chcon is a "real"
utility patterned after chown/chmod with a richer interface and set of
functionality.  chcon is included in coreutils.  I don't know why you
wouldn't have it in FC3; it should be there.  Red Hat stopped installing
setfilecon from libselinux as it served no purpose for end users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
