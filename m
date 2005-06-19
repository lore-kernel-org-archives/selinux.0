Message-ID: <20050619201452.70676.qmail@web31610.mail.mud.yahoo.com>
Date: Sun, 19 Jun 2005 13:14:52 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: dumb newbie questions
To: ivg2@cornell.edu
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119210718.17213.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:

> You're misrepresenting the point of my response...

Well, maybe a little.

> Who writes the policy is not important.

I think it is. The developer, who understands
the intent of the application and it behavior,
ought to be in charge of the SELinux policy.

> Well - it is important, but that's not what I was
> talking about here.

Yes, it's important. And an issue.

> I am all for improvements in the way SELinux
> is distributed, and documented, so that more people
> can write policy.

I am a strong advocate of the above.

> What I think is a problem is when people use the
> output of audit2allow as the policy... which is
> what I see happening.

A developer will use the best tools available.
Since audit2allow appears to be the best tool
available for the development of policy that is
what will be used. It appears to be the best
tool available because the FAQs you are
disparaging constitute the best available
documentation and they recommend it. If there
were documentation that described how it
ought to be done maybe you could get it done
properly.

> To me that largely defeats the purpose of SELinux...

You are correct in that bad policies are
bad for SELinux. I believe that having policies
created by someone other than the developer
of the application, except as a first-pass
effort to help the developer along, is a
virtual guarantee that the SELinux will join
the ranks of those systems used to prove that
it is impossible to produce a useable secure OS.



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
