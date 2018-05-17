Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4HFITS2020604
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 11:18:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40mvzC3d2Rz2Vp9M
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 15:16:39 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40mvzB2wnLz2Vp9L
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 15:16:38 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id 16-v6so9299560lfs.13
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 08:16:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <78525914-8d00-38e3-d4d9-1fc8102a9edc@tycho.nsa.gov>
References: <152641822270.15123.8804483748550258349.stgit@chester>
 <20180516073101.GC17168@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <78525914-8d00-38e3-d4d9-1fc8102a9edc@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 May 2018 11:15:34 -0400
Message-ID: <CAHC9VhTLJwaqKHC_M0JceuJBCg5KL9rkmXbrvisqC7K3Y=Jugw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Petr Lautrbach <plautrba@redhat.com>
Cc: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Re: [RFC PATCH] selinux-testsuite: check the
 "expand-check" setting in semanage.conf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 16, 2018 at 8:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/16/2018 03:31 AM, Petr Lautrbach wrote:
>> On Tue, May 15, 2018 at 05:03:42PM -0400, Paul Moore wrote:
>>> From: Paul Moore <paul@paul-moore.com>
>>>
>>> If expand-check is non-zero in semanage.conf the policy load will likely fail,
>>> try to provide a more helpful error to users running the tests.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  policy/Makefile |   12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/policy/Makefile b/policy/Makefile
>>> index 8ed5e46..cc022e3 100644
>>> --- a/policy/Makefile
>>> +++ b/policy/Makefile
>>> @@ -87,6 +87,14 @@ build: $(BUILD_TARGET)
>>>  load: $(LOAD_TARGET)
>>>  unload: $(UNLOAD_TARGET)
>>>
>>> +expand_check:
>>> +    # Test for "expand-check = 0" in /etc/selinux/semanage.conf
>>> +    @cat /etc/selinux/semanage.conf | \
>>> +            sed -n 's/^[ \t]*expand-check[ \t]*=[ \t]*0/OK/p' | \
>>> +            grep -q "OK" || \
>>> +            (echo "ERROR: set 'expand-check = 0' in semanage.conf"; \
>>> +             /bin/false)
>>> +
>>
>> You can use grep directly:

Yes, you're correct.  I have an old habit of using sed for regex
processing as I used to work on a lot of systems where grep didn't
handle regular expressions.

Fixed.

> And you should probably put the full path for the file in the error message.

I figured that comment above (it is displayed when running 'make
test') was enough, but adding the full path couldn't hurt.

Fixed, and pushed to selinux-testsuite/master.  Thanks to both of you
for the quick review.

-- 
paul moore
www.paul-moore.com
