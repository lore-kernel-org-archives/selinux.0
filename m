Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2AKSUOu005544
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 15:28:30 -0500
Received: by mail-ua0-f196.google.com with SMTP id y16so15600627uay.3
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 12:28:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSeVXyT84DNrXSkFKoNSnzWFVn6zOi5Gpt-mr6-BTBVRQ@mail.gmail.com>
References: <20170306184614.20056-1-glider@google.com>
 <20170308.231208.1651420232093147373.davem@davemloft.net>
 <CAHC9VhSeVXyT84DNrXSkFKoNSnzWFVn6zOi5Gpt-mr6-BTBVRQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Mar 2017 15:28:27 -0500
Message-ID: <CAHC9VhSf72zUZpcDUYU01B9w789ydbsj5ZYoByyySpZamk=Bng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: check for address length in
 selinux_socket_bind()
To: glider@google.com
Cc: David Miller <davem@davemloft.net>, Stephen Smalley <sds@tycho.nsa.gov>,
 dvyukov@google.com, kcc@google.com, keescook@chromium.org,
 edumazet@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 10, 2017 at 7:01 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 9, 2017 at 2:12 AM, David Miller <davem@davemloft.net> wrote:
>> From: Alexander Potapenko <glider@google.com>
>> Date: Mon,  6 Mar 2017 19:46:14 +0100
>>
>>> KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
>>> uninitialized memory in selinux_socket_bind():
>>  ...
>>> (the line numbers are relative to 4.8-rc6, but the bug persists upstream)
>>>
>>> , when I run the following program as root:
>>  ...
>>> (for different values of |size| other error reports are printed).
>>>
>>> This happens because bind() unconditionally copies |size| bytes of
>>> |addr| to the kernel, leaving the rest uninitialized. Then
>>> security_socket_bind() reads the IP address bytes, including the
>>> uninitialized ones, to determine the port, or e.g. pass them further to
>>> sel_netnode_find(), which uses them to calculate a hash.
>>>
>>> Signed-off-by: Alexander Potapenko <glider@google.com>
>>
>> Are the SELINUX folks going to pick this up or should I?
>
> Yes, it's on my list of things to merge, I was just a bit distracted
> this week with yet another audit problem.  I'm going to start making
> my way through the patch backlog today.

Just merged into selinux/next, thanks.  My apologies for the delay.

-- 
paul moore
www.paul-moore.com
