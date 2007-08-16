Subject: Re: [PATCH] Suppress rule generation for dontaudit rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>
In-Reply-To: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
References: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 14:45:25 -0400
Message-Id: <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 10:15 -0400, Karl MacMillan wrote:
> The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.
> 
> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> ---
> 
> diff -r 56dbe9166d98 -r 2ad2d21fc724 sepolgen/src/sepolgen/policygen.py
> --- a/sepolgen/src/sepolgen/policygen.py	Thu Jun 07 08:08:31 2007 -0400
> +++ b/sepolgen/src/sepolgen/policygen.py	Wed Aug 15 10:13:28 2007 -0400
> @@ -139,6 +139,8 @@ class PolicyGenerator:
>  
>      def __add_allow_rules(self, avs):
>          for av in avs:
> +            if not av.denial:
> +                continue
>              rule = refpolicy.AVRule(av)
>              if self.explain:
>                  rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
> 

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
