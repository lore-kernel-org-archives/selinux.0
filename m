Date: Mon, 18 May 2009 13:02:00 -0400 (EDT)
From: Joshua Kramer <josh@globalherald.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Authorization Workflow for Message Queueing Platform
In-Reply-To: <1242656146.20082.20.camel@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.0905181248510.11708@home-av-server.home-av>
References: <4A09ABEF.50605@globalherald.net> <1242656146.20082.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> SELinux is not an ACL scheme, and thus you don't want to search a list
> of security contexts associated with the object to decide whether
> something is permitted.  Instead, you want to perform a SELinux
> permission check using avc_has_perm() and friends, as is done by Xorg,

Thanks, Stephen.  I should have made it more clear that I do intend to use 
avc_has_perm() and friends.

One of the goals with integrating SELinux into Qpid is to make the ACL 
calls as portable as possible, so that you can swap out ACL plugins as 
needed.  There are a few ways to store SEL context information about 
objects in a program.  Embedding the context information in the object 
itself is the best solution.  However, to make code modular, we decided to 
create a map.  The map's key is the object name, and the data contains the 
selinux context.  So for each call to the authorize method, we get the 
object's name as string, then look up the context and use it with 
avc_has_perm() to determine pass/reject status.


-- 

-----
http://www.globalherald.net/jb01
GlobalHerald.NET, the Smarter Social Network! (tm)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
