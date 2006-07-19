Subject: RE: [PATCH] SELinux: new /proc/self/attr/ipccreate for expliciteipc	object labeling
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 19 Jul 2006 10:59:07 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
In-Reply-To: <1153320137.2864.0.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Eric Paris" <eparis@parisplace.org>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>, <jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Wed, 2006-07-19 at 10:22 -0400, Joshua Brindle wrote:
> > Eric Paris wrote:
> > > At this point in time IPC objects (semaphores, message 
> queues, etc) 
> > > were labeled with the label of the process which created 
> them.  This 
> > > patch introduces a new /proc/self/attr/ipccreate which 
> will allow a 
> > > program to set the label on ipc objects it is about to 
> create.  This 
> > > may be useful in future trusted applications but at this 
> time I do 
> > > not know of any application which needs this 
> functionality, but it 
> > > should allow better more understandable policy to control 
> access to ipc objects.
> > >
> > > In security/selinux/include/av_permissions.h the patch 
> also adds a 
> > > blank line at the end.  This was the output after the 
> change to the 
> > > access_vectors in policy and I did not edit that file by hand.
> > >
> > >   
> > This patch only adds a process permission for setipccreate, I think 
> > you need a permission check for the destination type (what you are 
> > labeling the ipc to), there are lots of potential info 
> leaks even if 
> > the process can't subsequently write to the ipc.
> > 
> 
> This is covered by the existing create permissions on the IPC 
> objects since this is not a relabel but object creation.
> 

Ah, you are right, somehow I forgot that those checks already existed.
Is this intended to only do sysv IPC or will it be expanded later? I ask
because there are more IPC types than just sysv so if a user thinks this
will label their posix message queues they would be misled.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
