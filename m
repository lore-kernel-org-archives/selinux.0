Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4UD6XU7005134
 for <selinux@tycho.nsa.gov>; Sat, 30 May 2015 09:06:33 -0400
Received: by obew15 with SMTP id w15so75905020obe.1
 for <selinux@tycho.nsa.gov>; Sat, 30 May 2015 06:06:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150529213830.GA23540@x131e>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhRs+qZgKsU7t+bnBQUf+A6=wYev-KP1hoViOvLDZcaf+Q@mail.gmail.com>
 <20150529213830.GA23540@x131e>
Date: Sat, 30 May 2015 09:06:30 -0400
Message-ID: <CAHC9VhS54vB4NP8TJ3ayTwMZ_-L5cNaKTgA-4zQyytx+yCbvUQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 29, 2015 at 5:38 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Fri, May 29, 2015 at 05:14:53PM -0400, Paul Moore wrote:
>> On Wed, May 27, 2015 at 11:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > Remove unused permission definitions from SELinux.
>> > Many of these were only ever used in pre-mainline
>> > versions of SELinux, prior to Linux 2.6.0.  Some of them
>> > were used in the legacy network or compat_net=1 checks
>> > that were disabled by default in Linux 2.6.18 and
>> > fully removed in Linux 2.6.30.
>> >
>> > Permissions never used in mainline Linux:
>> > file swapon
>> > filesystem transition
>> > tcp_socket { connectto newconn acceptfrom }
>> > node enforce_dest
>> > unix_stream_socket { newconn acceptfrom }
>> >
>> > Legacy network checks, removed in 2.6.30:
>> > socket { recv_msg send_msg }
>> > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
>> > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
>> >
>> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  security/selinux/include/classmap.h | 22 ++++++++--------------
>> >  1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> Seems very reasonable to me.  Chris, any objections from a policy point of view?
>
> I do not mean to reply on Chris' behalf but in light of what he said earlier:
>
> "The short answer is that I'd prefer to remove policy known to be unusable."
>
> I just want to mention that i like the idea of losing some dead weight where it makes sense as well.

Me too.  I doubt Chris will have a problem with it, but there is no
particular rush with this patch so I figured I would check with him
first just to make sure.

-- 
paul moore
www.paul-moore.com
