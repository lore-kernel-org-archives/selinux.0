Message-ID: <45243344.5070608@hp.com>
Date: Wed, 04 Oct 2006 18:18:44 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
Cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        eparis@redhat.com, jmorris@namei.org
Subject: Re: [PATCH v4 1/2] NetLabel: secid reconciliation support
References: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com> <1159993643.19176.256.camel@moss-spartans.epoch.ncsc.mil> <45241EFF.2000108@hp.com> <200610041712.00629.sgrubb@redhat.com>
In-Reply-To: <200610041712.00629.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Wednesday 04 October 2006 16:52, Paul Moore wrote:
> 
>>I think we are all in agreement that the current xinetd patch is broken.
>> Hopefully Steve Grubb will have fix it soon (I just added him as a CC).
> 
> 
> In my opinion, this should be in bugzilla. This is the first I heard of xinetd 
> being broken. LSPP issues that need quick solutions like this can get lost in 
> mail.

I just filed https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=209379

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
