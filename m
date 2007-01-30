Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0UJX2xe012800
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 14:33:02 -0500
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0UJY0G1008604
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 19:34:01 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Subject: provoking fsetfilecon failure in a test case
Date: Tue, 30 Jan 2007 20:33:29 +0100
Message-ID: <87y7nk8g3a.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm adding a test case for the 'cp -a' failure reported here:

  http://bugzilla.redhat.com/219900

In my comment there, I asked this:

  I'd like to add a test script to exercise this fix, but depending on
  the existence of a writable, NFS-mounted partition is not a recipe for
  good coverage. Can anyone suggest an easier way to provoke fsetfilecon
  failure on a file we've just opened (but not created -- it already
  existed) for writing?

Any ideas?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
