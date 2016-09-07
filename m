Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
 <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b1501c8b-2258-0ea3-36e9-a4d5acacb7bf@tycho.nsa.gov>
Date: Wed, 7 Sep 2016 09:00:54 -0400
MIME-Version: 1.0
In-Reply-To: <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/07/2016 08:47 AM, Dominick Grift wrote:
> On 09/07/2016 02:36 PM, Stephen Smalley wrote:
>> On 09/07/2016 12:42 AM, Gary Tierney wrote:
>>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley
>>> wrote:
>>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>>> static int seuser_sort_func(const void *arg1, const void 
>>>>> *arg2) @@ -1074,9 +1130,6 @@ static
>>>>> genhomedircon_user_entry_t 
>>>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name, 
>>>>> DEFAULT_LOGIN) == 0) continue;
>>>>> 
>>>>> -        if (strcmp(name, TEMPLATE_SEUSER) == 0) - 
>>>>> continue; -
>>>> 
>>>> This yields a warning/error on Fedora: $ sudo semodule -B 
>>>> libsemanage.add_user: user system_u not in password file
>>>> 
>>> 
>>> I can re-add this conditional to prevent outputting the
>>> warning, though is there a reason for a login named "system_u"
>>> ?
>> 
>> crond used to require one in order to look up the context for
>> system cron jobs; I'm not sure if that is still required, but it
>> is still present in Fedora.
> 
> https://git.fedorahosted.org/cgit/cronie.git/commit/?id=e5280235809844f54d5956ec281472b63dcfc3f4

Ok,
> 
so maybe someone should file a bug on policy to remove system_u
from seusers?  After first testing that it doesn't break anything.
