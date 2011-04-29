Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3TJ9vkT024352
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 15:09:59 -0400
Received: from fep05-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3TJ9vlU005478
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 19:09:57 GMT
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
From: Guido Trentalancia <guido@trentalancia.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 29 Apr 2011 21:09:44 +0200
In-Reply-To: <4DBADD4C.9040507@schaufler-ca.com>
References: <201104291139.37489.roberto.sassu@polito.it>
	 <4DBADD4C.9040507@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304104194.2629.5.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-04-29 at 08:46 -0700, Casey Schaufler wrote:
> On 4/29/2011 2:39 AM, Roberto Sassu wrote:
[cut]

> >> Excuse my ignorance for a moment. Is eCryptfs a user mode filesystem,
> >> or in the kernel properly? The behavior makes it sound like the former
> >> while the interfaces you're requesting make it seem like the latter.
> 
> I'll repeat the question because it matters.

I am not an expert but since it's already the second time that you ask,
I have done a little of research and it seems that it's implemented in
the kernel and then it has userspace tools for management. So it
shouldn't be any different than other filesystems such as "extended
filesystems" (2,3,4)...

Regards,

Guido

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
