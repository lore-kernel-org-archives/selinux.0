Date: Sat, 27 Jul 2002 13:16:37 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: rules debuging
Message-ID: <20020727031637.GC18313@snoopy.apana.org.au>
References: <200207261430.OAA20538@jazzband.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200207261430.OAA20538@jazzband.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 26, 2002 at 04:31:28PM +0200, Carsten Grohmann wrote:
> this time I write to a rule set for isdn4linux with different domains.
> The main domain contains domain_auto_trans to difficult subdomains e.g. to 
> route_t. 
> This works fine, but I get messages with file access to files and 
> directories which route should not use. So I think my rules are not correct 
> and I don't find the mistake.
> Is there an possibility to "debug" the rule set and watch the program in 
> the same time?

I think some better means of debugging rules is badly required.

An ideal solution might be a GUI where you can, say select a logged
denied message, and then display the stack trace (and relevant source
code) for the relevant program when it encountered the error.
(assuming you have debugging symbols in the program).

I have no idea how feasible or infeasible this is.

However, in your case, I don't think you really need this level of
detail.

First isolate what what rule isn't working as you think it
should. For instance, is your doman_auto_trans stament working?
If is is, you should see the different domain in the scontext=
of the errors.

Then try to work out why it isn't working. Is it included
in policy.conf?
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
