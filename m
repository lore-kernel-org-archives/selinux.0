Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OJeSgA020609
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 15:40:29 -0400 (EDT)
Date: Tue, 24 May 2005 15:35:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: serue@us.ibm.com
cc: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>,
   <latten@us.ibm.com>
Subject: Re: A few performance results
In-Reply-To: <20050524180516.GA25663@serge.austin.ibm.com>
Message-ID: <Xine.LNX.4.44.0505241535140.4575-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 May 2005 serue@us.ibm.com wrote:

> ******************************************************************
> dbench
> ******************************************************************
> no selinux:
> 
> 4 clients started
>    0     62477  1453.84 MB/sec
> Throughput 1453.74 MB/sec 4 procs
> 
> 4 clients started
>    0     62477  1427.67 MB/sec
> Throughput 1427.57 MB/sec 4 procs
> 
> 
> with selinux:
> 
> 4 clients started
>    2     61326  1366.68 MB/sec
>    0     62477  1347.72 MB/sec
> Throughput 1347.66 MB/sec 4 procs
> 
> 4 clients started
>    2     54192  1213.94 MB/sec
>    0     62477  1151.10 MB/sec
> Throughput 1151.05 MB/sec 4 procs

What filesystem are you using for this?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
