Subject: RE: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C0618592014C0C72@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592014C0C72@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:15:48 -0400
Message-Id: <1157112948.20971.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-30 at 12:43 -0400, Venkat Yekkirala wrote:
> > BTW, Joy & Venkat - it would be nice if the usage/configuration of the
> > ipsec labeling was documented somewhere.  I've seen emails in the past
> > with sample usage, but has it been captured anywhere we can 
> > refer people
> > to, like in the Fedora SELinux wiki?
> 
> If I remember right, Joy was either working on or had a comprehensive doc
> from the original work on labeled ipsec that was going to be modified for
> the recent changes and posted to selinux/redhat-lspp. My emails with sample
> usage were more a stop gap as well as to aid in the modifications to the
> original doc.
> 

Ok, aside from the bug I'm apparently experiencing (Joy is looking in to
it) I think I have misunderstood what getpeercon() is suppose to do over
ipsec. I was under the impression it would act like getpeercon() over
unix stream sockets and get the context of the application on the other
side of the socket but that is apparently not what getpeercon() for
ipsec does.

So basically to use ipsec in any useful way you have to have separate
ipsec connections between 2 machines for every domain you plan to
communicate across (with the expectation of knowing what domain is on
the other side)..

This seems very fragile to me and difficult to keep working (especially
since the ipsec policy isn't tied to the selinux policy in any way)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
