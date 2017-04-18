Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3IC3Qv6003686
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 08:03:26 -0400
Received: by mail-oi0-f43.google.com with SMTP id j201so21273943oih.2
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 05:03:25 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-136-2.tx.res.rr.com. [70.119.136.2])
 by smtp.gmail.com with ESMTPSA id
 w188sm6062677oiw.41.2017.04.18.05.03.24 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Apr 2017 05:03:24 -0700 (PDT)
Subject: Re: Cannot write policy to allow { relabelto }
To: selinux@tycho.nsa.gov
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
 <20170418061509.GA26339@markus>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
Date: Tue, 18 Apr 2017 07:03:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170418061509.GA26339@markus>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2017 01:15 AM, Dominick Grift wrote:
> acme_nss_t needs to be associate with "can_change_object_identity" to
> be able to change the object identity from system_u to unconfined_u
> 
> typeattribute acme_nss_t can_change_object_identity;
> 
> or the appropriate macro:
> 
> domain_obj_id_change_exemption(acme_nss_t)

Excellent, thank you!

> 
> But there is no need to change the object identity in the first
> place, system_u will do fine.

I'll have to think about this.  I'm actually copying a directory tree
from one place to another and copying the context from the source to
destination with getfilecon() and setfilecon().

What APIs should I use if I *only* wanted to copy the type?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
