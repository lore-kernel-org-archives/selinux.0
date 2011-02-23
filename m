Subject: Re: Need Help with Booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: waqar afridi <afridi.waqar@gmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTimFSPKk+4EaSGtCcoG4Qem7gt1Ew_dSL=K9NXy3@mail.gmail.com>
References: <AANLkTimFSPKk+4EaSGtCcoG4Qem7gt1Ew_dSL=K9NXy3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Feb 2011 12:55:47 -0500
Message-ID: <1298483747.13789.50.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-02-23 at 11:33 +0500, waqar afridi wrote:
> Hello All
> 
> 
> Hope Everyone would be Perfect. I need a Lifesaver help with Booleans,
> I need to manipulate them from the Policy, Any starter
> Guide, Available?

man booleans

Tools for boolean manipulation include getsebool, setsebool, semanage,
and system-config-selinux.

I'm sure you can also find user documentation in the Fedora SELinux
Guide, Managing Confined Services Guide, and elsewhere.  See
docs.fedoraproject.org/selinux-user-guide

selinuxproject.org may have other documentation.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
