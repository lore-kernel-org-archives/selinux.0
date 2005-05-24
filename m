Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OK07gA020867
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 16:00:07 -0400 (EDT)
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4OJtLMp004852
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 19:55:21 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4OJtLua139264
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 15:55:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4OJtLGO142560
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 13:55:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4OJtK7B025156
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 13:55:20 -0600
Date: Tue, 24 May 2005 14:55:23 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: serue@us.ibm.com, SELinux <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, latten@us.ibm.com
Subject: Re: A few performance results
Message-ID: <20050524195523.GB26030@serge.austin.ibm.com>
References: <20050524180516.GA25663@serge.austin.ibm.com> <Xine.LNX.4.44.0505241535140.4575-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0505241535140.4575-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@redhat.com):
> On Tue, 24 May 2005 serue@us.ibm.com wrote:
> 
> > ******************************************************************
> > dbench
> > ******************************************************************
> > no selinux:
> > 
> > 4 clients started
> >    0     62477  1453.84 MB/sec
> > Throughput 1453.74 MB/sec 4 procs
> > 
> > 4 clients started
> >    0     62477  1427.67 MB/sec
> > Throughput 1427.57 MB/sec 4 procs
> > 
> > 
> > with selinux:
> > 
> > 4 clients started
> >    2     61326  1366.68 MB/sec
> >    0     62477  1347.72 MB/sec
> > Throughput 1347.66 MB/sec 4 procs
> > 
> > 4 clients started
> >    2     54192  1213.94 MB/sec
> >    0     62477  1151.10 MB/sec
> > Throughput 1151.05 MB/sec 4 procs
> 
> What filesystem are you using for this?

ext2.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
