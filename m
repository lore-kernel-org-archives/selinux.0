Subject: Re: The sort algorithm is broken by the second rule,  We need a
	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442D4448.2090700@redhat.com>
References: <442D41CA.8070702@redhat.com> <442D436A.1010805@tresys.com>
	 <442D4448.2090700@redhat.com>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 10:17:21 -0500
Message-Id: <1143818241.24555.335.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 10:01 -0500, Daniel J Walsh wrote:
> Joshua Brindle wrote:
> > We are preparing to send up a patch that adds file context ordering to 
> > libsemanage ala the algorithm in fc_sort.c in refpolicy/support. The 
> > sort algorithm should put the 3rd entry below the top two because the 
> > stem length is greater. Are you seeing this with strict (and hightly 
> > modular policy?) the large base.pp from targeted will already have its 
> > file context entries sorted by fc_sort.c and should handle this case.
> I am only looking at targeted and MLS right now.   As soon as we get 
> this fix we need to get it out.

If it isn't working in targeted presently (using the refpolicy's fc_sort
helper at build time), then putting the logic in libsemanage won't help
either.  The question is why doesn't it work now for the libglide entry?
fc_sort appears to do the right thing for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
