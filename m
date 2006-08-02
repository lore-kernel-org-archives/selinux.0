Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72KQ6C3009257
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 16:26:06 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72KPxeA026542
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 20:25:59 GMT
Date: Wed, 2 Aug 2006 15:25:57 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: SMP enabled restorecon
Message-ID: <20060802202557.GC5967@w-m-p.com>
References: <200607300117.23329.russell@coker.com.au> <200607302314.00725.russell@coker.com.au> <200607310012.02943.russell@coker.com.au> <44D10261.4020005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44D10261.4020005@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 02, 2006 at 03:52:01PM -0400, Daniel J Walsh wrote:
> You might want to look at what find is doing also, since it seems more 
> efficient that restorecon
> 
> time restorecon -R /etc
> real    0m5.729s
> 
> time find /etc/ | restorecon -f -
> real    0m5.153s

This might be the leaf optimization (see find(1), -noleaf), "find" uses
the directory hard link count to avoid stat()ing files when it knows that
they cannot be directories.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
