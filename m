Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2G4fKDo004713
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 23:41:26 -0500 (EST)
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2G4ZLfp015450
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 04:35:22 GMT
Message-ID: <4237B798.5010303@ak.jp.nec.com>
Date: Wed, 16 Mar 2005 13:35:36 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
References: <200503151400.j2FE0t8R014737@gotham.columbia.tresys.com>
In-Reply-To: <200503151400.j2FE0t8R014737@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Karl, Thanks for your comments.

> Not exactly - that is certainly one problem, but the main problem is that I want
> the ability to create a group of types based on another group of types, e.g. I
> want to create staff_ssh_t and staff_home_ssh_t based on the corresponding user
> types. In this model staff_ssh_t wouldn't have any access to user_home_ssh_t,
> instead it will have the same access that user_ssh_t has to user_home_ssh_t
> except to staff_home_ssh_t.

OK, I have misunderstood about your concern.

BTW, I don't think your 'group of types' idea conflicts with my patch.
Because the results of "TYPE ... EXTENDS" look like two similar type/domain in binary level,
any existing tools can handle the generated policy binary without any problems.
(Thus, I adopted sediff to check the patched checkpolicy.)
How does your ideas work ? and, how does conflict with "TYPE ... EXTENDS" approach?


>>This look like the usage of ATTRIBUTE. But we can't define
>>multi-layer structure for attribute on current checkpolicy.
>>My extension make it possible.
>
> I'm not certain what you mean here - if generic_ssh was an attribute with a
> defined set of permissions, this would work almost the same. The
> user/staff_ssh_t would need some additional attributes in addition to
> generic_ssh, but otherwise this is very similar. Can you explain the advantage
> to your suggestion in more detail?

Yes, those works similarly. But current implementation of attribute doesn't
permit such a usage. In above example, generic_ssh is attached some attributes,
but we can't attach any attributed to attribute on current checkpolicy.
Because "TYPE ... EXTENDS" statement is implemented by existing attribute
implementation, this extension has similar functionality is natural.
This extensiton make it possible to define multiple-layer type/domain with
minimum modification and enough compatibility.

> It may be easier, but it is fundamentally dangerous. A user that simply extends
> an existing type without understanding the access granted to that type is
> potentially granting a new type excessive access. I think that there are real
> capabilities that are needed in the language, but I disagree with adding this
> syntax simply for ease-of-use. I think that there are other methods to make it
> easier for users to author policy without these dangers.

Since we can't enforce end-user to apply specific configuration, it's possible
to happen an excessive access in anywhere. I think end-user should select
the best way corresponding to own skill and so on.
Providing another options is not bad.

Thanks,
--
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
