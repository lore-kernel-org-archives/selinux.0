Subject: Re: [PATCH-v3] libsepol: allow genfscon statements in modules
From: Eric Paris <eparis@redhat.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4829F4C4.4020306@manicmethod.com>
References: <1210173297.3084.13.camel@localhost.localdomain>
	 <4829F4C4.4020306@manicmethod.com>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 12:39:53 -0400
Message-Id: <1213634393.3029.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-05-13 at 16:06 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > This patch provides the libsepol support for the usage of genfscon
> > statements in policy modules.  The module must declare/require all of
> > the components of the context associated with the declaration but the
> > actual validation of that context is delayed until link time.
> >
> > Comments and criticism appreciated.  (note that this patch may require
> > the recent bug fix from sds for mls_level_convert())

So I started to get back to this patch and realized it was pretty
seriously flawed.  I was not checking the validity of the context while
it was being linked into the base.  When I fixed to pay attention to the
return code of the return code of context_copy_and_validate() every
single context coming in from the module failed.  The reason being
because the MLS information is not getting written or read
(context_struct_t only reads/writes MLS info for monolithic or the base
module)

So, I've come to realize I need to start carrying around the
mls_semantic_range_t information with my genfs statements in the module
so that I can map those into the base and actually have/check MLS
validity.  I'm looking for any helpful suggestions or hints on how to do
this cleanly and things that people can think of off of the top of their
head of the gotchas when trying to carry around this MLS information.

So really if anyone has tips, tricks, pointers, gotchas, anything really
that might be interesting as I try to come up with a way for modules to
support full context strings let me know.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
