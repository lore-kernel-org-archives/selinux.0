Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8JPXIi007597
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:25:34 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8JPau3000519
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:25:36 GMT
Message-ID: <41B75586.2010005@tresys.com>
Date: Wed, 08 Dec 2004 14:27:02 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: selinux-dev@tresys.com
Subject: Re: (ANN: SELinux Policy Modules) announcement dealy
References: <41B753E3.70805@tresys.com>
In-Reply-To: <41B753E3.70805@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Obviously I forgot to change the subject of this email to ANN: SELinux 
Policy Modules

Joshua Brindle

Joshua Brindle wrote:

> An updated release of the binary policy module infrastructure is
> available from http://www.tresys.com/selinux/. The binary policy module
> project aims to ease policy management by developing tools for creating
> binary policy modules that can be safely linked together on a production
> system to create a system policy. To the end user, managing binary
> policy modules will be similar to managing software with a binary
> package manager like RPM. More information can be found on the website.
>
> This infrastructure includes a module compiler (checkmodule) and a set
> of programs for policy management (semodule_link, semodule_expand, and
> semodule).
>
> This release is experimental and is not intended for production use. It
> is being released to generate community feedback and discussion. For
> information on using semodule please refer to the README.MODULE file in
> selinux-doc.
>
> Joshua Brindle
> Tresys Technology
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
