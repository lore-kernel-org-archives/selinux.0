Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lACB7WBJ024171
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2007 06:07:33 -0500
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lACB7Vlg004226
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2007 11:07:31 GMT
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 3C2E78B67
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2007 12:06:23 +0100 (CET)
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: is the string "<<none>>" in a header anywhere?
Date: Mon, 12 Nov 2007 12:06:23 +0100
Message-ID: <87y7d3yb80.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Coreutils' install.c currently compares a context against the
magic string, "<<none>>":

  /* If there's an error determining the context, or it has none,
     return to allow default context */
  if ((matchpathcon (file, st.st_mode, &scontext) != 0) ||
      STREQ (scontext, "<<none>>"))
    {
      if (scontext != NULL)
        freecon (scontext);
      return;
    }

BTW, matchpathcon(8) does, too.
Is there a better way to test for that condition?
It'd be nice if that string were available via a libselinux header,
but I don't see it on rawhide:

    $ grep none $(rpm -ql libselinux-devel|grep -F .h)
    [Exit 1]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
