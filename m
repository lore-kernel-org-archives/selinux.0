Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01983
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 10:31:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA07536
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:29:17 GMT
Received: from smails.tresys.com ([66.200.42.5])
        by jazzband.ncsc.mil  with ESMTP id OAA07532 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:29:16 GMT
Received: from acme ([66.200.42.2])
	(authenticated (0 bits))
	by smails.tresys.com (8.12.5/8.11.6) with ESMTP id g8OEZ8Ca000981
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 10:35:08 -0400
From: "david caplan" <dac@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: checkpolicy and login names
Date: Tue, 24 Sep 2002 10:32:00 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGKEKGCFAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <001001c263cc$de4ef570$6600a8c0@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We just ran across the case where we were trying to add a login name with a
'.' in it.  When we tried to add the user to the policy, checkpolicy choked
on the '.' in the id.  The parser expects an Identifier, which is defined to
be a letter followed by a combination of letter|digit|_ of any length.

Is there a compelling reason that this definition can't be changed?  I'm not
sure if changing it would cause problems elsewhere in the policy mechanism.
There don't appear to be problems with using '.'s and '-'s in login names as
far as RedHat/Linux is concerned. I can't find any "standard" definition for
what are valid characters in a login name.  Some applications, such as ps,
that have problems with the characters just use the uid instead.  Others,
such as sendmail/pop and ssh, don't have a problem (at least in the versions
we're using).

david


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
