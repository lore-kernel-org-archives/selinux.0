Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s465mVNg026809
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 01:48:31 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so9255497iec.21
 for <selinux@tycho.nsa.gov>; Mon, 05 May 2014 22:48:30 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.87.30])
 by mx.google.com with ESMTPSA id vm7sm35205221igb.1.2014.05.05.22.48.28
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 05 May 2014 22:48:29 -0700 (PDT)
Message-ID: <5368770F.6080104@gmail.com>
Date: Tue, 06 May 2014 11:15:51 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a module exactly?
References: <53665D05.6070403@gmail.com> <53677C2F.7020800@tresys.com>
In-Reply-To: <53677C2F.7020800@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/14 17:25, Christopher J. PeBenito wrote:
> On 05/04/2014 11:30 AM, dE wrote:
>> I'm trying to verify what I think cause I've not read about this yet --
>>
>> A SELinux 'module' is like a C object file; each module has a purpose of defining policies for a certain program.
>>
>> Each module may be made a separate policy or many modules can be integrated into one policy file (like what Fedora has done).
> If you're talking about modules as in .pp files, then yes, they're a similar concept to C object code.  Each module has a chunk of policy, and then all the modules are linked together to create the final policy.2x.  There has to be at least one module in the policy, the base module.  It is special in that all of the unconditional (not optional) dependencies must be met.  There are also statements that only can exist the base module, such as portcon, genfscon, and others.  Otherwise, what is actually contained in each module is up to the policy writer.  The modules tend to correspond to software packages.  For example, in Reference Policy, there is an apache module which should constrain apache, a samba module for samba, etc.
>

Thanks for clarifying that!
