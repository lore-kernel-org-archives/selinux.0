Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523xRrT001087
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:59:27 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52Brwbn010365
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:53:59 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 09:12:46 -0000
Date: Tue, 1 Jun 2004 09:10:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: exim (running from cron) attempting to write to logs under system_cron_t
Message-ID: <20040601091012.GN8312@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya russell,

what's this one about?

allow system_crond_t var_log_t:file { append };
        #EXE=/usr/sbin/exim  NAME=mainlog   :  append
		#EXE=/usr/sbin/exim  NAME=mainlog   :  append

i've installed exim as default, and i've not included
the attempts to write to the paniclog as it is banned
from writing to mainlog.

exim runs as a cron job and as an inetd.conf entry.

_exim4_ runs as a daemon.

both also run from /etc/ppp/ip-up.d triggers.

i do have cron-3.0pl1-selinux installed (newselinux .deb)

what should i be looking for?

sincerely,

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
