Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VIcwHa004789
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 14:38:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VIcvDW018413
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:38:57 GMT
Received: from relay.pair.com (relay.pair.com [209.68.1.20])
        by jazzband.ncsc.mil  with SMTP id h6VIcueN018406 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:38:56 GMT
From: "Hariharan Gopalan" <hari@sapta.com>
To: <selinux@tycho.nsa.gov>
Subject: Error while installing:
Date: Thu, 31 Jul 2003 14:38:57 -0400
Message-ID: <MBEOIIDPALLENBNPLKLCIEPLHOAA.hari@sapta.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello

I am getting this error while making quickinstall:

It looks like the policy for inetd. My system uses xinetd, and so I did
notmove the inetd.te from unused, but I could not find a xinted.te...

Any pointers?

thanks
Hari



/usr/local/selinux/bin/checkpolicy:  loading policy configuration from
/etc/security/selinux/src/policy.conf
ERROR 'unknown type inetd_t' at token ';' on line 30882:
allow ftpd_t inetd_t:fd use;
#line 6070
/usr/local/selinux/bin/checkpolicy:  error(s) encountered while parsing
configuration
make[1]: *** [/etc/security/selinux/policy.12] Error 1
make[1]: Leaving directory `/usr/src/down/secure/selinux/policy'
make: *** [quickinstall] Error 2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
