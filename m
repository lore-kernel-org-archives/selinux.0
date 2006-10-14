Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9EKBQRH013164
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 16:11:26 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9EKAexJ029025
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 20:10:44 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>, "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
Date: Sat, 14 Oct 2006 15:10:15 -0500
Message-ID: <001b01c6efcc$c41f4bb0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610140332010.13740@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Yep, this may be the best way forward.

Not really so. Please see my response to Paul.

The best step forward really would be to let naming catchup
with the semantics.

I have the following specific proposals in this regard:

1. Use "secpoint" or a close relative for the module name.
   I know you won't have none of it. Is it because there's
   another LSM that might use it with the original semantics?
   If so, should we then have a new "secpoint" module? I ask
   because Chris PeBenito was the latest victim of the confusion
   arising from here.

2. Leave the "packet" class with the recv perm, but place the
   "relabelto", "flow_in" and "flow_out" perms in a new secpoint class.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
