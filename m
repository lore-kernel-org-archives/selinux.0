Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n69Ep21D022236
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 10:51:03 -0400
Received: from smtp105.prem.mail.ac4.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n69Eoh3J003106
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 14:50:43 GMT
Message-ID: <4A5603BF.6010809@schaufler-ca.com>
Date: Thu, 09 Jul 2009 07:50:39 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Thomas Liu <tliu@redhat.com>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, eparis@parisplace.org,
        etienne.basset@numericable.fr
Subject: Re: [PATCH 1/3] Move variable function in lsm_audit.h into SMACK
 private space
References: <1247148029.2276.9.camel@Ares> <4A55FBFC.20306@schaufler-ca.com> <1247149402.2830.16.camel@dhcp235-23.rdu.redhat.com>
In-Reply-To: <1247149402.2830.16.camel@dhcp235-23.rdu.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Thu, 2009-07-09 at 07:17 -0700, Casey Schaufler wrote:
>   
>> Thomas Liu wrote:
>>     
>>> Moved variable function in include/linux/lsm_audit.h into the
>>> smack_audit_data struct since it is never used outside of it.
>>>   
>>>       
>> What value does this change provide?
>>     
>
> By itself, none other than proper abstracting.  ->function is a smack
> specific object so it shouldn't be in the generic space.  Along with
> patch #3 it saves memory on systems that choose to build without SMACK.
>   

I don't see any problems with it then.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
