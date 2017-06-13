Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5DKHQq9003431
 for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2017 16:17:26 -0400
Received: by mail-lf0-f53.google.com with SMTP id o83so79289549lff.3
 for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2017 13:17:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497364983.26654.1.camel@tycho.nsa.gov>
References: <7f094e66-6131-f126-9e23-771d1520904f@debian.org>
 <1497364983.26654.1.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jun 2017 16:17:21 -0400
Message-ID: <CAHC9VhQ5keRfB66MM7sm0Fihr1p4OtY9D0TCGTT=k5uYeuhNsA@mail.gmail.com>
Subject: Re: SO_PEERSEC on socket connected to the same process
To: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 13, 2017 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-06-13 at 09:37 +0200, Laurent Bigonville wrote:
>> Hi,
>>
>> Currently the dbus-daemon is not returning anything when asked about
>> its
>> own security context (using GetConnectionSELinuxSecurityContext or
>> GetConnectionCredentials methods). This cause some issues[0] with
>> systemd now that it's enforcing the policy for user sessions again.
>>
>> I already made a patch that has been merged[1][2] upstream in the
>> GetConnectionSELinuxSecurityContext case and it now returns the
>> SELinux
>> context of the dbus-daemon process itself.
>>
>> For the GetConnectionCredentials case, upstream wanted a generic way
>> of
>> getting the security label and went the way of using SO_PEERSEC on a
>> socket connected to itself.
>>
>> But for some reasons it's always returning unlabeled_t. Note that
>> the
>> same value is returned by the getpeercon() function as well.
>>
>> I've made a small test case (see attached file) and tested it on
>> both
>> debian and RHEL7.
>>
>> Is this somehow expected? Is this a bug?
>>
>> Cheers,
>>
>> Laurent Bigonville
>>
>> [0]https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=864221
>> [1]https://bugs.freedesktop.org/show_bug.cgi?id=101315
>> [2] https://phabricator.freedesktop.org/rDBUSdcf02f80656d
>
> SO_PEERSEC has never been supported for socketpair()-created sockets.
> To do so would require a new LSM hook called by unix_socketpair() to
> set the peer SIDs for the two sockets.  In the absence of such a hook,
> the peer SIDs are left with their initial values (the unlabeled SID),
> and thus SO_PEERSEC returns the unlabeled context for both.  That's why
> you see the current behavior.
>
> It would be easy enough to implement such a hook (and perhaps we
> should), but the more fundamental question is whether SO_PEERSEC makes
> sense for socketpair()-created sockets and what does it actually mean.

Just to weigh in on this issue, the meaning is exactly as Stephen said
at the end of his email: "SO_PEERSEC returns the context of the peer
socket".  Based on my understanding of how socketpair() is typically
used this would be confusing for the majority of applications,
sticking with the current (unlabeled peer) behavior seems the best
option.

-- 
paul moore
www.paul-moore.com
