Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s397TBTf001965
 for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2014 03:29:11 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2149147pbb.22
 for <selinux@tycho.nsa.gov>; Wed, 09 Apr 2014 00:29:10 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.84.84])
 by mx.google.com with ESMTPSA id vb7sm500352pbc.13.2014.04.09.00.29.08
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 09 Apr 2014 00:29:10 -0700 (PDT)
Message-ID: <5344F631.2050801@gmail.com>
Date: Wed, 09 Apr 2014 12:56:41 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: The purpose of SID.
References: <5343B5EA.3010909@gmail.com> <5343E893.8050705@tycho.nsa.gov>
 <5343E8BC.1010202@tycho.nsa.gov>
In-Reply-To: <5343E8BC.1010202@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/08/14 17:47, Stephen Smalley wrote:
> On 04/08/2014 08:16 AM, Stephen Smalley wrote:
>> On 04/08/2014 04:40 AM, dE wrote:
>>> As I read in the SELinux docs, each subject and object is assigned a
>>> unique SID; when using the selinux libraries, or using the SELinux
>>> kernel API the programs are expected to request the security server
>>> decisions for a particular subject and object by passing the subject and
>>> object's SID to the security server.
>>>
>>> Question is -- is SID created when an SELinux enabled kernel boots or
>>> just when a SELinux enabled program requests an SID for a subject/object
>>> from the kernel?
>>>
>>> Also can I see a process's and file's SID via some program?
>> Except for a small set of predefined initial SIDs (used for
>> bootstrapping before policy is loaded), SIDs are dynamically allocated
>> on demand for security contexts when they are first used.
>>
>> The kernel does not expose its SIDs to userspace; all of the userspace
>> APIs provided by the kernel pass security contexts instead; see:
>> http://www.nsa.gov/research/_files/selinux/papers/module/x362.shtml
>>
>> However, libselinux does provide a userspace SID abstraction for users
>> of the userspace AVC implementation (man avc_context_to_sid).  Those
>> SIDs are likewise dynamically allocated on demand for security contexts
>> when they are first used, but are merely local references to the
>> security context; that mapping is per-process and has no global meaning.
> Also, SIDs are not unique per subject/object but rather per security
> context.
>
>

It doesn't make sense to give each subject and object unique SID cause 
the security server doesn't have to do anything with individual subject 
and object instead it has to do with the security context.

That clears things up. Thanks!
