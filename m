Message-ID: <451D7D6B.9010900@hp.com>
Date: Fri, 29 Sep 2006 16:09:15 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com> <451D4A51.4000603@hp.com> <Pine.LNX.4.64.0609291247170.6007@d.namei> <451D5B3F.70206@hp.com> <Pine.LNX.4.64.0609291430130.7553@d.namei> <451D6EB1.3040006@hp.com> <Pine.LNX.4.64.0609291517170.7975@d.namei> <451D793A.4040007@hp.com> <Pine.LNX.4.64.0609291557520.8199@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609291557520.8199@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 29 Sep 2006, Paul Moore wrote:
>>>... or you get no CIPSO label (e.g. ICMP from intermediate router) ...
>>
>>If there is no packet label that NetLabel recognizes and NetLabel is
>>configured to allow unlabeled traffic then the NetLabel SID generated in
>>step #1 above would be 0.
> 
> 
> Well, conntrack will say that this packet is related to the connection 
> and CONNSECMARK will restore the secmark label to it (i.e. it'll have the 
> same secmark as the initial syn packet).  But, no CIPSO label.  I guess 
> this needs to be considered in any case, secmark or not.

Yep, I would categorize this case as 'external label not present,
internal label present'.  I believe the code as described would do the
right thing in allowing admins to control this, it's just up to how you
configure the system and what your policy dictates.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
