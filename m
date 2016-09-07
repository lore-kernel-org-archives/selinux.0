Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home> <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <994efc50-c8c2-f7b3-41d3-85286114f3d7@tycho.nsa.gov>
Date: Wed, 7 Sep 2016 08:45:16 -0400
MIME-Version: 1.0
In-Reply-To: <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/07/2016 03:15 AM, Dominick Grift wrote:
> On 09/07/2016 06:42 AM, Gary Tierney wrote:
>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>> @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t 
>>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name,
>>>> DEFAULT_LOGIN) == 0) continue;
>>>> 
>>>> -        if (strcmp(name, TEMPLATE_SEUSER) == 0) -
>>>> continue; -
>>> 
>>> This yields a warning/error on Fedora: $ sudo semodule -B 
>>> libsemanage.add_user: user system_u not in password file
>>> 
>> 
>> I can re-add this conditional to prevent outputting the warning,
>> though is there a reason for a login named "system_u" ?
>> 
> 
> Is that warning really useful in the first place though? My
> requirement to create a gdm selinux id also causes these messages
> for user gdm when ever semodule -B is run on systems that do not
> have the gdm user.

Why do you need a gdm selinux id?

> Can we not just print that message only when semodule is run with
> -v instead?

Presently -v only affects output from semodule itself; it isn't
propagated to libsemanage in any way.  And libsemanage logging only
defines three levels presently: error, warning, info.  So we don't
presently have the support for making a libsemanage log message
verbose-only, even if we wanted to do so.
