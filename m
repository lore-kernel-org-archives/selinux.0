Subject: Re: setoolsv4: tracking origin of a policy element
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, Elena Reshetova
 <elena.reshetova@gmail.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
References: <CALrft9-5ZFbJgiLZnXoeroAgqhZ+rmzCENXSgdqtyC5+_6pZ-w@mail.gmail.com>
 <562E2796.8000308@tresys.com>
From: Filippo Bonazzi <filippo.bonazzi@aalto.fi>
Message-ID: <5642110C.2080607@aalto.fi>
Date: Tue, 10 Nov 2015 17:45:16 +0200
MIME-Version: 1.0
In-Reply-To: <562E2796.8000308@tresys.com>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>> given a certain rule or attribute, it would be great to know in what source file it was defined.
> Past versions of SETools supported that, but it has not yet been a priority for v4.
Which previous version(s) of SETools supported origin file/line information?

I have scoured the setools3 libqpol source files for this, and I have
found that the file/line information from the m4 synclines is parsed by
Lex at libqpol/src/policy_scan.l:272-273. However, this information is
only used in the yyerror and yywarn functions, and is not actually
propagated in the policy.

Furthermore, I have searched the SELinux libsepol source files to see
where that information could be saved, and I found that only the avrule
data structure (libsepol/include/sepol/policydb/policydb.h:258) supports
saving origin file/line information in the source_filename(:287) and
source_line(:288) fields.
All other rules, attributes, types etc. do not contain this information.

How could one then parse, save and expose origin file/line information
for all or most policy elements?

Thank you

Filippo Bonazzi


On 10/26/2015 03:16 PM, Christopher J. PeBenito wrote:
> On 10/26/2015 7:20 AM, Elena Reshetova wrote:
>> While looking into the policy parser from setools v4, we noticed one
>> thing that is missing: origin of a policy element. For example, given a
>> certain rule or attribute, it would be great to know in what source file
>> it was defined.
>>
>> In Android you can find this information by looking at produced
>> policy.conf and its comment lines that indicate source file. However I
>> don't know if it is the same for desktop selinux policy.
>>
>> Would it be acceptable to have this information as part of python class
>> representing the parsed policy? It would be really useful for tools like
>> policy linter, because it would be very much needed to point to the
> That would be acceptable.  Past versions of SETools supported that, but
> it has not yet been a priority for v4.
>
