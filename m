Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 15:51:58 -0400
Message-Id: <1119210718.17213.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-19 at 09:40 -0700, Casey Schaufler wrote:
> 
> --- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:
> 
> 
> > I wish FAQs would stop recommending this, since
> > that's what everyone 
> > does to get their scripts to run. audit2allow is a
> > helper program
> > for policy writers, and nothing more. It's a mistake
> > to pipe
> > its output into anything... instead you should
> > provide that to the
> > SELinux people, so they can write proper policy.
> 
> If only the "SELinux people" can write "proper"
> policy SELinux has no place in the linux mainline.
> I suggest that the "SELinux People" would do well
> to provide documentation that is sufficient for
> the developer in question to create a "proper"
> policy rather than asserting that it's only
> something that they can do. The attitute presented
> is akin to saying that no one but RedHat should
> create Makefiles because, after all, they are
> the "Distribution People".

You're misrepresenting the point of my response...

Who writes the policy is not important.
Well - it is important, but that's not what I was talking
about here. I am all for improvements in the way SELinux
is distributed, and documented, so that more people can 
write policy.

What I think is a problem is when people use the output
of audit2allow as the policy... which is what I see happening.
To me that largely defeats the purpose of SELinux... 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
