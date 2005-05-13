Subject: Re: Policy 1.22 Presentation?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050513121723.1202.qmail@web60414.mail.yahoo.com>
References: <20050513121723.1202.qmail@web60414.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 08:29:46 -0400
Message-Id: <1115987386.3576.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-13 at 05:17 -0700, Roger Brunell wrote:
>   This may seem to be a rather mundane question, but
> some guidance would be appreciated. I *think* I have
> selinux running on a Debian derived OS (2.6.11-3). I
> installed the NSA 1.22 policy. 

1.22 is fairly old now (March 9th release); I'd work off the sourceforge
selinux CVS tree or the Fedora devel CVS tree.  We're just waiting on
Linux 2.6.12 to be released to put an updated release on nsa.gov.

>   Something left a bunch of error messages in that
> file.

The genhomedircon script (from policycoreutils) generates the
file_contexts.homedirs file.  It attempts to determine the default home
directory root from /etc/default/useradd (by grep'ing for ^HOME), then
checks /etc/libuser.conf for ^LU_HOMEDIRECTORY.  It naturally shouldn't
be dumping error messages into the file itself.  Does the problem
persist with the latest version of the script and policy from the
sourceforge selinux CVS tree or the Fedora devel CVS tree?

> ?2? The policy makefile does 'MLS' or 'strict'; what
> about 'targeted'? How is that installed? I think that
> is the model I need. Guard the door; but let the
> customers do what they want to each other.

Grab the latest selinux-policy-targeted.spec file from the Fedora CVS
tree to see how they are building targeted policy from the policy
sources.  There is one included in the policy directory as an example,
but it isn't up-to-date with the latest Fedora one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
