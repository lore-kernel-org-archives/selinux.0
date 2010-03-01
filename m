Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o21JTgpQ013292
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 14:29:42 -0500
Received: from mail-bw0-f222.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o21JU3iu017312
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 19:30:04 GMT
Received: by bwz22 with SMTP id 22so947683bwz.19
        for <selinux@tycho.nsa.gov>; Mon, 01 Mar 2010 11:29:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B858A2A.8080302@redhat.com>
References: <4B858A2A.8080302@redhat.com>
Date: Mon, 1 Mar 2010 14:29:38 -0500
Message-ID: <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
Subject: Re: Audit2allow generating dontaudit rules.
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd rather pass in the rule type to the AVRule init rather than a
boolean about this being a dontaudit rule.

Karl

On Wed, Feb 24, 2010 at 3:20 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
