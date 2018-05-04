MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1804260502030.12534@namei.org>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
 <alpine.LRH.2.21.1804260443110.11568@namei.org>
 <CAHC9VhR-V1R2BpCt1aA56q4yT_PWv1kzoWtksbNkm08stcOGPw@mail.gmail.com>
 <alpine.LRH.2.21.1804260502030.12534@namei.org>
From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 4 May 2018 16:29:14 +0200
Message-ID: <CANq1E4QgRUvG4WJ_XZoWpvegE-TRF5CddiSptNUFQkURJr5Znw@mail.gmail.com>
To: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul@paul-moore.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Tom Gundersen <teg@jklm.no>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>,
 Eric Paris <eparis@parisplace.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey

On Wed, Apr 25, 2018 at 9:02 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 25 Apr 2018, Paul Moore wrote:
>
>> On Wed, Apr 25, 2018 at 2:44 PM, James Morris <jmorris@namei.org> wrote:
>> > On Mon, 23 Apr 2018, David Herrmann wrote:
>> >> This patch series tries to close this gap and makes both behave the
>> >> same. A new LSM-hook is added which allows LSMs to cache the correct
>> >> peer information on newly created socket-pairs.
>> >
>> > Looks okay to me.
>> >
>> > Once it's respun with the Smack backend and maybe the hook name change,
>> > I'll merge this unless DaveM wants it to go in via his networking tree.
>>
>> Note my objection to the hook placement in patch 2/3; I think we
>> should move the hook out of the AF_UNIX layer and up into the socket
>> layer.
>
> I vote for this as it maintains the intended abstraction of the socket
> API.

Sounds good, I changed it. I will send v2 shortly.

Thanks
David
