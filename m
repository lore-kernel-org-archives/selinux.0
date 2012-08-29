Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7T3fnJx009675
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2012 23:41:49 -0400
Message-ID: <503D8F58.3010207@itechfrontiers.com>
Date: Tue, 28 Aug 2012 23:41:12 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Raul da Silva {Sp4wn} <sp4wn.root@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: proof selinux
References: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
In-Reply-To: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Raul,

I'm not sure if we are on the same page about SELinux.

SELinux is not there to prevent from buffer overflow or such exploits,

If you run a process in some kind of Role or Context, you confine it to 
the limitations you defined in that context (using SELinux Policies),

How effective SELinux would be, depends on your policies actually.

The effectiveness of SELinux has nothing to do with exploits, unless of 
course you meant attacking SELinux code or kernel LSM or Kernel itself.


Testing SELinux is easy, simply assign whatever role or policy you want 
to a process and user or group,  the ultimate exploit of a process gives 
total control of that role or policy to that user. So the attackers 
become as privileged as the role or user or context of the policy.


Sincerely,

Patrick K.

On 8/28/2012 10:50 PM, Raul da Silva {Sp4wn} wrote:
> hi guys,
>
> I know that we have a lot of ways to prove how effective is SELinux as
> cgi, perl, shell scripts and I know that is effective but I'd like to
> know if someone already tested some kind of exploit of buffer overflow
> attack as demo to show how effective could be SELinux.
> Any information I really appreciate
>
> Thanks
>
>
>
> Raul Leite
> sp4wn.root@gmail.com <mailto:sp4wn.root@gmail.com>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
