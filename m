Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3B4JmfK015245
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 00:19:48 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3B4JlA9007771
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 04:19:48 GMT
Received: by rv-out-0708.google.com with SMTP id k29so1215112rvb.54
        for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 21:19:46 -0700 (PDT)
Cc: selinux@tycho.nsa.gov
Message-Id: <D16837FA-837E-4318-8025-6D48438A5189@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Robert Mykland <robert@ascenium.com>
In-Reply-To: <49E0134D.3040903@ascenium.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Policies for Devices?
Date: Fri, 10 Apr 2009 21:19:44 -0700
References: <49E0134D.3040903@ascenium.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 10, 2009, at 8:49 PM, Robert Mykland wrote:

> Folks,
>
> Is there a way I can use policies to prevent a specific device, say  
> a USB key, from being written to except by one specific  
> application?  If so, how would I go about writing that?
>
> Thanks in Advance,
>
> -- Robert.
>
> -- 
> Robert Mykland               Voice: (831) 212-0622
> Founder/CTO                   Ascenium Corporation
> "A new world of computing fulfilling people's lives"
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.


from here,
normally any of my usb devices(example thumb drives)
will be denied access, until I relabel, and write the
allow rules for them into the policy.

regards,

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
