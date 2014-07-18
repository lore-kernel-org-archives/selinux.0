Message-ID: <53C92B90.4040308@tresys.com>
Date: Fri, 18 Jul 2014 10:13:36 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Steve Lawrence <slawrence@tresys.com>,
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
 <53C81FA0.1020109@tycho.nsa.gov> <53C828A7.60909@tycho.nsa.gov>
 <53C82C6B.4090004@tresys.com> <53C8341D.4080300@tycho.nsa.gov>
In-Reply-To: <53C8341D.4080300@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/17/2014 4:37 PM, Stephen Smalley wrote:
> On 07/17/2014 04:04 PM, Steve Lawrence wrote:
>> On 07/17/2014 03:48 PM, Stephen Smalley wrote:
>>> On 07/17/2014 03:10 PM, Stephen Smalley wrote:

>> Yep, we store both HLL and CIL. They are both compressed and CIL
>> compresses decently since it's just text, but it's still a lot of text.
>>
>>> Is there an option to discard the .pp files altogether and only retain
>>> the cil files?
>>
>> Not at the moment, but it wouldn't be hard to accomplish. Just need to
>> delete all the hll files and change the contents of lang_ext to 'cil'.
>> Something we could add if storage is an issue.
[...]
> Not sure what benefit there is in retaining the pp files, since they
> carry no additional information AFAIK and they aren't human viewable or
> editable.  Is there even an option for exporting modules from the policy
> store currently that would allow extracting them except via direct file
> access to the policy store?

If we eventually have an upstream policy query library, then it could be
useful to export modules from the store for analysis tools.  Then you
could analyze the policy.29 but potentially have backtracing to the HLL
policy file and ideally source line where possible (obviously not for .pp).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
