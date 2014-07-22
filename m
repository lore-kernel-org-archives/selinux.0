Message-ID: <53CE7968.4000608@tycho.nsa.gov>
Date: Tue, 22 Jul 2014 10:47:04 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53C01CDD.80407@tresys.com>
 <53C409C3.3010602@tycho.nsa.gov> <53C40B13.9030907@tycho.nsa.gov>
 <53C40E8D.8070006@tycho.nsa.gov> <53C40F73.3030204@tresys.com>
 <53C41818.5000906@tycho.nsa.gov> <53C5875E.3050600@tresys.com>
 <53C68950.3050805@tycho.nsa.gov> <53C68A6D.80500@tycho.nsa.gov>
 <53C68BAE.4000303@tycho.nsa.gov> <53C68D40.8020700@tycho.nsa.gov>
 <53C69616.3040808@tresys.com> <1405526012.12577.9.camel@x220.localdomain>
 <53C6CBD8.2050509@tycho.nsa.gov> <53C7D452.3030206@tresys.com>
 <53C80FA5.3050705@tycho.nsa.gov> <53C81CDC.8080803@tresys.com>
In-Reply-To: <53C81CDC.8080803@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/17/2014 02:58 PM, Steve Lawrence wrote:
> On 07/17/2014 02:02 PM, Stephen Smalley wrote:
>> On 07/17/2014 09:49 AM, Steve Lawrence wrote:
>>> On 07/16/2014 03:00 PM, Stephen Smalley wrote:
>>>> On 07/16/2014 11:53 AM, Dominick Grift wrote:
>>>>> On Wed, 2014-07-16 at 11:11 -0400, Steve Lawrence wrote:
>>>>> <snip>

>
>> Any chance of getting a hll compiler for refpolicy source modules, i.e.
>> in .if/.te/.fc form?
>
> That's in the plan. Jim has a tool that will compile .if/.te/.fc to CIL,
> but the current HLL infrastructure may need some changes before that can
> be supported. I think the main problem is that Jim's tool needs
> knowledge of all modules to be able to convert them to CIL, but the
> current HLL infrastructure compiles each module separately. We have
> various ideas on how we can update the HLL infrastructure to support
> this, but we've primarily been focused on getting the core CIL/HLL
> functionality complete and upstreamed before focusing on the more
> complicated HLL patterns.

My tool currently does need to have knowledge of all modules, but I think that I 
can get it to work with the information in /usr/share/selinux/devel/include. At 
least as long as the module is not doing anything crazy with m4.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
