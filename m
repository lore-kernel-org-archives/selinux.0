Subject: Re: rbacsep: transition/inherit perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1210105071.8778.5.camel@gorn>
References: <1210105071.8778.5.camel@gorn>
Content-Type: text/plain
Date: Tue, 06 May 2008 16:48:17 -0400
Message-Id: <1210106897.25678.808.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-06 at 16:17 -0400, Christopher J. PeBenito wrote:
> I branched refpolicy for the RBAC separation, and began the new
> constraints.  I'm trying to decide what to do with the process
> permissions rlimitinh, siginh, and noatsecure.  Since these go with a
> transition, it seems that they could be added the the existing role
> constraint on transition.  Opinions?

Agreed.  Although in practice we usually break the connection _before_
the role change upon the domain transition into newrole_t.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
