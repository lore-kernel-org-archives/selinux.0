Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8EB0Un4011966
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 07:00:30 -0400
Received: from goalkeeper.city-fan.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8EAxn5H001930
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 10:59:49 GMT
Message-ID: <4AAE224A.9060506@city-fan.org>
Date: Mon, 14 Sep 2009 12:00:26 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: briaeros007 <briaeros007@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: how to always add rules to a policy
References: <61bf8f4f0909140140x7eca781xd4df3a114fe5c430@mail.gmail.com>
In-Reply-To: <61bf8f4f0909140140x7eca781xd4df3a114fe5c430@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 14/09/09 09:40, briaeros007 wrote:
> Hello,
>
> First of all, i'm sorry if my questions is something "dumb".
>
> Here the context of my trouble :
> I have create a server with an php website.
> This php website use a postgresql db on the same server.
> I use a RHEL 5.3 and selinux with the policy "targeted".
>
> For the website to works properly, i must add the rules :
> "allow httpd_t postgresql_port_t:tcp_socket name_connect;"
>
> So now my problem is :
> If i update my server and the policy is updated : Is there a way to
> automatically add this (local) rule ?
>
> What i want to do is to use the rhel policy as a base, and to add my
> own local rules without the need to recompile them/add them manually
> at each update.
>
> I don't know if i'm very clear /o\

You probably don't need to add any rules at all. Try setting this 
boolean instead:

# setsebool -P httpd_can_network_connect_db=1

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
