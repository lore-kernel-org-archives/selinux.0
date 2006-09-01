Message-ID: <44F89F0C.6030402@hp.com>
Date: Fri, 01 Sep 2006 16:58:52 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com, jbrindle@tresys.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Unfortunately, the fix
>>is not immediately obvious.
> 
> You would use the xfrm_sid and in it's absence the node
> sid as the base sid.

That is not the issue I am dealing with right now.

I now have a solution in mind, however, it is doubtful I will have a
chance to do any sort of testing on it before I leave tonight.  Once I
can give it a quick test to verify that it doesn't break anything I'll
post a patch for you and Joy to verify.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
