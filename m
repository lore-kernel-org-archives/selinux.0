Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6IK5Hu6020523
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 16:05:17 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6IK5G1F007136
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 20:05:17 GMT
Received: by py-out-1112.google.com with SMTP id c59so2139716pyc
        for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 13:05:16 -0700 (PDT)
Message-ID: <43af0f430607181305g117bf972t16359ed7938321e8@mail.gmail.com>
Date: Tue, 18 Jul 2006 16:05:11 -0400
From: "Stephen Smalley" <stephen.smalley@gmail.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for explicite ipc object labeling
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1153251363.2915.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1153251363.2915.76.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/18/06, Eric Paris <eparis@parisplace.org> wrote:
> At this point in time IPC objects (semaphores, message queues, etc) were
> labeled with the label of the process which created them.  This patch
> introduces a new /proc/self/attr/ipccreate which will allow a program to
> set the label on ipc objects it is about to create.  This may be useful
> in future trusted applications but at this time I do not know of any
> application which needs this functionality, but it should allow better
> more understandable policy to control access to ipc objects.
>
> In security/selinux/include/av_permissions.h the patch also adds a blank
> line at the end.  This was the output after the change to the
> access_vectors in policy and I did not edit that file by hand.

In that case, we should fix the script.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
