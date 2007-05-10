Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4AJg0UC014777
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 15:42:01 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4AJg0Uk025261
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 19:42:00 GMT
Subject: Re: [PATCH] Basic policy representation
From: "J. Tang" <jtang@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1178753217.21282.12.camel@localhost.localdomain>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <1178735753.5665.38.camel@localhost.localdomain>
	 <1178738540.2951.16.camel@localhost.localdomain>
	 <1178750819.5665.100.camel@localhost.localdomain>
	 <1178753217.21282.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 May 2007 15:42:33 -0400
Message-Id: <1178826153.5665.125.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 19:26 -0400, Karl MacMillan wrote:
> I don't see why - the import function will just create the bare rules
> and declarations and the normal resolution functions can work. The
> requirements would just be thrown out.

An existing module could have this:

optional o {
  type A, B, C;  # type A is not used by this optional
  allow B C: d e;
}

Within the proposed design, how is type A represented?  It is neither
used within a rule nor is it a definition.  It is a declaration, under
classic compiler terminology.  The given design does not seem to make a
distinction between declarations and definitions.

> >   allow A B : C d;
> >   allow x y : z d;
> Perhaps - it depends on whether there is a string pool at the root of
> the tree the object is in. If there is a string pool, however, there
> will only be one instance.

Here are three scenarios:

1.  Both rules are declared unconditionally.  This is a monolithic
policy.

2.  First allow rule is declared unconditonally, the second rule within
a conditional.  This is a monolithic policy.

3.  The two rules are from different modules.  Their respective ASTs are
presumably joined during linking.

For which of these scenario(s) is there a string pool "at the root of
the tree the [rules are] in"?  If so, it holds that there is only one
instance of "d", and thus am I correct in saying that permissions are
indeed instances of sepol_objpools?

> > In the statement
> >   type A alias {B C D E F}
> > will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just
> one?
> The code I posted for comments would create 0 - you would just have a
> type declaration. The goal is to represent the policy in the same
> structure as the source - it helps for policy generation.

Follow-up question: In the statement

  typealias A alias {B C D E F};

will this create five instances of a SEPOL_TYPEID_TYPEALIAS or just one?
It is unclear by the supplied documentation what the intended behavior
is.

> If you want to print out the tree structure you need this. Is there
> some
> reason to not export this?

Why would not the user call sepol_object_tostring() from the topmost
node?

-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
