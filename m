Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GGMkpe012879
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 11:22:46 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0GGNdAN008745
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:23:39 GMT
Message-ID: <45ACFC09.5000002@tresys.com>
Date: Tue, 16 Jan 2007 11:23:37 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] add selpolgen
References: <45ACEE9E.7000709@mentalrootkit.com>
In-Reply-To: <45ACEE9E.7000709@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> This is a patch (available for download because of size - see url 
> below) to add a python library named selpolgen and a new version of 
> audit2allow that uses this library. This is a minimally changed 
> version of what I have been calling madison.
>
> I am submitting this for inclusion as part of the main selinux 
> distribution. I believe that inclusion here will help make good policy 
> generation tools develop sooner and give a common base for creating 
> new tools.
>
> Questions:
> * I have the library at the top-level of the project - like the C 
> libraries. Is this the best location? What about the name?
This doesn't seem like a good place, and the upstream selinux repo 
doesn't seem like a good dumping ground for all-things-selinux either, I 
don't know of a better way to spur community support though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
