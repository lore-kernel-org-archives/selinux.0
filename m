Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OHuXla013233
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 13:56:33 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OHuX0e005024
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 17:56:33 GMT
Message-ID: <4E553ACC.6020903@manicmethod.com>
Date: Wed, 24 Aug 2011 13:54:20 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, cpebenito@tresys.com,
        slawrence@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>
In-Reply-To: <4E53AE8C.6020707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Eliminating booleans would be great and replacing them with tunables,
> but the tunables must be discoverable, and it must be easy for the
> administrator to discover the "tunable" and turn it on.
>
> Currently audit2allow/audit2why turns on all booleans in a policy and
> checks to see if an AVC would be allowed with any boolean.  Then it
> prints out the booleans that would have allowed the access.  We use
> this functionality within setroubleshoot.  This is critical to making
> selinux policy usable.
>
> User wants to allow ftp to access homedirs, he sets up ftp and SELinux
> blocks the access.  Setroubleshoot comes up and says turn on the
> ftp_home_dir boolean to allow this access.
>
>
> If we can not duplicate this functionality then I NAK the change from
> booleans to tunables.

You could actually force a downgrade to a pre-tunable format and use that policy 
to do the setroubleshoot lookups. Since the policy is already linked/expanded 
and just needs to be written out twice it wouldn't add much time to policy 
building (granted that adding _any_ time to policy building is adding too much...)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
