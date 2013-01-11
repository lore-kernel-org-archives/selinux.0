Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0BIED2u031025
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2013 13:14:15 -0500
Message-ID: <50F05656.5060301@schaufler-ca.com>
Date: Fri, 11 Jan 2013 10:13:42 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com> <20130108140159.83c07fa6a680e355f024970f@canb.auug.org.au> <50EB9A5E.1080306@schaufler-ca.com> <alpine.LRH.2.02.1301081942030.24212@tundra.namei.org> <50EC8447.1000301@canonical.com> <alpine.LRH.2.02.1301100028160.5423@tundra.namei.org> <50EE9733.2060409@canonical.com> <87lic0sg09.fsf@xmission.com>
In-Reply-To: <87lic0sg09.fsf@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/10/2013 4:46 PM, Eric W. Biederman wrote:
> John Johansen <john.johansen@canonical.com> writes:
>
>> On 01/09/2013 05:28 AM, James Morris wrote:
>>> On Tue, 8 Jan 2013, John Johansen wrote:
>>>
>>>>> I'd say we need to see the actual use-case for Smack and Apparmor being 
>>>>> used together, along with at least one major distro committing to support 
>>>>> this.
>>>>>
>>>>>
>>>> Ubuntu is very interested in stacking
>>> Which modules?
>>>
>> Well Yama which has now been special cased, and in the past there has been
>> discussion about other special case LSMs like case is proposing for module
>> loading. There has been interest around both selinux + apparmor and
>> smack + apparmor. I am not sure of all of the use cases that have lead to
>> such question but some of them have been around containers, with say
>> selinux on the host and apparmor in the container, or visa versa.
> When a distro is run in a container it is desirable to be able to run
> the distro's security policy in that container.  Ideally this will get
> addressed by being able to do some level of per user namespace stacking.
> Say selinux outside and apparmor inside a container.
>
> I think this would take a little more work than what Casey has currently
> devised but I am hopeful an additional layer of stacking can be added
> after Casey has merged the basic layer of stacking.

Would that be per-container LSM lists? I hadn't thought about
doing that, and don't know how you might implement it, but I
suppose it could work.

>
> Eric
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
