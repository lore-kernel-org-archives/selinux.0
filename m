Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2EGkJDo022769
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2005 11:46:21 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2EGc5lg007052
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2005 16:38:05 GMT
Message-Id: <200503141638.j2EGbx8R007648@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>
Cc: <kaigai@ak.jp.nec.com>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Mon, 14 Mar 2005 11:38:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <42346C17.3090301@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of KaiGai Kohei
> Sent: Sunday, March 13, 2005 11:37 AM
> To: SELinux Mail List
> Cc: kaigai@ak.jp.nec.com
> Subject: [RFC & PATCH] inherited type definition.
> 
> Hello,
> This attached patch provids a new syntax extension to checkpolicy.
> This makes it possible to describe a definition of type which 
> inherit access vectors of parent's types/attributes.
> 
> Syntax:
> TYPE <type> [ALIAS <aliases>] EXTENDS <type/attr>, <type/attr>, ... ;
> 
> The basical idea is like attribute, but 'EXTENDS' has those 
> differences as follows:
> - It can inherit other types, not only attribute.
> - It can describe multi-layer inheritance tree of type.
> 

Interesting patch and I'm glad to see you use sediff for testing this - it has
proven very valuable to use when doing work on checkpolicy for us as well. My
concern for this (in addition to Steve's comments) is that it isn't general
enough to solve many of the policy language problems that we commonly see. For
example, this doesn't help with types that are derived on a per-role basis. This
is a conceptually similar problem - I want user_ssh_t to be very similar
staff_ssh_t with some differences - but requires some additional features. I am
interested in extending this because right now it is not possible to easily add
roles to binary policies, like the modules, because the per-role types are not
correctly created.

I don't have a concrete suggestion, but an example would be a policy syntax that
could duplicate the ssh_domain macro. Instead of creating a type based on
another type, it would be creating a type based on a 'type template'. This would
allow creating user_ssh_t and staff_ssh_t, for example, with similar access in
many cases, but also differences (e.g., user_home_ssh_t and staff_home_ssh_t or
a different transition from ssh_exec_t).

Comments?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 

> Currently, when we try to define a type like another type, we 
> must describe a new type from a scratch for tiny difference.  
> For example, if we want a new type 'ext_user_t' which is 
> permitted all access vectors for user_t and a tiny additional 
> access vectors, we must describe all of the user_t's access 
> vectors and some of original allow-statements.
> 
> When you use EXTENDS extension, only what you describe are a 
> type definition with EXTENDS statement and some original 
> allow-statements.
> 
> [Simple Example]
> type subject_t;
> type parent_t;
> type child_t extends parent_t;
> type grandchild_t extends child_t;
> type stranger_t;
> 
> In this case, there are five types for explanation.
> - "allow subject_t child_t:XXX XXX;" means "allow subject_t 
> {child_t grandchild_t}:XXX XXX".
> - "allow parent_t child_t:XXX XXX;" means "allow {parent_t 
> child_t grandchild_t} {child_t grandchild_t}:XXX XXX"
> - "allow subject_t ~parent_t:XXX XXX" means "allow subject_t 
> stranger_t:XXX XXX".
>   child_t and grandchild_t are not included in ~parent_t, 
> because its ancestor is parent_t.
> - "allow child_t self:XXX XXX" means "allow child_t child_t:XXX XXX",
>   "allow child_t grandchild_t:XXX XXX" and "allow 
> grandchild_t grandchild_t:XXX XXX".
> 
> An access vector granted to parent-type is inherited to child 
> and grandchild.
> We must pay attention to '~' and 'self'.
> When we use '~', that means the reverse of the type and its children.
> When we use 'self', that means the type and its children.
> 
> Thanks, any comments please.
> # This is a personal work, but would you Cc: 
> 'kaigai@ak.jp.nec.com' for useful ?
> 
> --------------------------------------------------------------------
> When we don't use EXTENDS statement, checkpolicy works compatibly.
> I tried to test checkpolicy-1.20 with EXTENDS patch by 
> Tresys's sediff and policy-1.20.
> 
> Test 1: compatibility of the checkpolicy [kaigai@ayu ~]$ 
> sediff polbin.org polbin.std Difference between policy 1 and policy 2:
>    p1 (binary, ver: 18): polbin.org ... generated by standard 
> checkpolicy
>    p2 (binary, ver: 18): polbin.std ... generated by extended 
> checkpolicy
> 
> Types (0 Added, 0 Removed, 0 Changed)
>         Added Types: 0
>         Removed Types: 0
>         Changed Types: 0
> 
> Roles (0 Added, 0 Removed, 0 Changed)
>         Added Roles: 0
>         Removed Roles: 0
>         Changed Roles: 0
> 
> Users (0 Added, 0 Removed, 0 Changed)
>         Added Users: 0
>         Removed Users: 0
>         Changed Users: 0
> 
> Booleans (0 Added, 0 Removed, 0 Changed)
>         Added Booleans: 0
>         Removed Booleans: 0
>         Changed Booleans: 0
> 
> Classes (0 Added, 0 Removed, 0 Changed)
>         Added Classes: 0
>         Removed Classes: 0
>         Changed Classes: 0
> 
> Permissions (0 Added, 0 Removed)
>         Added Permissions: 0
>         Removed Permissions: 0
> 
> Common Permissions (0 Added, 0 Removed, 0 Changed)
>         Added Common Permissions: 0
>         Removed Common Permissions: 0
>         Changed Common Permissions: 0
> 
> Conditionals are not currently supported.
> Role Allows (0 Added, 0 Removed, 0 Changed)
>         Added Role Allows: 0
>         Removed Role Allows: 0
>         Changed Role Allows: 0
> 
> TE Rules (0 Added, 0 Removed, 0 Changed)
>         Added TE Rules 0:
>         Removed TE Rules 0:
>         Changed TE Rules 0:
> 
> Total Differences:
>         Classes & Permissions 0
>         Types 0
>         Attributes 0
>         Roles 0
>         Users 0
>         Booleans 0
>         Rbac 0
>         TE Rules 0
> 
> --------------------------------------------------------------
> ------------
> Test 2: The advantage of EXTENDS statement.
>         I added a line 'type user_ext_t extends user_t;' into 
> policy.conf.
> [kaigai@ayu ~]$ sediff polbin.std polbin.ext Difference 
> between policy 1 and policy 2:
>    p1 (binary, ver: 18): polbin.std ... original policy-1.20
>    p2 (binary, ver: 18): polbin.ext ... I added a type definition.
> 
> Types (1 Added, 0 Removed, 0 Changed)
>         Added Types: 1
>                 + user_ext_t
>         Removed Types: 0
>         Changed Types: 0
> 
> Roles (0 Added, 0 Removed, 1 Changed)
>         Added Roles: 0
>         Removed Roles: 0
>         Changed Roles: 1
>                 * user_r (1 Added Types)
>                         + user_ext_t
> 
> Users (0 Added, 0 Removed, 0 Changed)
>                       :
>                   <Omitted>
>                       :
> TE Rules (1766 Added, 0 Removed, 0 Changed)
>         Added TE Rules 1766:
>                 + allow load_policy_t user_ext_t : fd { use };
>                       :
>                   <Omitted>
>                       :
>                 + allow ifconfig_t user_ext_t : fd { use };
>         Removed TE Rules 0:
>         Changed TE Rules 0:
> 
> Total Differences:
>         Classes & Permissions 0
>         Types 1
>         Attributes 0
>         Roles 1
>         Users 0
>         Booleans 0
>         Rbac 0
>         TE Rules 1766
> 
> --
> DO NOTHING IS THE WORST POLICY.
> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
