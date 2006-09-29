Message-ID: <451D6EB1.3040006@hp.com>
Date: Fri, 29 Sep 2006 15:06:25 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <method@gentoo.org>,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com> <451D4A51.4000603@hp.com> <Pine.LNX.4.64.0609291247170.6007@d.namei> <451D5B3F.70206@hp.com> <Pine.LNX.4.64.0609291430130.7553@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609291430130.7553@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 29 Sep 2006, Paul Moore wrote:
> 
>>James Morris wrote:
>>
>>>Ok, can you please explain it further?
>>>
>>>i.e. show me what the policy looks like, exactly what the user is trying 
>>>to achieve, and explain what happens to each packet exactly in terms of 
>>>labeling on the input and output paths.
>>
>>All right, here is my take on it, perhaps Venkat can chime in too.
> 
> Thanks, that cleared up many things, but how does this interact with 
> CONNSECMARK?
> 
> Please provide some example iptables rules, SELinux policy statements, 
> racoon config and netlabel config.  I need to understand exactly what 
> happens to each packet in, say, an FTP session and how you envisage the 
> configuration.

Hopefully Venkat can talk to the iptables rule, policy statements, and
racoon config.  He has the best understanding of how this works with the
secid patches.  There really is no specific NetLabel config as the
NetLabel config only specifies how to create the explicit packet label
(CIPSO IPv4 option) using the socket's SID.  NetLabel, like SECMARK, is
just a packet labeling mechanism.

I think the key thing to remember is that the only change brought about
by the pseudo-code I posted earlier is that the secmark's MLS label
would be adjusted to match the value of the NetLabel (CIPSO option)
assuming it passes the avc flow_in checks.

> Here's a sample scenario for the above (let me know if this is not how 
> you expect this to be used):
> 
> Say that the SA is labeled "secret" and you have two FTP clients 
> connecting to a server via xinetd on this SA.  Each client additionally 
> labels their packets via CIPSO as secret:c1 and secret:c2 respectively.  
> xinetd launches an FTP server for each at the correct level.

I believe Venkat can address this.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
