Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m47FI55w028457
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2008 11:18:05 -0400
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m47FI5E4003880
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2008 15:18:05 GMT
Received: by yw-out-1718.google.com with SMTP id 6so166599ywa.84
        for <selinux@tycho.nsa.gov>; Wed, 07 May 2008 08:17:47 -0700 (PDT)
Message-ID: <7e0fb38c0805070817h72ac3ce7k24dc38b7eaf0ec24@mail.gmail.com>
Date: Wed, 7 May 2008 11:17:46 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
Cc: "James Morris" <jmorris@namei.org>, selinux@tycho.nsa.gov,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
	 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
	 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  I assume we do NOT want to use this variant interface when getting
>  contexts to display in audit messages, as we want the audit messages to
>  correspond to the actual denial and to yield proper policy if turned
>  into an allow rule.

Is there any way we could get them both displayed if there is a
denial?  Might be interesting to know both that the denial was
actually unlabeled_t object but also what the 'incorrect' label
was.....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
