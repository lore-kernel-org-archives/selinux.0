Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i53L6prT015229
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 17:06:51 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5451L8m002963
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 01:01:21 -0400 (EDT)
Date: Thu, 3 Jun 2004 21:04:13 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, samba-technical@samba.org,
   tng-technical@lists.samba-tng.org
Subject: Re: samba
Message-ID: <20040603210413.GI3856@lkcl.net>
References: <200406031543.15551.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406031543.15551.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

just to _really_ put the cat among the pigeons: remember that
there is also "svcctl" - a DCE/RPC service that allows the
creation (including under which user context), management,
starting and stopping of services.

in other words, if this service was implemented under samba(3),
(i am not privy to the designs of samba(4)) then the SE/Linux
policy required would have to pretty much allow everything.

whereas, with the samba tng approach, you only need give the
svcctld - the service control daemon - sufficient privileges
to be able to exec "run_init /etc/init.d/startstopscript"
without requiring a password.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
