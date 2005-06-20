Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux@tycho.nsa.gov
In-Reply-To: <20050619221700.GI8415@lkcl.net>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <20050619221700.GI8415@lkcl.net>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 00:11:01 -0400
Message-Id: <1119240661.21892.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>  some of those macros expand out to TWENTY THOUSAND statements.

..which is a completely irrelevant statistic.

What's important is how accurate the macro's header explains 
what the macro does. 

I highly dislike policy which doesn't make use of proper macros - 
it looks like a random collection of allow rules with no
sense of purpose of any kind. That's part of the reason
I don't like audit2allow.

To me, the structure of policy should follow the structure of code - 
if you have a shared library somewhere, you should have a macro
(or several of them) that can be called by whatever links to 
that library. Otherwise you just end up adding the same allow 
rules all over the place, and they're not organized in a 
logical module.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
