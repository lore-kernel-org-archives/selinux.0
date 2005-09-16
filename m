Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8GKQENs000902
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 16:26:14 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8GKMjPO009784
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 20:22:45 GMT
Message-ID: <432B2A35.1020301@redhat.com>
Date: Fri, 16 Sep 2005 16:25:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ping broken symptoms
References: <1126901679.18007.138.camel@sgc.columbia.tresys.com>
In-Reply-To: <1126901679.18007.138.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>At the bottom of the ping policy, there is this ifdef:
>
>ifdef(`hide_broken_symptoms', `
>allow ping_t init_t:fd use;
>')
>
>Isn't the purpose of the hide_broken_symptoms m4 tunable to dontaudit
>broken code that can work without these accesses, not allow them?
>
>  
>
yes

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
