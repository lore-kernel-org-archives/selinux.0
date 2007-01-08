Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08Km2sD006297
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:48:02 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l08Kmpc5003477
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 20:48:51 GMT
Message-ID: <45A2AE31.8050800@tresys.com>
Date: Mon, 08 Jan 2007 15:48:49 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] check for handle creation failures in seobject
References: <459E7C60.8070308@mentalrootkit.com> <459E8672.3060708@mentalrootkit.com>
In-Reply-To: <459E8672.3060708@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Karl MacMillan wrote:
>> seobject.py assumes that handle creation always succeeds, though this 
>> is not always the case. This patch checks for that failure.
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>
>
> Another try without line wrapping and with tabs instead of spaces.
>
>
Merged this along with the libsemanage error code propagation and the 
disk reduction patches as of libsemanage 1.9.2 and policycoreutils 1.33.10



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
