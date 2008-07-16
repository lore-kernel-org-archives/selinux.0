Subject: Re: [RFC] An idea of thread/child-domain assignment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <487D9061.1080304@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>  <487D9061.1080304@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 08:00:04 -0400
Message-Id: <1216209604.17602.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-07-16 at 15:08 +0900, KaiGai Kohei wrote:
> >>> In other words, this idea requires to change our viewpoint for child domain.
> >>> Previously, these are mutually independent domain, but a child domain will
> >>> mean a state with restricted operations compared to its parent domain.
> >> I tend to agree that we should support such changes in the kernel
> >> mechanism and let the use of it be determined by the policy.
> >>
> >> In terms of hierarchy though, the plan was to replace the current
> >> name-based hierarchy with an explicitly declared hierarchy.
> > 
> > It needs a new policy statement like:
> > 
> >   TYPE <child domain> DOMBY <parent domain>;
> >     or
> >   TYPEDOMINANCE <parent domain> <child domain> [,<child domain>] ;
> > 
> > I guess these relationships are represented as a ebitmap structure
> > in the kernel, and used to mask permissions during AVC entry creation.
> 
> Should it be possible to have multiple parent domains on the explicitly
> declared hierarchy?
> 
> The current name-based hierarchy only supports tree-shaped structure.
> (A child domain can have one parent at most.)
> It implicitly enables to avoid a matter of loop of relationship between
> parents and children.
> 
> If we can define a domain with multiple parent, it makes the logic to
> detect the loop complicated.

I don't see a reason for supporting multiple parents.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
