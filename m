Subject: Re: sepcut is broken
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Mark Shakespeare <mshakes@llnl.gov>, SELinux List <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1074792409.13445.148.camel@moss-spartans.epoch.ncsc.mil>
References: <p0602040cbc34b0d29bb3@[128.115.96.64]>
	 <1074789931.27824.87.camel@colossus.columbia.tresys.com>
	 <1074792409.13445.148.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074792957.27824.101.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 12:35:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-22 at 12:26, Stephen Smalley wrote:
> On Thu, 2004-01-22 at 11:45, Karl MacMillan wrote:
> > On Wed, 2004-01-21 at 17:55, Mark Shakespeare wrote:
> > > There were many duplicate .te files in the
> > > /etc/security/selinux/src/policy/domains/program and unused....which
> > > were resolved.
> > > 
> > 
> > Dan and Russell - I noticed this as well. Is this duplication
> > intentional? This breaks the convention, on which sepcut depends, that a
> > .te file is either in programs or unused but not both.. We are making
> > sepcut handle this situation more gracefully, but I would like to see
> > this convention retained.
> 
> Dan's policy spec file copies most of the unused .te files up prior to
> installing the policy so that they are included in the built policy.  He
> could move them up instead, I suppose. 

That would fix the problem for the short term.

> Of course, a better system than
> moving .te files around would be preferable for enabling and disabling
> them; I think Russell suggested a while back creating something like the
> kernel configuration system for the policy, and saving the
> enabled/disabled state in a separate .config file.

I think that sounds like a better solution as well. Any thoughts on the
specifics of the format? A file with just a list of module file names
would work and be simple for the make process to use, but now is a good
time to consider if any other information should be included in the
file. Additionally, this could allow developers to group .te files in
subdirectories if they wanted some more organization.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
