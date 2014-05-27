Message-ID: <53848A47.4000706@tycho.nsa.gov>
Date: Tue, 27 May 2014 08:51:19 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Dominick Grift <dominick.grift@gmail.com>, dE <de.techno@gmail.com>
Subject: Re: Significance of SELinux user and roles on objects.
References: <537AE191.7070403@gmail.com> <537B5BD3.4090507@tresys.com>
 <537D9F47.7020704@gmail.com> <1400743958.10370.0.camel@x220.localdomain>
 <537F5039.5070806@tycho.nsa.gov> <538486E0.4030506@tresys.com>
In-Reply-To: <538486E0.4030506@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2014 08:36 AM, Christopher J. PeBenito wrote:
> On 05/23/2014 09:42 AM, Stephen Smalley wrote:
>> On 05/22/2014 03:32 AM, Dominick Grift wrote:
>>> On Thu, 2014-05-22 at 12:25 +0530, dE wrote:
>>>> On 05/20/14 19:12, Christopher J. PeBenito wrote:
>>>>> The kernel will create files with object_r regardless
>>>>
>>>> Is this defined in the policy or is hard coded in the kernel?
>>>
>>> Hard coded into the kernel
>>
>> Unless the policy specifies to default from source or target for the
>> file class...
> 
> So if I explicitly put default_role from target it will start inheriting the directory's role?  If so, did that change also fix role_transition to work on file creation? i.e. can I write a rule like:
> 
> role_transition user_r tmp_t:file user_r;
> 
> So I can get the default_role from source-like behavior on certain types (I'd like to bring back role separations in refpolicy)?

policy.26 added support for role transitions on object classes.
policy.27 added support for default rules for user/role/range
inheritance (and policy.28 did the same for type inheritance).
