Message-ID: <537F6F7A.7090805@tycho.nsa.gov>
Date: Fri, 23 May 2014 11:55:38 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Significance of SELinux user and roles on objects.
References: <537AE191.7070403@gmail.com> <537B5BD3.4090507@tresys.com>
 <537D9F47.7020704@gmail.com> <1400743958.10370.0.camel@x220.localdomain>
 <537F5039.5070806@tycho.nsa.gov> <537F6D02.2010801@gmail.com>
In-Reply-To: <537F6D02.2010801@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/23/2014 11:45 AM, dE wrote:
> On 05/23/14 19:12, Stephen Smalley wrote:
>> On 05/22/2014 03:32 AM, Dominick Grift wrote:
>>> On Thu, 2014-05-22 at 12:25 +0530, dE wrote:
>>>> On 05/20/14 19:12, Christopher J. PeBenito wrote:
>>>>> The kernel will create files with object_r regardless
>>>> Is this defined in the policy or is hard coded in the kernel?
>>> Hard coded into the kernel
>> Unless the policy specifies to default from source or target for the
>> file class...
>>
>>
> 
> So you can define the default object in the policy file as per the
> object class.

See:
http://selinuxproject.org/page/DefaultRules
