Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24677
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 09:01:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA13182
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 13:01:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA13178
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 13:01:02 GMT
Date: Mon, 2 Jul 2001 09:01:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.LNX.4.30.0107021131100.4791-100000@linux16.zdv.uni-tuebingen.de>
Message-ID: <Pine.SOL.3.95.1010702085931.13449D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> error in the statement ending on line 2196 (token ';'): unknown class capability used in rule

I posted a patch for this bug back on May 7th.  See
http://marc.theaimsgroup.com/?l=selinux&m=98926011507312&w=2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
