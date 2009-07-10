From: Paul Moore <paul.moore@hp.com>
To: Chad Sellers <csellers@tresys.com>
Subject: Re: [RFC] Install SELinux policies from rpm package header
Date: Fri, 10 Jul 2009 17:17:02 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, Paul Howarth <paul@city-fan.org>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
References: <C67BD5B0.A89C1%csellers@tresys.com>
In-Reply-To: <C67BD5B0.A89C1%csellers@tresys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907101717.02530.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 July 2009 05:13:20 pm Chad Sellers wrote:
> On 7/9/09 4:48 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> <snip>
>
> > A couple of other problems with including policy with each rpm.  How do
> > you handle different packaging.  MLS, Targeted, minimal.
>
> That is a problem we'll have to solve, but I don't think it will be too
> difficult. We could easily provide an option to the %policy directive that
> could direct rpm to use a particular policy store.

Would that mean we could end up in a situation where a RPM only installs 
policy modules for a particular policy type, e.g. apache only installs a 
targeted policy module?  That seems like it could lead to real problems down 
the line as individual RPMs get this wrong.  Also, what happens at the unknown 
point in the future when we change from targeted as the de-facto default to 
some other name?

I like what you are trying to do here, it just scares me a little bit thinking 
about all the details (and I'm sure I'm only thinking about a small number of 
them too).

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
