Message-ID: <4E3B5593.7000502@redhat.com>
Date: Thu, 04 Aug 2011 22:29:39 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: qingtao.cao@windriver.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
        refpolicy@oss1.tresys.com
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com> <4E3B441A.1090900@windriver.com>
In-Reply-To: <4E3B441A.1090900@windriver.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/04/2011 09:15 PM, Harry Ciao wrote:
> Hi Chris,
> 
> I think Dan's case below is a good example, that while
> libsepol/checkpolicy/etc upgraded to 2011-07-27 release, people may have
> not upgraded(or don't want/need to for the time being) the refpolicy to
> the 2011-07-26 release accordingly, then people would run into this problem.
> 
> I am wondering if there is a need to add one note in selinux project
> wiki page that once upgraded to 2011-07-27 release, at least the
> 3cbc9727 commit should be cherry-picked to refpolicy, if people still
> prefer to older releases.

I don't think we can/should do this.  New userspace should be able to
handle old policy.  You understand this code better than anyone, can you
find a solution such that old modules will still compile and work?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
