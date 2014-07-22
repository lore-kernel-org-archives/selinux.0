Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6MCRBtr027949
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 08:27:11 -0400
Message-ID: <53CE589C.4030408@tresys.com>
Date: Tue, 22 Jul 2014 08:27:08 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: What's a policy capability?
References: <53CA2650.2050608@gmail.com> <53CD0CCB.5080300@tycho.nsa.gov>
 <53CDF09D.4050304@gmail.com>
In-Reply-To: <53CDF09D.4050304@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/22/2014 1:03 AM, dE wrote:
> On 07/21/14 18:21, Stephen Smalley wrote:
>> On 07/19/2014 04:03 AM, dE wrote:
>>> I came cross this term and couldn't find much reference to it.
>> A mechanism for telling the kernel that your policy supports some new
>> feature/capability and therefore it is safe for the kernel to enable the
>> corresponding check/logic.  Used as a way of supporting new
>> checks/features in a backward-compatible manner:  old policies will not
>> have defined the policy capability for the new feature and therefore
>> will not enable the new check/logic by default, while new policies can
>> opt into or out of the new check/logic at their discretion.
>>
> 
> Ok, thanks for clarifying.
> 
> But just curious -- these new checks may not be not be backwards
> compatible? I mean if the kernel has enabled a policy feature, but the
> loaded policy does not have any such capability, then can it cause any
> problems?

Yes.  One example is the open permission on file classes.  When that was
added in the kernel, if you didn't have a policy that had open
permissions in it, then your system wouldn't work at all; no domain
would be allowed to open any file.  To fix that, we added the open_perms
capability, so you could specify that your policy was updated for the
open permission.

> Also the policy has a version, using that it's capabilities can be known
> to the kernel and it may enable disable the features based on that. So
> in this case, why is policy capability required?

That versions the policy database structure itself, not which object
classes or permissions are included.  For example, when default_*
statements were added, the policy structure had to be changed, so the
policy version was incremented.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
