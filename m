Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: casey@schaufler-ca.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <472431.76522.qm@web36610.mail.mud.yahoo.com>
References: <472431.76522.qm@web36610.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 12:24:13 -0400
Message-Id: <1181924653.28363.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-15 at 09:05 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 

[...]

> 
> So please explain, so that even an MLS junkie like me can understand,
> why you can't "just" use the file capability machanism as it's
> designed. I read what you wrote. I read the code. Humor me and
> answer the question if you'd be so kind. I'm sure that you have
> a good reason and sufficient understanding of all the surrounding
> issues to make it clear.
> 

It's not clear to me what you mean by "using" the file capability
mechanism. In the current implementation, if file caps are used SELinux
can either a) use those caps with optional additional restrictions (just
like current inherited capabilities) or b) override those capabilities.
The policy writer then can choose whether to "use" the file capabilities
or use the native selinux policy mechanism.

As for why it is important to add the selinux cap_override mechanism,
this has been explained many times in this thread (hence the
exasperation with your constant questioning and implying of conflict
where there is none). The file capability mechanism puts policy in the
xattr. A primary goal of SELinux is to have a central, analyzable
policy. These things cannot be reconciled.

Does this answer your question?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
