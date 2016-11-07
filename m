Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA7EoxaJ012798
 for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2016 09:50:59 -0500
Received: by mail-wm0-f46.google.com with SMTP id f82so123354114wmf.1
 for <selinux@tycho.nsa.gov>; Mon, 07 Nov 2016 06:50:58 -0800 (PST)
Received: from pcx.eikon.lan ([151.58.14.242])
 by smtp.googlemail.com with ESMTPSA id wn5sm31391581wjb.42.2016.11.07.06.50.56
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Nov 2016 06:50:56 -0800 (PST)
Subject: Re: Security context of shared libraries
To: selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
 <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
 <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
From: mm19827 <mm19827@gmail.com>
Message-ID: <5abc1601-678f-0d76-e800-789941f5c22b@gmail.com>
Date: Mon, 7 Nov 2016 15:50:47 +0100
MIME-Version: 1.0
In-Reply-To: <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 11/07/2016 03:35 PM, Stephen Smalley wrote:
>
>> Moreover, in order not to compromise the functionality of /bin/bar, I
>> would need to allow bar_t the same access as unconfined_t (at least as a
>> first approximation). The fact is that, although I can trust /bin/bar,
>> it is not selinux-aware.
>
> I wouldn't do that; otherwise any security gains you are getting are
> illusory since bar is equivalent to unconfined.  It isn't that hard to
> define a real confined domain for a program.

I agree that defining a real confined domain for /bin/bar is a better 
approach.
It is not clear to me that any security gains would be illusory: even if 
/bin/bar (from bar_t) has effectively unconfined access, still /bin/foo 
(i.e. foo_t) could only access bar_t, and not unconfined_t.

>
> Generally the simplest approach is to define a stub .te file for your
> domain, include a permissive declaration for it (permissive bar_t;), and
> then derive a policy from the resulting avc:
Thanks for the hint of the stub .te file.
The only issue here is that I would need to find a way to trigger all 
possible avc's from /bin/bar, which is not straightforward.
