Subject: Re: [PATCH] Suppress rule generation for dontaudit rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <46C4A449.9010102@manicmethod.com>
References: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
	 <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
	 <46C4A449.9010102@manicmethod.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:22:43 -0400
Message-Id: <1187875363.1451.475.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 15:23 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-08-15 at 10:15 -0400, Karl MacMillan wrote:
> >   
> >> The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.
> >>
> >> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> >> ---
> >>
> >> diff -r 56dbe9166d98 -r 2ad2d21fc724 sepolgen/src/sepolgen/policygen.py
> >> --- a/sepolgen/src/sepolgen/policygen.py	Thu Jun 07 08:08:31 2007 -0400
> >> +++ b/sepolgen/src/sepolgen/policygen.py	Wed Aug 15 10:13:28 2007 -0400
> >> @@ -139,6 +139,8 @@ class PolicyGenerator:
> >>  
> >>      def __add_allow_rules(self, avs):
> >>          for av in avs:
> >> +            if not av.denial:
> >> +                continue
> >>              rule = refpolicy.AVRule(av)
> >>              if self.explain:
> >>                  rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
> >>
> >>     
> >
> > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> >   
> 
> Merged into 1.0.9

Reverted.  Didn't work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
