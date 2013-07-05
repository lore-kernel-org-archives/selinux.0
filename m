Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r65Kojp3009208
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2013 16:50:45 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so2121096veb.11
        for <selinux@tycho.nsa.gov>; Fri, 05 Jul 2013 13:50:44 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: selinux@tycho.nsa.gov
Subject: Re: Labeled IPSec trying to match policy for peer label?
Date: Fri, 05 Jul 2013 16:50:41 -0400
Message-ID: <2894544.bL1dEvHUlK@sifl>
In-Reply-To: <20130705183902.GA26996@siphos.be>
References: <20130705183902.GA26996@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, July 05, 2013 08:39:02 PM Sven Vermeulen wrote:
> Hi all,
> 
> I'm trying to get a Labeled IPSec working, but the moment I enable a context
> on the SPD, any attempt to set up an SA (by racoon) fails with the
> following message:
> 
> Jul  5 20:25:16 test racoon: INFO: respond new phase 2 negotiation:
> 192.168.100.152[500]<=>192.168.100.153[500] Jul  5 20:25:16 test racoon:
> ERROR: no policy found: 10.1.3.0/24[0] 10.1.2.0/24[0] proto=any dir=in
> sec_ctx:doi=1,alg=1,len=24,str=root:sysadm_r:ping_t:s0 Jul  5 20:25:16 test
> racoon: ERROR: failed to get proposal for responder.
> 
> There is (of course?) no policy for ping_t, only for ipsec_spd_t. Let me
> show you the setkey instructions:
> 
> spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
>   "system_u:object_r:ipsec_spd_t:s0" -P out ipsec
>   esp/tunnel/192.168.100.152-192.168.100.153/require;
> 
> spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
>   "system_u:object_r:ipsec_spd_t:s0" -P in ipsec
>   esp/tunnel/192.168.100.153-192.168.100.152/require;
> 
> If I drop the "-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0"" then the IPSec
> works (I verified that it is indeed IPSec traffic). For allowing ping to
> work across the Labeled IPSec setup, I have added allow rules for kernel_t
> and ping_t to association:polmatch against ipsec_spd_t (without those, IPSec
> isn't used as expected).
> 
> Considering I get the error message on the server side tells me that the
> label is properly passed on (so ping_t is the peer label) but I was
> expecting that it would match the policy on the ipsec_spd_t context?

Is the server side running the same SELinux policy as the client?  Does the 
server have a SPD entry that is labeled, e.g. '-ctx 1 1 
"system_u:object_r:ipsec_spd_t:s0"'?

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
