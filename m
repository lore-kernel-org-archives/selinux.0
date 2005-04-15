Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3F0oN7C022966
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 20:50:24 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3F0kaJd029620
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 00:46:36 GMT
Date: Thu, 14 Apr 2005 20:46:25 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Paul Moore <paul.moore@hp.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: You mentioned somewhere there is a step by step guide to getting
 the MLS policy installed on a machine?
In-Reply-To: <425ED188.3020008@hp.com>
Message-ID: <Xine.LNX.4.44.0504142045190.30142-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Apr 2005, Paul Moore wrote:

> I just wanted to get some clarification here as the MLS README is a 
> little vague in this area - assuming I have followed all of the install 
> instructions in the README file, what we be the correct label to use for 
> the mountpoints (one of the last steps in the install process), 
> especially the pseudo filesystems such as /proc?

In general you just add :s0 to the end of the existing context.

Use getfattr -n security.selinux to see what they are with selinux=0



- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
