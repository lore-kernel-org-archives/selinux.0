Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q21AwTc9003205
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2012 05:58:29 -0500
Message-ID: <4F4F564C.3060007@windriver.com>
Date: Thu, 1 Mar 2012 18:58:20 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: setools' seinfo/sesearch and role_attribute support?
References: <CAPzO=Nyg=3_zgJLkerke29QG4f2Vk=xG=HzsfhsqjoWsGL5yJg@mail.gmail.com>
In-Reply-To: <CAPzO=Nyg=3_zgJLkerke29QG4f2Vk=xG=HzsfhsqjoWsGL5yJg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 03/01/2012 02:52 AM, Sven Vermeulen wrote:
> Hi guys,
>
> Is it possible to update setools (and, more specifically, seinfo and
> sesearch to support role_attribute queries as well? I find those two
> tools very useful to query the policy, often in search for why certain
> things are failing (for instance, see which types match which type
> attributes, which user roles can "be in" particular types, etc.
>

Unfortunately, the role attributes won't be written to the final 
policy.X, since their destiny has been fulfilled during link and 
expansion, with all their capabilities (being able to bond with various 
types) having been properly propagated to all their sub-roles. In 
consequence, seinfo won't be used to query role attributes since they 
don't exist in the policy.X in the first place.

Instead, I would suggest maybe it's desirable for you to fall back 
checking one of the sub-roles that belong to a role attribute via 
"seinfo -r -x", if you doubt if a role attribute has not typed with 
enough types. For example, when I found sysadm_r was unable to type with 
newrole_t, I am almost certain newrole_roles that contains sysadm_r 
should have been typed with newrole_t.

Thanks,
Harry


> With the 20120215 refpolicy release, role attributes are used
> extensively, but there are some quirks here and there that are easily
> solved, but might be a bit more challenging to debug if all you have
> to debug with are the sources. For instance, I found that
> mozilla_plugin_t isn't part of mozilla_roles yet (yes, Chris, I'll
> send up the patch later when most of the testing has been done ;-)
>
> If I could do something like:
>   ~$ seinfo -tmozilla_t -x
> to see that this one is part of mozilla_roles, and
>    ~$ seinfo -tmozilla_plugin_t -x
> isn't, then I can quickly deduce that this is what I need to patch.
>
> Similarly, using sesearch with --role_source supporting role
> attributes would be very nice as well.
>
> Wkr,
>    Sven Vermeulen
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
