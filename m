Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10222
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:59:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA18793
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:58:05 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id MAA18789
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:58:04 GMT
Date: Fri, 19 Apr 2002 15:00:46 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
Message-ID: <20020419150046.A19154@lemuria.org>
References: <20020419143800.B18906@lemuria.org> <Pine.GSO.4.33.0204190845550.18117-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204190845550.18117-100000@raven>; from sds@tislabs.com on Fri, Apr 19, 2002 at 08:47:41AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 19, 2002 at 08:47:41AM -0400, Stephen Smalley wrote:
> The init scripts should be run via run_init by an administrator.  A domain
> transition is not sufficient, as it does not address the user identity or
> role attributes, and a direct transition poses risks from malicious code.

That makes sense and leaves just one question: Why then do some of the
program.te files contain a domain transition for the sysadmin user?
snort is one example.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
