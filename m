Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9K1q8vu000749
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 21:52:08 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9K1q7st016065
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 01:52:08 GMT
Received: by pxi15 with SMTP id 15so914459pxi.12
        for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 18:52:07 -0700 (PDT)
Message-ID: <4CBE4B64.2060308@gmail.com>
Date: Tue, 19 Oct 2010 18:52:36 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: load_policy() with upstart on mint 9 fluxbox
References: <4CBE21ED.4050706@gmail.com> <20101020015409.GA19663@hallyn.com>
In-Reply-To: <20101020015409.GA19663@hallyn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2010 06:54 PM, Serge E. Hallyn wrote:
> Quoting Justin P. Mattock (justinmattock@gmail.com):
>> I admit it, I'm a total newb at this upstart thing, anyways
>> I installed all the packages for mint 9 fluxbox, but the policy
>> is not loading during boot
>> what/where might I look to read up on this, so I can get the policy
>> loaded at boot...
>
> iiuc that should happen in initrd, before upstart is running.
>
> man initramfs-tools for some info on how to tweak your initrd.
>
> -serge
>


ahh.. no wonder this is not loading(but could be wrong), i.e. I dont 
have initramfs for the kernel im using, just make, make install..

Thanks for the info on this, I'll look at the man page

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
