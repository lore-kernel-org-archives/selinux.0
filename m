MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 3/3] expander support for hooks
Date: Sat, 12 Aug 2006 09:42:50 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832B16F@exchange.columbia.tresys.com>
In-Reply-To: <1155226398.8018.26.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Wed, 2006-08-09 at 18:56 -0400, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > > 
> 
> Avoiding the semantic checks will reduce algorithmic 
> complexity far more simply because the number of rules far 
> outweighs symbol manipulations (like typeattribute).
> 

It will reduce the runtime, granted.

> I don't think that this is a good space/time tradeoff but I 
> don't have any real evidence.
> 

I've done some initial testing and it doesn't seem so bad (aside from
having to expand 2 modules instead of 1), I'll do more when I have a
chance.

> > 
> > That's fine, I believe this approach is sound (though it 
> has quite a 
> > bit of complexity added)
> 
> I agree - we are mainly trying to balance code efficiency / 
> algorithmic complexity against meta-policy simplicity. I 
> believe that most meta-policies are going to be 
> coarse-grained and short anyway, so I am pushing the balance 
> towards code simplicity. Ultimately I'm fine with either.
> 

I disagree, this is the same argument opponents of SELinux use, just
because most implementations will be simple and course-grained does not
mean the architecture should artificially simplify and reduce
granulatity because if anyone ever wants to take advantage of the
increased granularity they will be unable to.

The code isn't too complex to maintain, the expander simply has to
expand more stuff, I'm not adding entirely separate codepaths for this. 

Unfortunately at this point coming up with a complete metapolicy that
has specific security goals is difficult, and as you noted before much
of the infrastructure is not yet available (eg., hierarchical
refpolicy). I'll try to work on this.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
