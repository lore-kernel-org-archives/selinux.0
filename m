Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2FBqMDo028353
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 06:52:23 -0500 (EST)
Received: from mail-old.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2FBkUNq008531
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 11:46:31 GMT
Message-ID: <4236CB3C.80606@kaigai.gr.jp>
Date: Tue, 15 Mar 2005 20:47:08 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'SELinux Mail List'" <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
   selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <200503141638.j2EGbx8R007648@gotham.columbia.tresys.com>
In-Reply-To: <200503141638.j2EGbx8R007648@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Karl, Thanks for your comments.

 >> Interesting patch and I'm glad to see you use sediff for testing this - it has
 >> proven very valuable to use when doing work on checkpolicy for us as well. My
 >> concern for this (in addition to Steve's comments) is that it isn't general
 >> enough to solve many of the policy language problems that we commonly see. For
 >> example, this doesn't help with types that are derived on a per-role basis. This
 >> is a conceptually similar problem - I want user_ssh_t to be very similar
 >> staff_ssh_t with some differences - but requires some additional features. I am
 >> interested in extending this because right now it is not possible to easily add
 >> roles to binary policies, like the modules, because the per-role types are not
 >> correctly created.

In my understanding, your concern is that child type/domain always inherit
parent's attachments of roles, and this character make it hard to define
similar type/domain which belong to different roles.

It can be resolved by multi-layer type/domain inheritance.

e.g)
type generic_ssh_t;
type user_ssh_t extends generic_ssh_t;
type staff_ssh_t extends generic_ssh_t;

generic_ssh_t is attached some generic and necessary permissions and attributes,
but generic_ssh_t does not belong to any roles.
user_ssh_t and staff_ssh_t is defined as a child type of generic_ssh_t.
Those are attached specific permissions and attributes, and each type belong to
own roles.

This look like the usage of ATTRIBUTE. But we can't define multi-layer structure
for attribute on current checkpolicy. My extension make it possible.

 >> I don't have a concrete suggestion, but an example would be a policy syntax that
 >> could duplicate the ssh_domain macro. Instead of creating a type based on
 >> another type, it would be creating a type based on a 'type template'. This would
 >> allow creating user_ssh_t and staff_ssh_t, for example, with similar access in
 >> many cases, but also differences (e.g., user_home_ssh_t and staff_home_ssh_t or
 >> a different transition from ssh_exec_t).

Indeed, we can also define such types by 'type template' macros, I think.
But I wonder whether type configuration by multiple macros is enough easy
for general end-user or not.
My original motivation willing to implement TYPE ... EXTENDS is that
making it easier to define original type/domain by using an existing
correct type/domain definition, because defining a new type/domain from
scratch is required so wide knowledge for application, kernel, SELinux and macros.
(Education often requires massive cost.)
In many case, an imitation of existing type/domain is easier than
to enforce end-user learning about application, kernel, SELinux and macros.

Thanks.
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
