From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] clarifications for -l to newrole.1
Date: Fri, 12 Jan 2007 09:07:04 +1100
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Klaus Weidner <klaus@atsec.com>
References: <45A6A064.2040707@us.ibm.com> <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701120907.10944.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 12 January 2007 08:02, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > EXAMPLE
> >         Changing sensitivity only:
> >            # id -Z
> >            user:role:type:SystemLow-SystemHigh
> >            # newrole -l Unclassified
> >            # id -Z
> >            user:role:type:Unclassified-SystemHigh
>
> How does SystemLow differ from Unclassified here (in meaning, not just
> value)?  If SystemLow is supposed to be a special label for system
> objects, then why have users login at that level at all?

In the context of the man page I don't think it matters.  The purpose is to 
clarify an interface that confuses many people.

> >         Changing sensitivity and clearance:
> >            # id -Z
> >            user:role:type:SystemLow-SystemHigh
> >            # newrole -l Unclassified-Unclassified
> >            # id -Z
> >            user:role:type:Unclassified-Unclassified
>
> When would you envision a user doing the above?  Trying to ensure that
> any process he subsequently starts cannot escalate to higher levels?

MCS as currently released in Red Hat and Debian only uses the high level.  MCS 
will always use the high level as the main access control mechanism.  
Therefore this behaviour gets in the way for MCS.

Maybe we should have newrole determine whether MCS or MLS is being used and 
alter it's behaviour accordingly?

> If you are going to provide an example, use real output (i.e. not just
> user:role:type).  Please include an example of changing roles too since
> that is more common.  Also, fix the SEE ALSO list please (runas ->
> runcon, and drop su as it is no longer relevant).

Do people often get confused about changing roles?  It seems to me that 
changing roles is obvious to people (EG the numerous people who have logged 
in to my SE Linux play machines and run "newrole -r sysadm_r" within minutes 
of first learning about it).  Changing levels is not obvious (in it's current 
implementation) which is why there was a long IRC discussion about it where 
even experience SE Linux users had some confusion.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
