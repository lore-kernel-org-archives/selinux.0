Subject: Re: idea for reducing policy size: put representation of macros in
	binary form
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050630115350.GJ8415@lkcl.net>
References: <20050630115350.GJ8415@lkcl.net>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 08:22:49 -0400
Message-Id: <1120134169.11798.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 12:53 +0100, Luke Kenneth Casson Leighton wrote:
> mad-cap idea that should NOT be taken to its literal extreme (except
> possibly in the case of an embedded system with more time than memory on
> its hands).
> 
> how about, in trading off against processing power, making a
> [possibly limited] means to represent the macros or equivalent
> in binary form in the policy?
> 
> the reasoning behind this is to reduce the size of the policy, and to
> have them expanded out (not using m4 obviously) by the selinux
> capability module at runtime.
> 
> optionally cacheing the results of course, with the possibility of
> throwing these cached results away if too much memory gets used.
> 
> certain macros could be an appropriate target but others, macros of
> macros etc. would not.  yet.

There have been previous discussions on list about creating some kind of
template construct in the policy language that would provide a reduced
functionality form of the macros directly in the language, thereby
allowing them to be preserved at least in the binary policy module form
and thus expanded at policy linking time, even if we don't push them all
the way down into the kernel's binary policy.  Feel free to
contribute ;)

But as far as reducing policy size goes, I think that the already
suggested approaches of:
- storing a type->attribute reverse map in the binary policy rather than
pre-expanding and discarding all attributes during policy compilation,
- storing rules based on attributes directly in terms of the attributes
in the avtab rather than exploding into type sets,
- splitting avtab nodes into separate entries for each kind of datum
rather than coalescing the av rules together and the type rules
together, and
- reducing the size of the fields in the avtab nodes
will be more than adequate.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
