Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2FE72Do029097
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 09:07:02 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2FDwcNK003253
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 13:58:38 GMT
Message-Id: <200503151400.j2FE0t8R014737@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>
Cc: "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <kaigai@ak.jp.nec.com>,
   <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Tue, 15 Mar 2005 09:00:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <4236CB3C.80606@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: KaiGai Kohei [mailto:kaigai@kaigai.gr.jp] 
> Sent: Tuesday, March 15, 2005 6:47 AM
> To: Karl MacMillan
> Cc: 'SELinux Mail List'; kaigai@ak.jp.nec.com; selinux-dev@tresys.com
> Subject: Re: [RFC & PATCH] inherited type definition.
> 
> Hi Karl, Thanks for your comments.
> 
>  >> Interesting patch and I'm glad to see you use sediff for 
> testing this - it has  >> proven very valuable to use when 
> doing work on checkpolicy for us as well. My  >> concern for 
> this (in addition to Steve's comments) is that it isn't 
> general  >> enough to solve many of the policy language 
> problems that we commonly see. For  >> example, this doesn't 
> help with types that are derived on a per-role basis. This  
> >> is a conceptually similar problem - I want user_ssh_t to 
> be very similar  >> staff_ssh_t with some differences - but 
> requires some additional features. I am  >> interested in 
> extending this because right now it is not possible to easily 
> add  >> roles to binary policies, like the modules, because 
> the per-role types are not  >> correctly created.
> 
> In my understanding, your concern is that child type/domain 
> always inherit parent's attachments of roles, and this 
> character make it hard to define similar type/domain which 
> belong to different roles.
> 

Not exactly - that is certainly one problem, but the main problem is that I want
the ability to create a group of types based on another group of types, e.g. I
want to create staff_ssh_t and staff_home_ssh_t based on the corresponding user
types. In this model staff_ssh_t wouldn't have any access to user_home_ssh_t,
instead it will have the same access that user_ssh_t has to user_home_ssh_t
except to staff_home_ssh_t.

> It can be resolved by multi-layer type/domain inheritance.
> 
> e.g)
> type generic_ssh_t;
> type user_ssh_t extends generic_ssh_t;
> type staff_ssh_t extends generic_ssh_t;
> 
> generic_ssh_t is attached some generic and necessary 
> permissions and attributes, but generic_ssh_t does not belong 
> to any roles.
> user_ssh_t and staff_ssh_t is defined as a child type of 
> generic_ssh_t.
> Those are attached specific permissions and attributes, and 
> each type belong to own roles.
> 

This would define the shared access that staff_ssh_t and user_ssh_t have, but
doesn't address the related types that are needed (e.g., staff_home_ssh_t).

> This look like the usage of ATTRIBUTE. But we can't define 
> multi-layer structure for attribute on current checkpolicy. 
> My extension make it possible.
> 

I'm not certain what you mean here - if generic_ssh was an attribute with a
defined set of permissions, this would work almost the same. The
user/staff_ssh_t would need some additional attributes in addition to
generic_ssh, but otherwise this is very similar. Can you explain the advantage
to your suggestion in more detail?

>  >> I don't have a concrete suggestion, but an example would 
> be a policy syntax that  >> could duplicate the ssh_domain 
> macro. Instead of creating a type based on  >> another type, 
> it would be creating a type based on a 'type template'. This 
> would  >> allow creating user_ssh_t and staff_ssh_t, for 
> example, with similar access in  >> many cases, but also 
> differences (e.g., user_home_ssh_t and staff_home_ssh_t or  
> >> a different transition from ssh_exec_t).
> 
> Indeed, we can also define such types by 'type template' 
> macros, I think.
> But I wonder whether type configuration by multiple macros is 
> enough easy for general end-user or not.

I don't want to use macros because it requires source - I am looking for a
construct in the language that the binary modules can utilize. Obviously, for
the ssh example there would also need to be syntax that stated that this type
template should be instantiated for each role.

> My original motivation willing to implement TYPE ... EXTENDS 
> is that making it easier to define original type/domain by 
> using an existing correct type/domain definition, because 
> defining a new type/domain from scratch is required so wide 
> knowledge for application, kernel, SELinux and macros.
> (Education often requires massive cost.) In many case, an 
> imitation of existing type/domain is easier than to enforce 
> end-user learning about application, kernel, SELinux and macros.
> 

It may be easier, but it is fundamentally dangerous. A user that simply extends
an existing type without understanding the access granted to that type is
potentially granting a new type excessive access. I think that there are real
capabilities that are needed in the language, but I disagree with adding this
syntax simply for ease-of-use. I think that there are other methods to make it
easier for users to author policy without these dangers.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 

> Thanks.
> --
> DO NOTHING IS THE WORST POLICY.
> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
