Message-ID: <46CF3F9C.2010200@manicmethod.com>
Date: Fri, 24 Aug 2007 16:29:16 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <454500.99769.qm@web36612.mail.mud.yahoo.com>
In-Reply-To: <454500.99769.qm@web36612.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
>   
>> as we start to develop a richer set of functionality the two labeling 
>> mechanisms need to work better together to ensure the consistency of the 
>> network access controls.  If the approach put forward in this patch set is 
>> agreed upon as the right way to solve the peer fallback problem I will be 
>> modifying it to take into account XFRM labels so that the NetLabel provided 
>> fallback peer label will only be used when there is no XFRM or NetLabel/CIPSO
>>
>> label on the packet.  Further, work will be done to ensure that when both a 
>> XFRM and NetLabel/CIPSO label are present on an incoming packet that the 
>> labels are the same, otherwise the packet will be dropped/rejected.
>>     
>
> It makes me uncomfortable to hear you say that XFRM is SELinux specific
> and that it needs to be integrated with NetLabel, which currently isn't.
> I know that Smack isn't upstream yet. Nonetheless, I would hate to see
> underlying mechanisms that currently provide useful facilities become
> SELinux specific.
>   

Joy will know better but I don't think there is anything really SELinux 
specific about XRFM. As far as the racoon support goes it just 
serializes and sends over a string context, algorithm and DOI. The LSM 
would responsible for verifying the context when it is set. One thing 
you'd have to figure out as an LSM writer is how to reconcile multiple 
incoming labels, much like we are trying to do right now. There are 
already function pointers in the security_ops struct for managing xfrm 
security data, it shouldn't be any problem for you to use them.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
