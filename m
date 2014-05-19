Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4JGsxjG025107
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 12:54:59 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so6011125pab.21
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 09:54:59 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.88.8])
 by mx.google.com with ESMTPSA id sh5sm30996339pbc.21.2014.05.19.09.54.57
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 19 May 2014 09:54:58 -0700 (PDT)
Message-ID: <537A36C4.6050201@gmail.com>
Date: Mon, 19 May 2014 22:22:20 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How does SELinux work without roles?
References: <537992DF.9050806@gmail.com> <537A3754.3020506@tresys.com>
In-Reply-To: <537A3754.3020506@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/19/14 22:24, Christopher J. PeBenito wrote:
> On 05/19/2014 01:13 AM, dE wrote:
>> RBAC is completely optional in SELinux; however there appears to be no way to specify the allowed types for a particular user without specifying roles.
>>
>> Without this, there'll be no enforcement.
> You still need to have user->role and role->type associations, but you can simply have one role and remove any constraints related to roles.  You cannot completely disable the RBAC mechanism like you can disable MLS.
>

Ok, thanks for clarifying that.
