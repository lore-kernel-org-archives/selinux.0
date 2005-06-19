Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050619201452.70676.qmail@web31610.mail.mud.yahoo.com>
References: <20050619201452.70676.qmail@web31610.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 16:57:17 -0400
Message-Id: <1119214637.17213.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think it is. The developer, who understands
> the intent of the application and it behavior,
> ought to be in charge of the SELinux policy.

On the other hand you might argue that the developer
of the application is biased toward the application..
and likely to allow things that shouldn't be allowed.

Anyway, I think Steven (Smalley) has mentioned that
more efforts to decentralize policy will occur
after Tresys' binary modules work is merged.

====

Re: audit2allow - I have no problem with the tool,
as long as people realize it's a tool instead of
an automated policy writer. There's two problems
with using it to make policy - 1) it will allow
everything, and 2) it will not organize everything into
understandable modules.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
