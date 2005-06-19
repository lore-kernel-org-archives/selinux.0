Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: srainwater@ncc.com, SELinux@tycho.nsa.gov
In-Reply-To: <1119210718.17213.6.camel@localhost.localdomain>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 16:41:35 -0400
Message-Id: <1119213695.17213.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > If only the "SELinux people" can write "proper"
> > policy SELinux has no place in the linux mainline.
> > I suggest that the "SELinux People" would do well
> > to provide documentation that is sufficient for
> > the developer in question to create a "proper"
> > policy rather than asserting that it's only
> > something that they can do. The attitute presented
> > is akin to saying that no one but RedHat should
> > create Makefiles because, after all, they are
> > the "Distribution People".
> 
> You're misrepresenting the point of my response...
> 
> Who writes the policy is not important.
> Well - it is important, but that's not what I was talking
> about here. I am all for improvements in the way SELinux
> is distributed, and documented, so that more people can 
> write policy.
> 
> What I think is a problem is when people use the output
> of audit2allow as the policy... which is what I see happening.
> To me that largely defeats the purpose of SELinux... 

Steven, 

to write custom selinux policy you need to download
the selinux-policy-*-sources package. After doing that,
you can go to domains/misc/local.te, and place your
policy there. Then do make load; make install, and
hope that it works.

To actually write policy you need to understand the
SELinux policy language. There are several books
on this, but I'm not the best person to ask about 
a reference. I am sure others on this list will 
be able to help you. Casey has a point that currently 
it is difficult for the person who has had no 
experience with SELinux to write customized policy. 
That's why we try to limit the places where the user 
would need such a policy, and provide a GUI to control
the operation of the existing policy 
(system-config-securitylevel)

I highly recommend _against_ using the output of
audit2allow as the policy, although it will be helpful
to you to establish what went wrong. audit2allow
is a tool which prints the audit messages from the log,
and generates rules that will make them go away. You
can then take those rules and place them in the policy
sources, and recompile policy. Surely you can see why 
this is a bad thing, if used carelessly - some things 
should not necessarily be allowed, and this tool will 
allow them. It also attempts to create no organization
of rules at all. SELinux rules are usually organized
through macros that you can use to write better policy
source.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
