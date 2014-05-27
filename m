Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4R7jPbC021025
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 03:45:25 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so8835485pbb.34
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 00:45:25 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.19.217])
 by mx.google.com with ESMTPSA id yl9sm69583265pac.25.2014.05.27.00.45.23
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 27 May 2014 00:45:24 -0700 (PDT)
Message-ID: <538441F4.3010104@gmail.com>
Date: Tue, 27 May 2014 13:12:44 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: user_t more restrictive than sshd_t (e.g.)?
References: <537EE13B.7090603@gmail.com>
In-Reply-To: <537EE13B.7090603@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/23/14 11:18, dE wrote:
> As we know, the user_r does not allow many processes to have high 
> privilege types (system_t for e.g. which's tailored for a single 
> program named X), if such a process is executed, it'll have a type of 
> user_t.
>
> However system_t specifies restrictions on the program exactly as per 
> X's specifications -- it wont allow the program to do anything outside 
> what's it supposed to do.
>
> But that's not the same for user_t -- this type is generic and there 
> are many things that user_t allows which system_t does not.
>
> This may form a security vector; a vulnerable program which should run 
> as system_t but is not run cause user_r does not allow that type, this 
> allows the program to do many things which it's not designed to do; so 
> basically this bypasses SELinux restrictions as put on by system_t.
>
> So, is there any way to prevent this form happening -- or can we 
> specify in the policy what type to run the program as when it's run by 
> a user with role user_r or any other user which is not allowed system_t?
>
> As an e.g. we may see systemctl.

Is this concern real?
