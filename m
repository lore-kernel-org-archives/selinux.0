Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1QHDbsC013502
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 12:13:44 -0500
Received: by mail-oi0-f49.google.com with SMTP id j125so66860010oih.0
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 09:13:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56D07421.3090301@tycho.nsa.gov>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov>
 <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov>
 <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov>
 <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov>
 <1456491264.3481.2.camel@redhat.com>
 <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
 <56D07421.3090301@tycho.nsa.gov>
Date: Fri, 26 Feb 2016 12:13:41 -0500
Message-ID: <CAHC9VhS8ufHL5HojNXX1k5qPdCEHn75qdZ5vktCBdNE0=WvpyA@mail.gmail.com>
Subject: Re: Strange AVC with latest rawhide kernel.
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
 Paul Moore <pmoore@redhat.com>, mgrepl@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 26, 2016 at 10:49 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/26/2016 10:46 AM, Paul Moore wrote:
>> On Fri, Feb 26, 2016 at 7:54 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> On Thu, 2016-02-25 at 15:54 -0500, Stephen Smalley wrote:
>>>> On 02/25/2016 03:28 PM, Daniel J Walsh wrote:
>>>>>
>>>>> Currently typebounds only allows one instance.
>>>>
>>>> It is a hierarchy, where each child has a single parent.  So you can
>>>> define hierarchies like:
>>>> typebounds unconfined_t docker_t;
>>>> typebounds docker_t svirt_lxc_net_t;
>>>> and then they can both transition because they are both ancestors.
>>>
>>> Awesome idea.
>>
>> Would that resolve all your problems Dan with Docker, runc, etc.?
>> From our discussions the other day I thought you needed the ability to
>> transition to svirt_lxc_net_t from domains other than unconfined_t and
>> docker_t ... or was I misunderstanding you?
>
> Note that it is only exec-based transitions that are affected by
> NO_NEW_PRIVS, so one can always leverage dynamic transitions (i.e. setcon)
> without requiring typebounds.

Sure, but I really dislike recommending the use of setcon().

-- 
paul moore
www.paul-moore.com
