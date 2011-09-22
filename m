Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MKfcfS000941
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 16:41:38 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MKfb1V028200
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:41:37 GMT
Message-ID: <1316724093.2259.74.camel@vortex>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 22 Sep 2011 22:41:33 +0200
In-Reply-To: <4E7B9233.6080609@redhat.com>
References: <4E7B9233.6080609@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-22 at 15:53 -0400, Daniel J Walsh wrote:
> Currently if I create a directory labeled
> 
> etc_t:s0:c1
> 
> And with a process running as unconfined_t:s0-s0:c0.c1023 create a
> file within the directory, the file gets created with the label
> etc_t:s0.   I would like to change the behavior to creating the file
> as etc_t:s0:c1.

It almost seems a bug to me (MCS category of parent directory is not
inherited upon new file creation)... especially if a user which has not
access to that specific category was currently able to read/write that
(uncategorized) file in a categorized directory.

> That way an administrator could modify files within a sandbox and have
> the files be labeled correctly.
> 
> I believe this behavior differs from MLS but believe this would be
> what the admin expects.
> 
> Is changing this a kernel or policy issue?

What the reference policy perhaps should NOT allow is the creation of a
file in the first place. I mean eventually the policy should not allow
the creation of an uncategorized file in a categorized directory.
Although it's a somewhat different issue, which can eventually be
defined later. We would first need to tackle the kernel (how things are
done), then we can eventually adjust the reference policy (define what
can and what cannot be done).

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
