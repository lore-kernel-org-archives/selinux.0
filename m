Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GDkaDo006794
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 08:46:36 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GDeTfp001169
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:40:33 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 0C70FC0DD
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:40:12 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DBYuW-0006GE-5r
	for selinux@tycho.nsa.gov; Wed, 16 Mar 2005 13:50:08 +0000
Date: Wed, 16 Mar 2005 13:50:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: concerns about object-inheritance wrt files/directories
Message-ID: <20050316135008.GA24000@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 for file types, i have a major concern.

 if not careful, we are going to be getting into the "multiple file
 types" thing again, which it has already been discussed that, whilst
 doable, has some hair-raising implications that make it too complex to
 a) understand for implementation purposes b) understand the resultant
 policy.


 kaigai proposed a scheme where he overlaid / associated the
 inheritance concept of "child" with "subdirectory".

 i am not sure if this was intentionally part of the _design_
 or whether it was just an example.

 i do not believe that the object-orientated scheme wrt. directories
 and subdirectories _should_ be overloaded in this fashion, but
 there is a sort-of precedent in the form of the file_type_auto_trans()
 macro so... *shrug* :)


 i believe that the issue of "multiple file contexts" is
 solvable and achievable by two topologically-equivalent methods
 which have already been discussed (namely, to place xattrs
 named "user_t,user_somethingelse_t" in security.selinux, and
 to derive, via some pre-processing stage, an intermediate name
 e.g.  user_t_user_somethingelse_t_unique_identifier_NNNNNN_t)

 however, both those methods have already been concluded as
 "difficult" - to understand or implement.

 
 the only sensible option left, really, therefore, is to make
 sure that file types are NOT inherited or inheritable!

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
