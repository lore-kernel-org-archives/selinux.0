Message-ID: <3C1E2031.4030106@pcez.com>
Date: Mon, 17 Dec 2001 08:41:21 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: iptables.te  errors
References: <Pine.GSO.4.33.0112170754050.10438-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>
>>I have a iptables.te with some documentation.
>>
>
>Thanks for contributing.  However, I was wondering if the additional
>permissions that you've defined should be merged back into the ipchains_t
>domain, and that domain could be used for both programs.  Is there any
>real reason to maintain separate domains for the two programs?
>
>
I wanted try a simple example of a new policy.  I wanted to try to find 
all the hooks in other te's that needed to be added.
It was a learning process, and I hope to help selinux.

I have a K-12 school district that wants a secure base platform.  I hope 
to create a educational=RH+selinux-(most).

Shaun savage



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
