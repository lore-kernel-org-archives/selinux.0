Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1QFkQRw021297
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 10:46:26 -0500
Received: by mail-oi0-f50.google.com with SMTP id m82so64248796oif.1
 for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2016 07:46:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456491264.3481.2.camel@redhat.com>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov>
 <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov>
 <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov>
 <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov>
 <1456491264.3481.2.camel@redhat.com>
Date: Fri, 26 Feb 2016 10:46:22 -0500
Message-ID: <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
Subject: Re: Strange AVC with latest rawhide kernel.
From: Paul Moore <paul@paul-moore.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 Paul Moore <pmoore@redhat.com>, mgrepl@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 26, 2016 at 7:54 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On Thu, 2016-02-25 at 15:54 -0500, Stephen Smalley wrote:
>> On 02/25/2016 03:28 PM, Daniel J Walsh wrote:
>> > Currently typebounds only allows one instance.
>> It is a hierarchy, where each child has a single parent.  So you can
>> define hierarchies like:
>> typebounds unconfined_t docker_t;
>> typebounds docker_t svirt_lxc_net_t;
>> and then they can both transition because they are both ancestors.
>
> Awesome idea.

Would that resolve all your problems Dan with Docker, runc, etc.?
>From our discussions the other day I thought you needed the ability to
transition to svirt_lxc_net_t from domains other than unconfined_t and
docker_t ... or was I misunderstanding you?

-- 
paul moore
www.paul-moore.com
