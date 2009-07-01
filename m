Message-ID: <4A4B133C.4030005@gmail.com>
Date: Wed, 01 Jul 2009 00:41:48 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: RBAC with SELinux MCS
References: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>	 <4A4AFBC5.2010905@gmail.com>	 <7b740b700906302318v31f292e1ha98ff6735eb1e3a2@mail.gmail.com>	 <4A4B04DA.6000706@gmail.com> <7b740b700906302344rbeaf99yd48cdec3d9cc4939@mail.gmail.com>
In-Reply-To: <7b740b700906302344rbeaf99yd48cdec3d9cc4939@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shaz wrote:
>
>
> On Wed, Jul 1, 2009 at 12:40 PM, Justin P. Mattock 
> <justinmattock@gmail.com <mailto:justinmattock@gmail.com>> wrote:
>
>     Shaz wrote:
>
>
>
>         On Wed, Jul 1, 2009 at 12:01 PM, Justin P. Mattock
>         <justinmattock@gmail.com <mailto:justinmattock@gmail.com>
>         <mailto:justinmattock@gmail.com
>         <mailto:justinmattock@gmail.com>>> wrote:
>
>            Shaz wrote:
>
>                Dear list,
>
>                I was studying some earlier work on RBAC and came across
>                Kuhn98 [1], which says that RBAC can be implemented if some
>                interface function is used to map privilege sets of
>         RBAC with
>                MCS. James Moris blog article on MCS [2] states that MCS is
>                just dicretionary like DAC if hierarchies like of MLS
>         levels
>                are not used. It might be because of the implementation of
>                current LSPP on Linux distros. So my question is that
>         can RBAC
>                be used with SELinux if the mapping function is provided?
>
>                Some further literature or existing work being pointed out
>                will be appreciated.
>
>                Thank you.
>
>                [1]
>         http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
>                [2] http://james-morris.livejournal.com/5583.html
>
>                --        Shaz
>
>            Im guessing the mapping function is "newrole" right!
>            if then yeah you should be able too i.g.
>            newrole -r  *_r -- -c /usr/bin/* (or wherever/whatever your
>            wanting to use in that role).
>            might get complicated with the sensitivity
>            levels and categories(that is if you really tweak them).
>
>
>         Is this consistent with NIST RBAC standard to a greater
>         extent? Never use roles in SELinux because thought it was just
>         grouping of users.
>
>
>
>            Justin P. Mattock
>
>
>
>
>         -- 
>         Shaz
>
>     It should be of standard to NIST(if not then they should fix that)
>     I don't see it as grouping users(but could be wrong),
>     I see it as a way of confining the situation i.g.
>     if  you run an application in certain role, it's confined to
>     that role and only the privileges that role provides.
>
>
> Those privileges depend on the kind of object defined by the "class" 
> and enforced by the object manager. I think its making sense to my 
> stupid mind now :) I will appreciate if someone can clear out if this 
> is consistent with the NIST standards.
>
That's fine
I'll add a CC to someone who has better knowledge than I with SELinux,

> Thanks Justin.
>
>
>
>     Justin P. Mattock
>
>
>
>
>
>
> -- 
> Shaz
>
Stephen if you can, and have the time could you help this person out 
with this question:
Is this consistent with NIST RBAC standard to a greater extent? Never 
use roles in SELinux because thought it was just grouping of users.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
