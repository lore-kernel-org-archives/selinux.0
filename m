Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MJdUrT004366
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 15:39:30 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MJdTWF023385
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 19:39:29 GMT
Subject: mail servers and SE Linux
From: Russell Coker <rcoker@redhat.com>
To: SE Linux list <selinux@tycho.nsa.gov>, noel@devtech.com
Content-Type: text/plain
Date: Wed, 22 Sep 2004 20:51:40 +1000
Message-Id: <1095850301.4754.109.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last night we had some discussion about SE Linux and mail servers on
#selinux.  I've pasted all the public discussion below.

NoelJB is a major contributor to the JAMES mail server.  Please CC him
on any replies as he's not on the list (Howard please let his messages
through).

The MTA issues discussed below are only part of it.  To do things
properly we would need a MUA that has support for it (maybe multiple
instances running in different domains to prevent malicious messages
with untrusted content from attacking the mail server with secret
messages).


<rjc> I think it would be good to put SE Linux access controls in the
mail server.  I'm thinking of topsecret_r can't send mail to any domain
that can be in user_r.  Then having the mail server label messages on
the way through so that the same policy can be applied on all machines
on the internal network.
<NoelJB> rjc: WHAT-IF ... the sending server were to look up the public
key associated with a role at a domain and encrypt the message with that
key?  That message could only be decrypted by the private key associated
with that [role,domain].   So either via DNS, LDAP or whatever, we use
[role,domain,PKI] to handle it.
<rjc> The idea is that every machine will have several roles used for
sending and receiving email.  We want to apply SE Linux access controls
with the user-space object manager to enforce policies such that secret
data can't be emailed to untrusted users or machines.
<NoelJB> If there is no such [role,domain,pki], the server would refuse
to send the e-mail.
<rjc> I was thinking more along the lines of encrypting messages with a
key for the receiving server and just putting in a label to tell the
receiving server of the context of the message.  Having a key per role
could be good too, but we don't want all the SE Linux stuff in GPG keys.
The number of combinations of identity:role:domain and host may be
greater than the number of GPG keys we want.  It's easy to imagine
having 1000 users who each have
<rjc> access to five roles and a network with 100 servers all around the
world.  500,000 GPG keys won't work too well.  But a key per role per
server gives 500 keys which works well.
<NoelJB> encypting for the receiving machine is OK, but why not make
sure that it even supports that role?
<rjc> NoelJB: True.  Having role:server keys does some good.  But we
also want SE Linux identity checks, maybe for forwarding.
<NoelJB> Yes, once the message arrives there, the receiving machine,
which is authorized to handle mail for that role, would have to ensure
that the receiver (localpart) was ALSO in that role.  As I understand
the need.  We could try checking that first before sending, but that
could potentially get into all sorts of mapping issues.
<rjc> If a machine has a mailing list then the messages need to be
relabelled and we need relabelling rules to control this.
<NoelJB> right.  that's why I figured that the sender would only ensure
that the receiving server was authorized to handle mail in that role,
and the local part delivery issues would be the responsibility of the
receiving machine.
<NoelJB> Please ask anyone interested to contact me.  If there is
interest, perhaps I'll subscribe.  But I get far too much e-mail to
subscribe to yet another list if there isn't content I need to deal
with.  :)
<NoelJB> If there IS interest, and if we can start to agree on a
methodology, I'll push for its implementation in JAMES as a reference.
<snail> alternatively, labelled networking and bi-directional ssh gives
you all of this for free yes?
<snail> or is labelled networking a while off yet?
<NoelJB> snail: that would preclude the use of relays, amongst other
things.
<snail> NoelJB: true, but an application independent solution scales
more easily across the hundred protocols that people will eventually
want to secure.
<NoelJB> SSH isn't content aware.  And SMTP isn't SSH aware.  I don't
think you can shuffle it off to the transport like that.
<NoelJB> Besides, the cryptographic approach is about cryptographic
envelopes, not about protocol.
<NoelJB> It would not matter if I used the same approach and sent the
content by RFC 1149.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
