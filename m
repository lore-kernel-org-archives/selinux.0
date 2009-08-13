Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7DFcG8G031482
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 11:38:16 -0400
Received: from mail-pz0-f172.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7DFbMOr013256
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 15:39:18 GMT
Received: by pzk2 with SMTP id 2so615807pzk.30
        for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 08:36:17 -0700 (PDT)
Message-ID: <4A843305.5070601@gmail.com>
Date: Thu, 13 Aug 2009 08:36:37 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: error: too many arguments to function 'security_getenforce'
References: <dd18b0c30908122030l3e950054r1f3907a6dcde8db0@mail.gmail.com> <f71a82820908122249k2c4c3397hc941ee3a3a0a75a7@mail.gmail.com>
In-Reply-To: <f71a82820908122249k2c4c3397hc941ee3a3a0a75a7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shintaro Fujiwara wrote:
>   security_getenforce(&seconfig);
>
> is wrong.
>
> see
>
> [fujiwara@notepc ~]$ cat -n /usr/include/selinux/selinux.h|grep
> security_getenforce
>     314	extern int security_getenforce(void);
>
>    
Great,

Can you or somebody help me in  finding
a correct patch to load the policy at boot.

I find it hard to believe that such a security policy
  would be lacking  in this area.

Justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
