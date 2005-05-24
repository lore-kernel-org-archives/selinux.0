Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OKaNgA021263
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 16:36:23 -0400 (EDT)
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4OKVKlt017641
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 20:31:21 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4OKVbLK486212
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 16:31:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4OKVbGO090850
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 14:31:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4OKVb8I007564
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 14:31:37 -0600
Date: Tue, 24 May 2005 15:31:28 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, latten@us.ibm.com
Subject: Re: A few performance results
Message-ID: <20050524203128.GA6602@sergelap.austin.ibm.com>
References: <20050524195523.GB26030@serge.austin.ibm.com> <Xine.LNX.4.44.0505241559400.4575-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0505241559400.4575-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@redhat.com):
> On Tue, 24 May 2005 serue@us.ibm.com wrote:
> 
> > > What filesystem are you using for this?
> > 
> > ext2.
> 
> Sorry, didn't read the start of the message properly.
> 
> Still, quite a bit of variation.  I've found you need at least ten
> dbench 
> runs to get reliable results.

This was the default with our test harness - not sure why.  We'll bump
that up.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
