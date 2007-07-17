Message-ID: <469CC20D.2030202@manicmethod.com>
Date: Tue, 17 Jul 2007 09:20:13 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        zohar@us.ibm.com, safford@watson.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
References: <1184594240.5860.5.camel@localhost.localdomain> <Line.LNX.4.64.0707162015490.14773@d.namei>
In-Reply-To: <Line.LNX.4.64.0707162015490.14773@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Mon, 16 Jul 2007, Mimi Zohar wrote:
>
>   
>> +#define FILE__MEASURE                             0x00100000UL
>>     
>
> Just a logistical note, we need Eric's patch to handle undefined 
> permissions, so we don't break userspace with changes such as this.
>   

I don't think this will break anything. A denial (from the policy not 
having this perm) should result in no measurement. It won't stop 
operations like other permission denials will.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
