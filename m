Subject: Re: Authorization Workflow for Message Queueing Platform
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Kramer <josh@globalherald.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A09ABEF.50605@globalherald.net>
References: <4A09ABEF.50605@globalherald.net>
Content-Type: text/plain
Date: Mon, 18 May 2009 10:15:46 -0400
Message-Id: <1242656146.20082.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-12 at 13:03 -0400, Joshua Kramer wrote:
> Hello,
> 
> In considering the authorization workflow for a message queueing 
> platform - specifically, apache qpid - I came up with the following.  
> Please let me know how I can improve this.
> 
> Thanks,
> -Josh
> 
>  I.Definitions
>  A.In this narrative, "this Subject" means the process connecting to qpid.
>  II.Determine the Action.
>  A.If ACT_CREATE, ACT_DELETE:
>  i.Determine the object type.  If OBJ_QUEUE, determine if it is a 
> server-side or client-side queue.
>  ii.Determine if the Context of this Subject permits to CREATE or DELETE 
> Objects in the parent Object?  (i.e. are we allowed to create queues  in 
> this broker?)
>  a)Determine this by searching the SELinux context list first by finding 
> the map corresponding to object_type, then the map corresponding to the 
> parent's name. TODO: how do we determine the parent from this object as 
> passed in the Acl::authorise call?)

SELinux is not an ACL scheme, and thus you don't want to search a list
of security contexts associated with the object to decide whether
something is permitted.  Instead, you want to perform a SELinux
permission check using avc_has_perm() and friends, as is done by Xorg,
D-BUS, and SE-PostgreSQL.

>  b)If this is not permitted, deny and return.
>  iii.If command is create and Context does permit object creation:
>  a)If this is OBJ_QUEUE
> Does the Context of this Subject permit it to CREATE or DELETE queues of 
> the type noted in i above?  TODO: how do we represent "permitted to 
> create server queue" and "permitted to create client queue" in the 
> SELinux context list?
> If Context does permit creation:
> Add an item in the SELinux context list for this object.
> Inherit this Object's context from the parent, OR

Compute the default label using the security_compute_create(3) function.
This consults the security policy, particularly the type_transition
rules for the object class.

> Label according to the arguments passed in on the create call.
> Create the Object
> Return control
> Otherwise deny creation of object.
>  b)If this is an OBJ_EXCHANGE,
> Add an item in the SELinux context list for this object.
> Inherit this Object's context from the parent, OR
> Label according to the arguments passed in on the create call.
> Create the Exchange.
>  iv.If command is delete and Context does permit object deletion:
> Delete object as specified by method call.
> Delete object's reference in the SELinux context list.
>  B.If ACT_CONSUME, ACT_PUBLISH, ACT_ACCESS, ACT_BIND, ACT_UNBIND,  
> ACT_DELETE, ACT_PURGE, ACT_UPDATE:
>  i.Determine if the Context of this Subject permits the noted action on 
> the target Object:
>  a)Search the map of object types; when the target Object's Type is found,
>  b)Search the resulting map for this Object's ID.
>  c)Call security_compute_av to determine if this Subject is permitted to 
> access the target Object with the Subject's context.
>  ii.If Yes: Allow
>  iii.If No: Deny

Use the avc functions rather than directly calling security_compute_av.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
