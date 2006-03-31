Subject: Re: The sort algorithm is broken by the second rule,  We need a
	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1143818241.24555.335.camel@moss-spartans.epoch.ncsc.mil>
References: <442D41CA.8070702@redhat.com> <442D436A.1010805@tresys.com>
	 <442D4448.2090700@redhat.com>
	 <1143818241.24555.335.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 10:20:18 -0500
Message-Id: <1143818418.24555.336.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 10:17 -0500, Stephen Smalley wrote:
> If it isn't working in targeted presently (using the refpolicy's fc_sort
> helper at build time), then putting the logic in libsemanage won't help
> either.  The question is why doesn't it work now for the libglide entry?
> fc_sort appears to do the right thing for it.

On FC5:
$ matchpathcon /usr/lib/libglide3.so.3
/usr/lib/libglide3.so.3 system_u:object_r:textrel_shlib_t

Of course, I just made that path up, as I don't have it installed - what
is the actual path in question?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
