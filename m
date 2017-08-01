Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v71MeBku014632
 for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2017 18:40:11 -0400
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20170731141246.13547-1-sds@tycho.nsa.gov>
 <CAHC9VhRfXO9UuobvG4ckxNtg9xN0FPSUStKmCMkpHJPS-zsLzw@mail.gmail.com>
Cc: luto@kernel.org, selinux@tycho.nsa.gov
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <c4588852-2aa5-9d4e-2a9d-34ee1d3e254f@ieee.org>
Date: Tue, 1 Aug 2017 18:39:50 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRfXO9UuobvG4ckxNtg9xN0FPSUStKmCMkpHJPS-zsLzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v4] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/31/2017 06:43 PM, Paul Moore wrote:
> On Mon, Jul 31, 2017 at 10:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> As systemd ramps up enabling NNP (NoNewPrivileges) for system services,
>> it is increasingly breaking SELinux domain transitions for those services
>> and their descendants ...
>
> ...
>
>> v4 moves both of the new permissions to the new process2 class and
>> checks both if both NNP is enabled and the mount is nosuid.
>
> This looks good to me, but I'm going to give it another day or two in
> case the the policy folks want to comment.

Looks good to me too.

-- 
Chris PeBenito
