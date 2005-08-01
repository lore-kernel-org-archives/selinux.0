Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42EE3879.2050409@tresys.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
	 <42EE3879.2050409@tresys.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 11:09:04 -0400
Message-Id: <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-01 at 10:58 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> 
> > <snip>
> >
> >- We need to be sure that we are comfortable with collapsing the type
> >value space and class value space to 16 bits.  That was done by the
> >first patchset as part of reducing the avtab node size.  The avtab_read
> >code checks for value truncation when reading older binary policies; we
> >should also add checks to checkpolicy to ensure that we don't overflow
> >
> >during policy compilation.
> >
> I know it won't affect the size but why not make all symbol value
> spaces 16 bits, just for consistency?

Also, my real question here is whether we are sure that 16 bit value
space is going to be enough forever for types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
