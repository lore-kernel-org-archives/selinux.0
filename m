Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6G4eLK2004596
 for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2014 00:40:21 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so572625pab.12
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 21:40:24 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.64.98])
 by mx.google.com with ESMTPSA id b15sm12517921pbu.12.2014.07.15.21.40.22
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 15 Jul 2014 21:40:23 -0700 (PDT)
Message-ID: <53C60234.8060208@gmail.com>
Date: Wed, 16 Jul 2014 10:10:20 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Where does semanage store changes?
References: <53C2376F.7040805@gmail.com> <53C3D938.20307@tycho.nsa.gov>
In-Reply-To: <53C3D938.20307@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/14/14 18:50, Stephen Smalley wrote:
> On 07/13/2014 03:38 AM, dE wrote:
>> Except when deleting and adding modules (when the main policy binary
>> changes; did a checksum to verify that), where are other changes which
>> semanage makes (like change boolean values, users, port, interface,
>> node) stored?
> Ultimately all of the changes you listed have to be stored in the kernel
> policy binary since they are part of the kernel policy (unlike, for
> example, semanage fcontext or login mappings).  However, they are also
> kept in separate configuration files under
> /etc/selinux/$SELINUXTYPE/modules/active and merged into the generated
> kernel policy after linking and expanding the policy modules together.
> Non-kernel configurations such as fcontext or login mappings are stored
> in their own respective files, e.g. file_contexts.local and seusers.
>
>

Yes, semodule -B merges those changes making active directory empty.

However, semange still remembers the changes it made (using -E).

Thanks for the clarification.
