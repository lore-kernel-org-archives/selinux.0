Message-ID: <4BD92ECA.6080201@gmail.com>
Date: Thu, 29 Apr 2010 00:01:30 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sds@tycho.nsa.gov
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <4BD92AA3.8020709@gmail.com>
In-Reply-To: <4BD92AA3.8020709@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/28/2010 11:43 PM, Justin P. Mattock wrote:
> o.k. Stephen,
>
> bug entry:
> https://bugzilla.novell.com/show_bug.cgi?id=582399
>
> you were right with some init
> file not having #! /bin/bash
> on the top of the head.
> after looking around and gutting
> /etc/init.d I found
> that the files:
> /etc/rc.status and rc.splash
> has no such entry, so after adding
> this entry and rebooting
> I can get a clean bootup and policy load
> without the need for init_upstart=1
>
> cheers..
>
>
> Justin P. Mattock


my bad.. too tired over here
the main culprit is /etc/initscript

renaming to something else
gets me a clean bootup.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
