Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3HNS97C008390
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 19:28:09 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3HNNoPp013880
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 23:23:52 GMT
Date: Mon, 18 Apr 2005 00:33:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: ivg2@cornell.edu, dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ PATCH ] Cumulative patch - various fixes, untrusted_content_t, mozilla, gnome types
Message-ID: <20050417233312.GI18167@lkcl.net>
References: <1113445869.6139.52.camel@cobra.ivg2.net> <200504172346.39313.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200504172346.39313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Apr 17, 2005 at 11:46:34PM +1000, Russell Coker wrote:

> Mozilla will desire read/write access to the .gconf directory and it's files 

 not under circumstances where it's built with kde support, it won't.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
