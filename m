Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@tresys.com>, ivg2@cornell.edu,
   "'James Morris'" <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506241805.j5OI5fqc018169@gotham.columbia.tresys.com>
References: <200506241805.j5OI5fqc018169@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:40:53 -0400
Message-Id: <1119638453.12865.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 14:05 -0400, Frank Mayer wrote:
> So the avtab that we have now would be 300,970 x 32 bytes = ~9.6MB versus
> the alternative avtab of 354,714 * 24 = ~8.5MB or about a ~1.1MB savings
> (about 10%) with very little code change and essentially zero performance
> impact. If the audit-to-allow rule ration stays 1-10, then this change makes
> sense.
> 
> I suspect we can look around and find other examples where small or no
> performance tradeoffs can made for large size savings. For example if we
> make the specified flag 16 bit instead of 32 (we're using less then 16 now),
> we could save another ~.7MB of memory, or a total of ~1.8MB or about 19%.
> Coupled with smaller policies in the future, we should be able to make
> significant progress with less pain than a complete restructure of the
> policydb.

While I agree that saving space in the avtab nodes will help and is
desirable, I don't think it is going to be sufficient; I think we have
to reduce the sheer numbers of such nodes, and I'm not convinced that
the loadable module support and the reference policy will result in a
sufficiently small avtab.  So I think we need to take it another step...

> If we go ahead and keep attributes around (as we have in the loadable module
> work), then the savings can be much greater, but we'd have to study the
> performance impacts better. The implementation changes would also be more
> radical. For example the same sample policy above that had ~300K allow rules
> in the binary policy had only ~27K allow rules in the source policy before
> expansion. Some rules will expand anyway because of multiple classes, but I
> believe most expansion is due to attribute expansion.

Yes, I think we should investigate this idea, despite its impact on the
existing code, as it should significantly reduce the number of avtab
nodes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
