Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h92BhXsJ001849
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 07:43:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h92BfeZt015771
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 11:41:40 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h92BfdM3015768
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 11:41:39 GMT
Date: Thu, 2 Oct 2003 07:43:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: assertions in kernel
In-Reply-To: <Pine.LNX.4.44.0310011227210.13429-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310020733290.16953-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003, James Morris wrote:

> I don't think relabeling files from kernelspace is a good idea.  A better 
> approach may be to use an implicit label if a kernel assertion fails.

Just to clarify following an off-list enquiry, what I mean by an implicit
label is that the kernel returns 'unlabeled_t' following an assertion
failure for a file, but does not change the disk structure.  This should
be transparent to the user APIs.


- James
-- 
James Morris
<jmorris@redhat.com>







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
