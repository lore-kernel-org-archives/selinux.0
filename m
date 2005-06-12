Message-ID: <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 16:32:33 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux? 
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Valdis.Kletnieks@vt.edu wrote:


> You'll want *some* way of managing the allocation of
> contexts cluster-wide,
> just so you don't have two usages of jdoe_u that
> refer to two different users..

You will do well to consider the implications
of allowing anything other than identical policies
within a cluster or even a grid. Dealing with
something as simple as the difference between
DoD Secret and DoE Secret is a real challange.
Back in the days of CMW Mitre produced a language
for mapping security contexts between systems
that did little but demonstrate why you don't
want to try it. Sure, it's doable for small
policies (Bell and La Padula or Biba for example)
but a policy that includes over 40,000 explicit
rules? That would be a challange. Further, if
you're mapping a 40k policy to a different 40k
policy, well, "do the math", as they say.
 


Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
