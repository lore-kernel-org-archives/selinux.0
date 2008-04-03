Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33MlCVR030460
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 18:47:12 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m33Ml6lA004771
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 22:47:11 GMT
Message-ID: <47F54D78.6010700@manicmethod.com>
Date: Thu, 03 Apr 2008 17:34:48 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Removing 2 modules that depend on eachother
References: <4AE25A7D8CBE4E4DA8E87173237DE27E8B94@blums0042.bluelnk.net>
In-Reply-To: <4AE25A7D8CBE4E4DA8E87173237DE27E8B94@blums0042.bluelnk.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karrels, Jeffrey J (US SSA) wrote:
>
> Hello all.
>
> I have a question. I have two modules that I created that I wanted to 
> remove (both). Each module depends on the other. What is the best way 
> to go about this? (for now, I have removed one of my dependencies and 
> then was able to remove the modules one at a time). Is there a better 
> way to go about this though? I tried calling semodule –r in various 
> forms to try and remove two packages at the same time, but did not 
> have any luck. Any suggestions?
>
> Thanks
>
> Jeff
>

you can do multiple -r's on one line:

semodule -r module1 -r module2 -r module3

and so on.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
