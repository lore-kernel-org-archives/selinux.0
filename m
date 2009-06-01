Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n51CadXg027748
	for <selinux@tycho.nsa.gov>; Mon, 1 Jun 2009 08:36:39 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n51CaU5t010081
	for <selinux@tycho.nsa.gov>; Mon, 1 Jun 2009 12:36:31 GMT
Message-ID: <4A23CB29.1020803@redhat.com>
Date: Mon, 01 Jun 2009 08:35:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] libjackserver.so file context
References: <20090530084611.GA8305@vogon.seekline.net>
In-Reply-To: <20090530084611.GA8305@vogon.seekline.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/30/2009 04:46 AM, Stefan Schulze Frielinghaus wrote:
> Hi,
>
> libjackserver.so needs text relocation. Attached file solves the
> problem.
>
> cheers
> Stefan
Please report this as a bug to the providers of libjackserver.so


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
