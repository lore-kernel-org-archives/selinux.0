Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83Gl3rT009008
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 12:47:03 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83GkCFY019453
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:46:13 GMT
Received: from lkcl.net (th-pm03-32.ndirect.co.uk [195.7.225.160])
	by open.hands.com (Postfix) with ESMTP id DAB2BC006
	for <selinux@tycho.nsa.gov>; Fri,  3 Sep 2004 17:46:51 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C3HNL-0000HF-Se
	for selinux@tycho.nsa.gov; Fri, 03 Sep 2004 17:57:23 +0100
Date: Fri, 3 Sep 2004 17:57:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [idea] file contexts "alternate" keyword
Message-ID: <20040903165723.GA31857@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

other possible uses of the "alternate" file context entries, made
available via a keyword extension:

mozilla, for file saving.

steven tweedie described a possible scenario in which a "helper" popup
program responded when mozilla tries to save a file.

by specifying a "keyword" e.g. "mozillahelperdownloadpasswordwasvalid"
at the end of a file context line, the helper program need only
add the appropriate keyword to the extendedmatchpathcon() function:

# this line ONLY gets activated if the mozilla helper program specifies
# the keyword to use it.
HOME_DIR/downloads/.+      ROLE_home_t mozillahelperdownloadpasswordwasvalid

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
