Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1FshXZ026970
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 10:54:43 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1FrNCC005634
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:53:23 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, Frank Mayer <mayerf@tresys.com>
In-Reply-To: <4182959B.4080503@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
Content-Type: text/plain
Message-Id: <1099324262.21386.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 10:51:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 15:10, Darrel Goeddel wrote:
> A process may also
> jump between multiple MLS labels and perform actions at each.
<snip>
> The chain
> of allowable dynamic  transitions is also controlled on a context-pair
> basis.  This allows a "dynamic  transition group" to be treated as an
> equivalence class for policy analysis.

These two statements seem to be in conflict to me.  Whereas you might be
able to legitimately collapse multiple domains into a single equivalence
class for information flow analysis purposes, I don't see how this is
legitimate for levels.  If they were separate levels in the first place,
then they should be separate equivalence classes for information flow. 
Can you clarify?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
