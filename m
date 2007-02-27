Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1RLScgS011152
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 16:28:38 -0500
Received: from web51515.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1RLU07G027981
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 21:30:00 GMT
Date: Tue, 27 Feb 2007 13:29:23 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Lazy config init in libselinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1172610646.19041.419.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <425863.72079.qm@web51515.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> however, they are not used in any selinux config file I've ever seen. 
>> Are they brand new and never used? Is there a reason they are 
>> not in /etc/selinux/config by default?
>
>Only CACHETRANS appears to be an issue.  You only need to define them
>in /etc/selinux/config if you want something other than the default
>value.

I don't see that one in the config file so I think everyone is using the default
value.

>It was added back when the libselinux client-side support for context
>translation was merged, upon someone's specific request on list.  So
>we'd have to go back to that discussion.

I bet it was worked around and not needed. We should revisit that discussion
since it appears to not be defined in the default config file.

>> What about /etc/security...is that still used? Should that go away?
>
>Likely obsolete, although we'd need to post an rfc asking whether any
>distro is still using that as the location for their policy files.

Sure. I was just pointing out the fact its there and is likely deprecated.

-Steve


 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
