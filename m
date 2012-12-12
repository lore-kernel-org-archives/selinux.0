Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCHMoA2024820
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 12:22:50 -0500
Received: by mail-ea0-f181.google.com with SMTP id k14so354119eaa.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 09:22:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLf+apZK5poD6GKzLkC+p6+mAqKhU3neoOZjr2JumvmpA@mail.gmail.com>
References: <50C65DE2.5090909@schaufler-ca.com>
	<201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
	<50C751D3.60409@schaufler-ca.com>
	<201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
	<50C8A757.3050907@schaufler-ca.com>
	<1355327754.3527.37.camel@localhost>
	<50C8AFD1.1070905@schaufler-ca.com>
	<1355330026.3527.44.camel@localhost>
	<50C8B919.2060102@schaufler-ca.com>
	<1355332292.3527.48.camel@localhost>
	<CAGXu5jLf+apZK5poD6GKzLkC+p6+mAqKhU3neoOZjr2JumvmpA@mail.gmail.com>
Date: Wed, 12 Dec 2012 12:22:17 -0500
Message-ID: <CACLa4pvtgjzPP50J-NA0w+g3CmNvFA+3DqH3X9B_E29jfWHf3g@mail.gmail.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Paris <eparis@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/proc/filesystems to look for selinuxfs

then /proc/mounts to find selinuxfs assuming it isn't at
/sys/fs/selinux or /selinux

I'd guess it is ssh failing closed, not the library, but in either
case, it's the right thing to do in enforcing and could probably be
considered a bug in permissive...

On Wed, Dec 12, 2012 at 12:16 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Dec 12, 2012 at 9:11 AM, Eric Paris <eparis@redhat.com> wrote:
>> On Wed, 2012-12-12 at 09:04 -0800, Casey Schaufler wrote:
>>> On 12/12/2012 8:33 AM, Eric Paris wrote:
>>
>>> Yes, thank you.
>>>
>>> I'm headed in what I hope is a simpler direction. I have added
>>> two files into securityfs:
>>>
>>>       /sys/kernel/security/lsm     - a comma separated list of LSMs
>>>       /sys/kernel/security/present - the presented LSM
>>>
>>> I have also added LSM identified files in /proc/.../attr:
>>>
>>>       /proc/.../attr/current
>>>       /proc/.../attr/selinux.current
>>>       /proc/.../attr/apparmor.current
>>>       /proc/.../attr/keycreate
>>>       /proc/.../attr/selinux.keycreate
>>>
>>> SELinux applications and libraries can use simple logic to determine
>>> what to do:
>>>
>>>       if /sys/kernel/security/lsm does not contain "selinux"
>>>               Stop! No SELinux here!
>>>       if /sys/kernel/security/present does not contain "selinux"
>>>               Use selinux.current
>>>       else
>>>               Use current if you like.
>>
>> So if I use legacy tools for SELinux and Apparmor with a stacking
>> kernel, they will both load policy and get things started.  How would a
>> legacy userspace know not to load it?  But then they will both
>> use /proc/self/attr/current even though only one of them owns it.  So we
>> get this half and half where one of them is enforcing a policy, but it
>> can't actually really work...  Maybe we just don't care.  I'm ok with
>> that answer.  If you don't update userspace, don't build your kernel
>> that way   :)
>
> That's my way of looking at it -- using more than one LSM that uses
> attr/current with old userspace lands you in a very confusing place.
> E.g. with the current patch, if SELinux is stacked but not presented,
> all the SELinux libraries fail closed and I can't SSH in. :)
>
> I haven't checked to see how the libraries are deciding that SELinux
> is built-in (/sys/modules? securityfs?) It feels like trying to use
> this kernel feature without userspace support should be considered a
> 'bad idea'. :) Building a kernel without stacked (conflicting) LSMs,
> everything continues to work fine.
>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
