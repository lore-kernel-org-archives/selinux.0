Subject: Re: policy under version control
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>, tom@lemuria.org
Content-Type: text/plain
Message-Id: <1070465788.3774.29.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 03 Dec 2003 10:36:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 14:28, Tom wrote:
> On Mon, Dec 01, 2003 at 10:13:35AM -0500, Stephen Smalley wrote:
> > There is already a sourceforge CVS tree, and patches can be posted to
> > the selinux list.
> 
> The problem I see with read-only CVS and a post-to-mailinglist approach 
> is that it's non-trivial to maintain various sets of the same policy.
> 
> It seems that in the long run we won't be able to do with a single
> default policy. We'll need a couple, or a modular approach. Something
> very much like Debian's tasksel or other tools for other distributions
> where you have 5-10 fields you can check what your machine is going to
> be, and the relevant policy is then assembled automatically.
> 
> 

We are working on some general mechanisms to address this problem. The
first is the ability to define booleans in policies that can be changed
at runtime. This will allow you to turn on and off TE rules based on the
values of the booleans. We posted some messages about this in the past
and we are going to release a working snapshot of this in the next few
days.

We are also working on binary policy modules, which more directly
address what you are wanting I think. This will allow you to create
small binary policy modules separately from a base policy. This is
primarily for the purpose of adding or removing policy components for
specific applications. The advantages of this system are that the
requirement for the policy source and checkpolicy is removed, there will
be language extensions to make the policy modules more loosely coupled
to the core policy (i.e. 1 module will potentially work with a variety
of base policies), and there will be provisions to handle labeling on
installation or removal of the policy modules. Hopefully we will be able
to post some more information about this in the near future (we are in
the design phase of this project).

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
