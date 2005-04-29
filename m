Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3TFuvgA004331
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 11:56:57 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3TFuNU2001442
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 15:56:23 GMT
Message-Id: <200504291556.j3TFuL8R005277@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Cc: "'Fedora SELinux support  list for users &amp; developers.'" <fedora-selinux-list@redhat.com>
Subject: MLS permission map
Date: Fri, 29 Apr 2005 11:56:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been working through the new MLS implementation (a nice improvement by
the way). I see how the old method of mapping permissions to read or write
is changed and instead these ideas are implemented in the constraints
definitions. I like that too since a policy writer can tweak their notion of
reads and writes (which given the volume of covert channels that will be
present, will allow one to change how strict they want to be). 

My question is: although the mapping is not explicit, it is still there. In
the current sample policy, has someone captured the justification for which
permissions are restricted and which are not? Which are being treated as
reads, writes, both or neither? Ultimately for any certifiable security
policy we'll need to justify this mapping. I specially ask both to see if
the model we have built into apol's permmap is consistent with the MLS
mappings, as well as for the reference policy work we're doing that Karl
mentioned earlier. Thanks Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
