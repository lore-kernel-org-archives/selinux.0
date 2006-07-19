Message-ID: <44BE402E.4020407@tresys.com>
Date: Wed, 19 Jul 2006 10:22:38 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for explicite
 ipc	object labeling
References: <1153251363.2915.76.camel@localhost.localdomain>
In-Reply-To: <1153251363.2915.76.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
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
>
>   
This patch only adds a process permission for setipccreate, I think you 
need a permission check for the destination type (what you are labeling 
the ipc to), there are lots of potential info leaks even if the process 
can't subsequently write to the ipc.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
