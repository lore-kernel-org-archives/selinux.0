Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s595XMcF011395
 for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2014 01:33:22 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so4578189pbb.39
 for <selinux@tycho.nsa.gov>; Sun, 08 Jun 2014 22:33:23 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.85.166])
 by mx.google.com with ESMTPSA id tg9sm61759775pbc.29.2014.06.08.22.33.20
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 08 Jun 2014 22:33:22 -0700 (PDT)
Message-ID: <5395467D.3090506@gmail.com>
Date: Mon, 09 Jun 2014 11:00:37 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Default context with context mount option.
References: <539477AF.20408@gmail.com> <20140608214629.5be73bfc@lexx.local>
In-Reply-To: <20140608214629.5be73bfc@lexx.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/08/14 23:16, Christian Evans wrote:
> On Sun, 08 Jun 2014 20:18:15 +0530
> dE <de.techno@gmail.com> wrote:
>
>> When a new file is created on a FS which supports security namespace but
>> the FS is mounted using context= option, then what will be the context
>> of the newly created file on the FS?
>>
> What do you mean by "security namespace" actually?
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

The xattr security namespace in the file system which's used by SELinux 
to store security context.
