Subject: Re: new to selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: nitin kanaskar <nvk02@hotmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY17-F3426AFBCE35978EDAE7471BEBA0@phx.gbl>
References: <BAY17-F3426AFBCE35978EDAE7471BEBA0@phx.gbl>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 12:46:06 -0400
Message-Id: <1123692366.3018.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-10 at 21:18 +0530, nitin kanaskar wrote:
> hi all...
> i ve started reading selinux papers
> and am interested in contributing
> in any area listed in the section
> 'remaining work' of the site.
> Could anybody provide any suggestions?

Depends on your skills and interests, naturally.  That page is only
updated periodically, and is fairly generic - it is likely better to
scan the recent mailing list archives
(http://marc.theaimsgroup.com/?l=selinux is more up-to-date than the
only periodically updated ones on nsa.gov) for areas of current
activity.  A natural first step is just getting a SELinux system up and
running and gain some familiarity with using and configuring it.  Some
resources are listed at http://selinux.sf.net.  Some possible areas
where you might contribute include:

- Testing and expanding the reference policy.  See
http://serefpolicy.sourceforge.net/.

- Contribute to ongoing work to improve libsepol and create a management
infrastructure.  See 
http://marc.theaimsgroup.com/?l=selinux&m=112265972617608&w=2
as well as other discussions on the list about that work.
Note that you need to work relative to the CVS tree of the sourceforge
selinux site for any such development, see
http://sourceforge.net/cvs/?group_id=21266

- Add testcases to the SELinux testsuite in the LTP.  See
http://marc.theaimsgroup.com/?l=selinux&m=112230493816120&w=2

- Test and contribute to the ongoing polyinstantiation support
development.  See
http://marc.theaimsgroup.com/?l=selinux&m=112169238725927&w=2

- Test and contribute to various externally developed policy tools to
make them more useable.  See
http://www.tresys.com/selinux/selinux_policy_tools.html
http://www.mitre.org/tech/selinux/
http://seedit.sourceforge.net/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
