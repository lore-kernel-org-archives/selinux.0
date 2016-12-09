Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9NxY8J031266
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 18:59:34 -0500
Received: by mail-vk0-f65.google.com with SMTP id p9so1680003vkd.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Dec 2016 15:59:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <74769e16-55c8-2de0-233a-fb01ad1007f6@tycho.nsa.gov>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <d6892b99-64b8-838e-f024-aeacb35df6e1@tycho.nsa.gov>
 <CAHC9VhSh3v_u1hKvZAt0sdGm-PykApdu1j21Q56K036R7oN=Og@mail.gmail.com>
 <5c66b64e-19f1-3fe3-5efe-13083151f9bd@tycho.nsa.gov>
 <CAHC9VhReQ0-Yb+r=uL5UmWUj_1VmTGVFVASfGghf1TgF9sYEvw@mail.gmail.com>
 <1481033405.16934.1.camel@btinternet.com>
 <348a4f35-056b-9651-2e1d-162f5b6a5099@tycho.nsa.gov>
 <74769e16-55c8-2de0-233a-fb01ad1007f6@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Dec 2016 18:59:32 -0500
Message-ID: <CAHC9VhQVu7phGq39QpniKVLiOeb4S2t1V0uyRmg8VEA+vrxhOQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 9, 2016 at 8:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/06/2016 10:04 AM, Stephen Smalley wrote:
>> On 12/06/2016 09:10 AM, Richard Haines wrote:
>>> Not sure if helpful but I plan to submit the SCTP patch next week after
>>> testing on Fedora 25 with kernel 4.8.11.
>>
>> I chose to go ahead and add the SCTP socket security class to this patch
>> so that we have all known socket classes defined by this patch, and then
>> your patch can further add new permissions and other logic specific to
>> SCTP under its own policy capability (at least I assume we'll want a
>> policy capability unless we aren't overly concerned with breaking SCTP
>> applications running under old policies with new kernels).
>
> Actually, perhaps we don't need another separate policy capability for
> it if it goes in soon, since the extended_socket_class capability isn't
> yet enabled in any policies.

True, we don't make any guarantees regarding code that hasn't been
released via Linus' tree and right now the extended socket class patch
is just sitting in the SELinux tree.  That said, I don't consider it
major problem to introduce another policy capability if needed; it's
definitely cleaner not to have to do so, but I wouldn't consider it
reason to rush the SCTP support if it isn't ready.

-- 
paul moore
www.paul-moore.com
