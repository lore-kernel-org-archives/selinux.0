Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SFCqfL008842
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 11:12:52 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SFCoM5004612
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 15:12:51 GMT
Received: by wx-out-0506.google.com with SMTP id t8so2020168wxc
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 08:12:50 -0700 (PDT)
Message-ID: <46D43B6F.5050902@gmail.com>
Date: Tue, 28 Aug 2007 10:12:47 -0500
From: Darrel Goeddel <sedgoeddel@gmail.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D43808.4050008@gmail.com>
In-Reply-To: <46D43808.4050008@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Paul, why the netif/host combo in the original netlabel fallback patch? 
>  Why not just hosts (or really network/netmask)?  Can we make the
> 

Sorry, don't know what happened to the rest of the text...

Can we make the netif optional or add a wildcard netif?  That would 
allow for a truly generic fallback if desired.  Currently if you add a 
new interface, you need to go back and add a new rule (I think, could be 
wrong since I haven't actually tried it).

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
