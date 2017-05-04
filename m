Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44FpbWV030179
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 11:51:52 -0400
Received: by mail-lf0-f47.google.com with SMTP id j1so10543436lfh.2
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 08:50:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170503165137.GA15940@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 May 2017 11:50:15 -0400
Message-ID: <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
Subject: Re: Policy capabilities: when to use and complications with using
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
>> Part of the reason that we tend to not introduce a new policy
>> capability more often is that it is painful to do so currently.  We
>> have to patch libsepol to recognize the new capability and patch the
>> policy to declare it (although for the latter we can now declare them
>> via a CIL module without modifying the base policy).  And since the
>> policy or module won't build without the updated libsepol, we can't
>> turn on the capability by default in refpolicy without making it
>> dependent on a new libsepol version.  That's why extended_socket_class
>> isn't yet enabled in refpolicy, for example.  That causes enablement
>> and adoption to lag behind.  It also makes it harder to test the new
>> kernel feature in the first place.
>
> I would like to see Fedora package the RC's in Rawhide as well (other distributions could help by packaging the RC's in unstable as well). That would atleast make the RC's a bit more accessible.
> In Fedora it is usually not the kernel that is the problem, it is user space that is generally to old. And as you've said policy is no longer a problem with CIL.

[NOTE: I'm still thinking about the rest of Stephen's email, and the
follow up comments, but I wanted to reply to this particular comment
separately.]

I'm not sure I want to see SELinux userspace release candidates in
normal Rawhide, but I think creating a COPR repository to
build/distribute release candidates could be a good thing.  We already
do something similar for the kernel patches and it has been helpful in
my opinion.

https://copr.fedorainfracloud.org
https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext

-- 
paul moore
www.paul-moore.com
