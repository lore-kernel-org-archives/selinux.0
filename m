Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u87CXe8c022254
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 08:33:40 -0400
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
Date: Wed, 7 Sep 2016 08:36:09 -0400
MIME-Version: 1.0
In-Reply-To: <20160907044233.GA3000@home>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/07/2016 12:42 AM, Gary Tierney wrote:
> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>> static int seuser_sort_func(const void *arg1, const void
>>> *arg2) @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t 
>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name,
>>> DEFAULT_LOGIN) == 0) continue;
>>> 
>>> -        if (strcmp(name, TEMPLATE_SEUSER) == 0) -
>>> continue; -
>> 
>> This yields a warning/error on Fedora: $ sudo semodule -B 
>> libsemanage.add_user: user system_u not in password file
>> 
> 
> I can re-add this conditional to prevent outputting the warning,
> though is there a reason for a login named "system_u" ?

crond used to require one in order to look up the context for system
cron jobs; I'm not sure if that is still required, but it is still
present in Fedora.
