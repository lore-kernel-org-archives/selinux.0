Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HIMbrT015531
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 14:22:37 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HIMZKV026115
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 18:22:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 8B341C0E6
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:22:35 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 28639-05-4 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 19:22:33 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 88E88C0E4
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:22:33 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bx8lj-0005UH-Ac
	for selinux@tycho.nsa.gov; Tue, 17 Aug 2004 19:33:11 +0100
Date: Tue, 17 Aug 2004 19:33:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: policy for k3b (and cdrecord)
Message-ID: <20040817183311.GR18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm writing a policy for k3b (kde cd burner) and cdrecord because
write access by users to /dev/hdc is banned (policy violation) and
because, well, because.

sadly, k3b uses find to search the ENTIRE drive e.g. /dev and /
and stuff and so i get a whole stack of search and read permissions
requested.

this i can put up with by banning with dontaudit: i can do this because
i actually don't _want_ users to burn CDs with k3b except from anything from
their home directory, and any excessive number of dontaudits i am
personally quite happy with.

(and for backup purposes they can have a nice shiny button on the
desktop, using a different program, which will get its own nice policy
file).

my question is, therefore:

- for more generic use, obviously k3b must be allowed to access pretty
  much anything on / so what should i put in place of all the
  dontaudits and allow k3b_t user_home_t etc. stuff?

ta,

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
