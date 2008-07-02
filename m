Subject: Re: This patch adds permissive to semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48691EB3.30706@manicmethod.com>
References: <4869037D.5040208@redhat.com>  <48691EB3.30706@manicmethod.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 08:00:45 -0400
Message-Id: <1215000045.22447.252.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-30 at 13:58 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > Gives users the ability to set a domain as permissive
> > 
> > 
> > semanage permissive -a http_t
> > 
> > It created a policy module named permissive_httpd_t.pp with the
> > permissive call.
> > 
> 
> So, a really quick glance brings up a couple issues. First you have '-n', '--noheading' which aren't documented in the man page or elsewhere. Second (and more importantly) why are you executing semodule like that? libsemanage is the library that manages modules, and also the library used by semanage for everything else. 
> 
> I would prefer a more 'pure' approach where we keep a list of
> permissive types and inject them into the kernel policy after linking
> (like libsemanage does with users, ports, nodes, etc) but I understand
> that adding a whole new set of databases and interfaces is both
> annoying and time consuming so I'm fine with it working on modules,
> I'd just like to see it using libsemanage interfaces instead of
> calling semodule.

Why do you see direct use of the libsemanage interfaces as preferable to
invoking semodule (aside from performance, and this isn't really
performance critical)?

I'm unclear on the tradeoff being made there, as composing small
programs together to perform more complex operation is the Unix (tm)
way ;)

The advantage of just invoking semodule is that semodule is already a
well-tested program that performs that function well, does proper error
checking and handling of the various libsemanage calls, etc.  And if we
later fix a bug or introduce new functionality there, we only have to do
it once vs. in multiple places.

And the semanage permissive code already has to invoke a helper program
to compile the policy module from source to binary, at least today, so
it isn't much different to invoke semodule to install the binary module.

Then there is the issue of being able to run the semodule stage of
processing in a separate domain, although at present semanage and
semodule operate in the same domain so it makes no difference at
present.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
