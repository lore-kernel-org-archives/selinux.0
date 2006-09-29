Message-ID: <451D5CE4.30700@hp.com>
Date: Fri, 29 Sep 2006 13:50:28 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com> <451D4A51.4000603@hp.com> <Pine.LNX.4.64.0609291247170.6007@d.namei> <Pine.LNX.4.64.0609291329030.7218@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609291329030.7218@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 29 Sep 2006, James Morris wrote:
> 
> 
>>On Fri, 29 Sep 2006, Paul Moore wrote:
>>
>>
>>>>It seems more of a pain to actually
>>>>prevent their use at the same time and/or explain strange/unnatural
>>>>behavior.
>>>
>>>Agreed, the solution that we agreed upon is much easier to implement and
>>>explain than a lot of the alternatives.
>>
>>Ok, can you please explain it further?
>>
>>i.e. show me what the policy looks like, exactly what the user is trying 
>>to achieve, and explain what happens to each packet exactly in terms of 
>>labeling on the input and output paths.
>  
> Also, why can't this be done just with xfrm labeling?

I believe the issue Venkat and I were discussing was how to handle the
case of multiple external labeling protocols, i.e. what to do if we get
a packet through labeled SA which has a CIPSO option.  As I've said
before, I don't believe this is something we will see much in practice
but I think we need to decide what to do: handle it somehow or just punt
on the problem and drop it.  Several people with experience with
external labeling have commented on how supporting both external
labeling protocols would be a good idea so Venkat and I are trying to
come up with a solution that works.

Please see my reponse with the pseudo code/policy examples as this might
help clear things up.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
