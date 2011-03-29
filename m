Subject: Re: [PATCH] checkpolicy: add support for using last path component
 in type transition rules
From: Eric Paris <eparis@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com, sds@tycho.nsa.gov
Date: Tue, 29 Mar 2011 11:22:56 -0400
In-Reply-To: <4D91F135.2050809@tresys.com>
References: <1301335220.14296.27.camel@localhost.localdomain>
	 <4D91F135.2050809@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1301412177.14296.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-03-29 at 10:48 -0400, Christopher J. PeBenito wrote:
> On 03/28/11 14:00, Eric Paris wrote:
> > This patch adds support for using the last path component as part of the
> > information in making labeling decisions for new objects.  A example
> > rule looks like so:
> > 
> > type_transition unconfined_t etc_t:file system_conf_t eric;
> > 
> > This rule says if unconfined_t creates a file in a directory labeled
> > etc_t and the last path component is "eric" (no globbing, no matching
> > magic, just exact strcmp) it should be labeled system_conf_t.
> > 
> > The kernel and policy representation does not have support for such
> > rules in conditionals, and thus policy explicitly notes that fact if
> > such a rule is added to a conditional.
> 
> Is there any plan for getting conditional support?

I don't plan on doing it.  I hate conditionals, wish they would die, and
suggest we should move to all modules instead.  The kernel policy server
isn't built in a way to make support in conditionals easy.  I can do it
if we have to (it's software, we can do anything), but I don't want to
continue to encourage conditionals.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
