Message-ID: <20050612184454.91209.qmail@web31603.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 11:44:54 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Questions about "labeled networking" and "network message" 
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612172106.46491.qmail@web51505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:


> ... How to understand the statement:"typically is
> used in military and government environments
> dealing with classified information."? Would you
> please give me a scenario of the statement?

Typical MLS deployments involve an expensive
shared resource, either a supercomputer or a
Very Large dataset. MLS allows users with different
levels or compartments of sensitivity to use
the expensive resource at the same time. Most
civilain environments are willing to allow
a certain amount of information flow between
those sharing the resource, whereas the military
and intellegence communities are more concerned
about such flow.

Given that most Linux developers are more
concerned with environments that do not
involve sharing single large expensive
resources it is understandable that other
security issues have taken precedence over
MLS.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
