Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9NuoR2030372
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 18:56:50 -0500
Received: by mail-ua0-f195.google.com with SMTP id b35so3309615uaa.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Dec 2016 15:56:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <71adc3b1-e882-532c-de2a-7b9b7974d2ca@tycho.nsa.gov>
References: <1481036419-30057-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQgD_oYn2zCzJCvUzzD_zJYKiQVbG_YMfoPpjphJzTOHA@mail.gmail.com>
 <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
 <CAHC9VhT6E9vLebvBcTX7XtPkP6eGNM-7rxkKAydsDrUwO2Sj5Q@mail.gmail.com>
 <f0075276-99eb-5aba-c009-7c760581be14@tycho.nsa.gov>
 <CAHC9VhSEe_aXLob3oWtWDnijM5Ag8wNNA3_WLoU=7surmSXU7A@mail.gmail.com>
 <71adc3b1-e882-532c-de2a-7b9b7974d2ca@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Dec 2016 18:56:48 -0500
Message-ID: <CAHC9VhQoCxy5t6xg5o3A_a=vK1p=gar588SzGB5k5naV+xVeRg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support distinctions among all network
 address families
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 8, 2016 at 2:42 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Wanted to clarify one point and also mention a bug/deficiency of this
> patch that I just realized:
>
> - Clarification: At present, the patch will map PF_INET, SOCK_DGRAM,
> IPPROTO_ICMP to icmp_socket, but will continue to map PF_INET, SOCK_RAW,
> IPPROTO_ICMP to rawip_socket.  That's intentional, since the SOCK_DGRAM
> IPPROTO_ICMP sockets were introduced to provide a more restricted form
> of ICMP sockets that could be exposed to unprivileged users (based on a
> sysctl), so distinguishing those in policy makes sense.  But it could be
> surprising.

Yes, I have no problem with this behavior.

> - Bug/deficiency:  I hadn't noticed that there is a separate
> IPPROTO_ICMPV6, so I'll need to modify this patch or post a follow-on
> that ensure that we map SOCK_DGRAM,IPPROTO_ICMPV6 to icmp_socket too.

Merged your follow-up patch.

-- 
paul moore
www.paul-moore.com
