Message-ID: <42F7B37E.50103@tresys.com>
Date: Mon, 08 Aug 2005 15:33:18 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Daniel J Walsh <Dan-Walsh@comcast.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Category Translation patch for MCS/MLS Policy
References: <20050808174331.70367.qmail@web34312.mail.mud.yahoo.com>
In-Reply-To: <20050808174331.70367.qmail@web34312.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:

>--- Daniel J Walsh <Dan-Walsh@comcast.net> wrote:
>
>
>  
>
>>Comments?
>>    
>>
>
>In the Unix MLS systems we found that
>allowing whitespace in label names was
>a bad idea.
>
i thought that was a bad idea too.

> We also found that aliases
>(e.g. TS for TopSecret, secret for Secret)
>are absolutely necessary. I will not
>participate in the case sensitive/insensitive
>debate, but y'all should have it over
>with. Then there's my favorite issue,
>that of whether a user cleared only to
>Secret can see the lable names for TopSecret.
>
>  
>
My impression was that the caching daemon (assuming we have one) or else 
the resolver would act as an userspace object manager to prevent labels 
from inappropriatly being disclosed.

>You may not chose to address all of these
>issues, but you should be ready to
>explain why they don't matter as you will
>be asked.
>
>  
>
I think most of us have at least been thinking about them.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
