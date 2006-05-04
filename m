Subject: Re: [redhat-lspp] semanage login -a vs useradd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Russell Coker <rcoker@redhat.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1146738735.2200.34.camel@ws>
References: <1146738735.2200.34.camel@ws>
Content-Type: text/plain
Date: Thu, 04 May 2006 07:36:30 -0400
Message-Id: <1146742590.15669.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-04 at 20:32 +1000, Russell Coker wrote:
> Currently you must run useradd before you run "semanage login -a" to
> create a SE Linux identity.  Does this make sense?

Added selinux list to cc, as this is relevant to any use of SELinux, not
just LSPP purposes.  Same applies to any other general discussion that
impacts on general use of SELinux, like newrole changes.

As to whether it or not it makes sense for semanage/seobject.py to
validate the Unix user identity, I have no strong opinion, but it does
mean that simple typos won't be caught at that point.  

> The SE Linux identity needs to be created first if we are to initially
> label the home directory with the correct label (which I think is a good
> thing).  Also if we have a source of user account information such as
> LDAP being used then there is more possibility for a need to create
> identities before creating matching Unix accounts.
> 
> Finally there is no real need to create the Unix account first.  There
> is no harm done by creating the identity first, in fact if the Unix
> account is created with an enabled password before the identity is
> created then the user may login with inappropriate permissions.
> 
> The next issue that derives from this is the creation of Unix accounts.
> I think it would be convenient to have a single program create Unix
> accounts with the SE Linux data.  In fact having "semanage user -a",
> "semanage login -a" and "useradd" all combined into the one program
> seems beneficial to me.  Among other benefits this would aid scripting
> by having only one error point and improve performance by having all SE
> Linux operations proceed under the one transaction.
> 
> 
> What do you think?

Having a front-end helper program that invokes the underlying ones as
appropriate may make sense, but combining them all into a single program
likely isn't what you want, both because you do want to perform them
independently at times and because they require different permissions
and trust for what they do.  Also not clear on how you envision semanage
user -a being used, as most people will only ever need to use semanage
login.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
