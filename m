Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24060
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 09:04:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PE4dI09538
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:04:40 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1PE4df09532 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:04:39 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Wayne Salamon'" <wsalamon@tislabs.com>
Cc: "'Russell Coker'" <russell@coker.com.au>,
        "'Clem Skorupka'" <ragnor@mitre.org>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: Core policy
Date: Tue, 25 Feb 2003 09:04:18 -0500
Message-ID: <001401c2dcd6$d237f5b0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.33.0302250628140.1479-100000@vox.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> #TITLE - The title, 30 characters or less (replaces the #DESC tag)
> #DESCRIPTION (or #DESC) - Description, not limited in length

While this is a reasonable suggestions, we for one already have released
tools that assumes a semantic for #DESC.  By changing that, you put us
in a position of changing the tool (easy) while remaining backwards
compatible with older policies that other still use (very difficult if
you redefine a given tag).  At a minimum I would ask that you leave
#DESC and #TITLE as synonyms to aid with maintaining backwards
compatibility.  Really I would prefer if we just keep with the #DESC as
the short description (or title) tag.

In any event if #DESC is being changed in the next release please give
us some warning so we can update sepcut and test it, and try to figure
out some type backwards compatibility scheme.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
