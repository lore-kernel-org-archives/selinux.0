Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TL7VXZ011962
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 17:07:31 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TL7Nsx027143
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 21:07:23 GMT
Date: Fri, 29 Oct 2004 22:18:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041029211809.GJ8897@lkcl.net>
References: <4182959B.4080503@trustedcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4182959B.4080503@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 29, 2004 at 02:10:19PM -0500, Darrel Goeddel wrote:

>       The motivator behind this proposal is to provide a mechanism for a
> trusted application (one written to leverage the security policy) to be
> able to remove unnecessary privileges when they are no longer needed, as
> well as temporarily raise the privilege level to perform certain
> operations and then return to a less privileged level.  

 in principle i like it: in practice i believe it to be seriously
 fraught unless tightly controlled.

 how can you guarantee the circumstances under which security
 "escalation" is done?


 ultimately, i believe it far more sensible for applications to be
 rewritten to take advantage of exec() and the abundantly clear
 context division that entails.

 the less-privileged program exec()s a command which, via
 domain_auto_trans, automatically grants that command more
 privileges.

 if speed is of paramount concern, then the "more" privileged
 executable can be made to run in advance, and dormant: file
 handles can be passed over unix domain sockets between the
 "less" privileged and the "more" privileged program (or
 vice-versa).

 l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
