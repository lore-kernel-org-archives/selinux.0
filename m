Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S9tvDo024030
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 04:55:57 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S9qVUJ014473
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 09:52:32 GMT
Date: Mon, 28 Mar 2005 11:04:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: Re: Desktop apps interoperability
Message-ID: <20050328100449.GC3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111985855.1514.70.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Mar 27, 2005 at 11:57:35PM -0500, Ivan Gyurdiev wrote:

> There can't be more than one file_type_auto_trans on the same folder
> type (right?). 

 bizarrely, no.

 i believe this issue was raised some months ago, with the
 "alternative file context" thing.

 if file_type_auto_trans also took an executable [domain] as an
 additional argument, i believe you stand a chance of achieving
 what you seek.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
