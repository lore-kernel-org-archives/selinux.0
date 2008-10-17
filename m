Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9HKnB6r024008
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 16:49:11 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9HKnBhc010569
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 20:49:11 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1139419wff.30
        for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 13:49:10 -0700 (PDT)
Message-ID: <7e0fb38c0810171349x6dea3918kdad3a09e65668c44@mail.gmail.com>
Date: Fri, 17 Oct 2008 16:49:10 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Eric Paris" <eparis@redhat.com>
Subject: Re: [PATCH] selinux: new permission for chmod on suid or sgid files
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, sgrubb@redhat.com
In-Reply-To: <1224275917.3189.63.camel@paris-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224258034.3189.25.camel@paris-laptop>
	 <1224262355.19562.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1224264294.19562.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8DCE3.3000805@redhat.com>
	 <1224269637.19562.115.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8E333.3060905@redhat.com>
	 <1224272365.19562.144.camel@moss-spartans.epoch.ncsc.mil>
	 <1224273875.3189.46.camel@paris-laptop>
	 <1224274196.19562.165.camel@moss-spartans.epoch.ncsc.mil>
	 <1224275917.3189.63.camel@paris-laptop>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FAIL ALERT!

On Fri, Oct 17, 2008 at 4:38 PM, Eric Paris <eparis@redhat.com> wrote:
Yes, DAC sercurity
> policy that I'm talking about is !!NOT!!! mathmatically provable and that's the
> part that I'm sure you initially reject, but it doesn't make it
> pointless or even detractive.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
