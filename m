Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4EC6Vs022096
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 09:12:07 -0500
In-Reply-To: <CAPzO=NxBnkkQgJSS_mtdGqW0G6Pb9rVZ8yafG5-qSmjVZjEAPg@mail.gmail.com>
References: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
 <CAPzO=NxBnkkQgJSS_mtdGqW0G6Pb9rVZ8yafG5-qSmjVZjEAPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: user_r/sysadm_r/staff_r/unconfined_r
From: Russell Coker <russell@coker.com.au>
Date: Wed, 05 Nov 2014 01:11:57 +1100
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <9B0301A1-299E-40E8-814E-F69E84D3D861@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We could use the seuser and/or MCS fields to restrict running the programs that enter the domains in question. 

Also now it's an issue of systemd access which changes things a bit, I haven't looked into this yet.

On November 5, 2014 12:31:48 AM GMT+11:00, Sven Vermeulen <sven.vermeulen@siphos.be> wrote:
>On Nov 4, 2014 12:46 PM, "Russell Coker" <russell@coker.com.au> wrote:
>>
>> The role separation seems to give no benefit apart from
>sysadm_r/unconfined_r given that we have seuser based constraints and
>MCS
>labels to separate users and that they all use the same types.
>
>I disagree. Roles allow for restricting the domains that users can
>transition into. I use them often for granting users "limited root".
>For
>instance dbadm_r for DBAs versus webadm_r for web app server admins.
>
>Wkr,
>  Sven Vermeulen
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Samsung Galaxy Note 3 with K-9 Mail.
