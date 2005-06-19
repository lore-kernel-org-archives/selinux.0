Date: Sun, 19 Jun 2005 23:17:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux@tycho.nsa.gov
Subject: Re: dumb newbie questions
Message-ID: <20050619221700.GI8415@lkcl.net>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119210718.17213.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119210718.17213.6.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 19, 2005 at 03:51:58PM -0400, Ivan Gyurdiev wrote:

> What I think is a problem is when people use the output
> of audit2allow as the policy... which is what I see happening.

 that's exactly what i do as a first approximation, because i don't have
 enough info in my head about all those macros.

 some of those macros expand out to TWENTY THOUSAND statements.

> To me that largely defeats the purpose of SELinux... 

 *shrug*

 what else would an inexperienced person use?

 _after_ doing audit2allow, you can at least go back and look at some of
 the macros.

 if you want a useful tool, then what you want is an analyser
 that will suggest appropriate macros to use AFTER someone
 has done repeated application of audit2allow.

 an se-lint, if you will.

 and yes, i am aware that even doing the audit2allow "thing" doesn't
 help you in the slightest if you haven't a clue about domain
 transitions.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
