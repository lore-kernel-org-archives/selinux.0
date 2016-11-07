Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA7FBXjY015263
 for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2016 10:11:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id u144so29136678wmu.1
 for <selinux@tycho.nsa.gov>; Mon, 07 Nov 2016 07:11:31 -0800 (PST)
Received: from pcx.eikon.lan ([151.58.14.242])
 by smtp.googlemail.com with ESMTPSA id
 w203sm14017214wmw.16.2016.11.07.07.11.29 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Nov 2016 07:11:29 -0800 (PST)
Subject: Re: Security context of shared libraries
To: selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
 <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
 <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
 <5abc1601-678f-0d76-e800-789941f5c22b@gmail.com>
 <d20db309-43e4-adcf-04e2-407290d52b93@tycho.nsa.gov>
From: mm19827 <mm19827@gmail.com>
Message-ID: <85fa6e4c-9c24-1371-d5a8-332d18015818@gmail.com>
Date: Mon, 7 Nov 2016 16:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <d20db309-43e4-adcf-04e2-407290d52b93@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 11/07/2016 04:01 PM, Stephen Smalley wrote:
>
> I suppose that's true, depending on what it is that you have to allow
> between foo_t and bar_t, e.g. you can allow foo_t to connect to a bar_t
> socket or similar without allowing it to connect to unconfined_t
> sockets.
Exactly.

  If you truly want bar_t to be unconfined, you can always just
> have it call the unconfined_domain() interface in refpolicy, e.g.
> unconfined_domain(bar_t), and it will inherit all of the unconfined
> domain rules.
>
Thanks for the info.
It would be great (and this would be my last question), if you could 
give a pointer to a complete documentation of refpolicy macros and 
interfaces - I could find the kernel rules, and that it makes use of m4 
macros, but not a complete documentation.

>
> Yes, it is better if you have some idea of the expected functionality of
> bar, whether from source code, static analysis of the binary, strace, or
> documentation, and can then define up front policy that corresponds.
>
I have some idea of the functionality, but I do not have access to all 
details of the code. It is a closed source commercial product.
I think I'll ask the supplier for more info (and eventually to support 
selinux themselves)
Thanks a lot for your info.

M. Manfredini
