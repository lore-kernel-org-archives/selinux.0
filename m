MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Type transition rules in conditionals
Date: Thu, 15 Jun 2006 14:42:49 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588210A30@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While working on optionals in base bugs I discovered that the
conditional code discards type_transition rules which are duplicates,
even if they are in different conditionals (which should be valid and
indeed happens in refpolicy).

This bug became apparent when I used sediff against a monolithic and
modular policy built from the same refpolicy tree. The type_transition
that stayed in the policy ended up being different. 

So I changed the expander to let multiple duplicate entries in the avtab
as long as the default type was the same. Unfortunatly the security
server code (both userspace and kernel) search for a type transition
rule with the same key and bail if it finds one, regardless of the
default type. 

AFAICT the fix for this isn't totally trivial. The conditional code can
be changed to look at the default type to see if they conflict but it
will need to loop and try every rule it finds. Further the compute_sid
code would need to loop through rules until it finds an enabled
type_trans rather than just checking the first one. This brings up
another problem. Conflicting type transition rules are allowed if they
are in opposite sides of a conditional. This means that duplicate type
transitions can only exist in other conditionals if there are no
conflicting entries in the other side of any conditional.

The fix for this isn't totally straightforward but I think its clear
that silently dropping rules isn't good. Any ideas or comments?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
