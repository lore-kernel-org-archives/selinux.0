Message-ID: <452415D4.60007@hp.com>
Date: Wed, 04 Oct 2006 16:13:08 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>, eparis@redhat.com
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation
  bits and a bugfix
References: <36282A1733C57546BE392885C0618592015CF969@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CF969@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> [ EXCLUDING netdev ]
> 
>>There was a secid patchset posted on Thursday (9/28) night, I 
>>posted the
>>a patch on Friday (9/29) to provide NetLabel support.
>>
>>There was a secid patchset posted on Sunday (10/1) night, I respun the
>>NetLabel support patch on Monday (10/2) - "v2".
>>
>>I respun the NetLabel support patch to take into account Stephen
>>Smalley's comments on Monday (10/2) - "v3".
>>
>>There was a small update to the secid patches yesterday (10/3) so I
>>respun the NetLabel support patch (10/4) - "v4".
>  
> You are making my head spin :)
> 

Glad it's not just mine ;)

>>>>Venkat, can you please merge the latest my latest NetLabel 
>>>>secid support
>>>>patch in with your next release?
>>> 
>>>I would, but it currently is premature. As James says, let's
>>>get policy done, the design proven, and tested and then we will
>>>go to netdev with one patchset.
>>
>>I think it's easier to decide on policy, review the design, 
>>and test it
>>all if there is one place/patchset with all of the latest 
>>bits/patches.
>> Right not it's not that easy with different patches scattered around.
> 
> I believe Eric Paris is already keeping track of this and I believe
> people are testing HIS kernel.

Yep, that's what I'm using.

> Actually since your patches need to be modified based on mine, it seems
> to make sense for either you or Eric take on the responsibility of tracking
> the patches and forwarding them on finally.

Why does this seem like a game of hot potato?

 :)

If Eric doesn't want to marshall this around I'll take care of it.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
