Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OK5KgA020954
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 16:05:20 -0400 (EDT)
Date: Tue, 24 May 2005 16:00:32 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: serue@us.ibm.com
cc: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>,
   <latten@us.ibm.com>
Subject: Re: A few performance results
In-Reply-To: <20050524195523.GB26030@serge.austin.ibm.com>
Message-ID: <Xine.LNX.4.44.0505241559400.4575-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 May 2005 serue@us.ibm.com wrote:

> > What filesystem are you using for this?
> 
> ext2.

Sorry, didn't read the start of the message properly.

Still, quite a bit of variation.  I've found you need at least ten dbench 
runs to get reliable results.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
