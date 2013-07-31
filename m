Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6VFjvF0006245
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2013 11:45:57 -0400
Message-ID: <51F93130.6040506@schaufler-ca.com>
Date: Wed, 31 Jul 2013 08:45:52 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v14 5/6] LSM: SO_PEERSEC configuration options
References: <51F16CFB.6040603@schaufler-ca.com> <51F16F37.6040708@schaufler-ca.com> <6712209.BXb1SVfVxH@sifl>
In-Reply-To: <6712209.BXb1SVfVxH@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/30/2013 2:47 PM, Paul Moore wrote:
> On Thursday, July 25, 2013 11:32:23 AM Casey Schaufler wrote:
>> Subject: [PATCH v14 5/6] LSM: SO_PEERSEC configuration options
>>
>> Refine the handling of SO_PEERSEC to enable legacy
>> user space runtimes, Fedora in particular, when running
>> with multiple LSMs that are capable of providing information
>> using getsockopt(). This introduces an additional configuration
>> option, and requires that the default be the legacy behavior.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ...
>
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -157,17 +157,49 @@ config SECMARK_LSM
>>  	help
>>  	  The name of the LSM to use with the networking secmark
>>
>> -config SECURITY_PLAIN_CONTEXT
>> -	bool "Backward compatable contexts without lsm='value' formatting"
>> -	depends on SECURITY_SELINUX || SECURITY_SMACK
>> -	default y
>> +choice
>> +	depends on SECURITY && (SECURITY_SELINUX || SECURITY_SMACK)
>> +	prompt "Peersec LSM"
>> +	default PEERSEC_SECURITY_FIRST
>> +
>>  	help
>> -	  Without this value set security context strings will
>> -	  include the name of the lsm with which they are associated
>> -	  even if there is only one LSM that uses security contexts.
>> -	  This matches the way contexts were handled before it was
>> -	  possible to have multiple concurrent security modules.
>> -	  If you are unsure how to answer this question, answer Y.
>> +	  Select the security module that will send attribute
>> +	  information in IP header options.
>> +	  Most SELinux configurations do not take advantage
>> +	  of Netlabel, while all Smack configurations do. Unless
>> +	  there is a need to do otherwise chose Smack in preference
>> +	  to SELinux.
> I'm not hugely in love with the help text; the first sentence seems to be all 
> that is needed, the second seems unnecessary and not exactly fair to the LSMs.

I can take out the "friendly advice". What it really should say
is more on the lines of:

	If you have gotten to the point where you have to make
	this decision you should probably call it a work day, go
	home, have a nice drink and spend some time with a loved
	one. In the morning take a good hard look at your network
	configuration. You may end up with a different security
	policies being enforced with IPv4 and IPv6 communications.

>
>> +	config PEERSEC_SECURITY_FIRST
>> +		bool "First LSM providing for SO_PEERSEC"
>> +		help
>> +		  Provide the first available LSM's information with SO_PEERSEC
>> +
>> +	config PEERSEC_SECURITY_ALL
>> +		bool "Use lsm='value'lsm='value' format"
>> +		help
>> +		  Provide all available security information in SO_PEERSEC
>> +
>> +	config PEERSEC_SECURITY_SELINUX
>> +		bool "SELinux" if SECURITY_SELINUX=y
>> +		help
>> +		  Provide SELinux context with SO_PEERSEC
>> +
>> +	config PEERSEC_SECURITY_SMACK
>> +		bool "Smack" if SECURITY_SMACK=y
>> +		help
>> +		  Provide Smack labels with SO_PEERSEC
>> +
>> +endchoice
>> +
>> +config PEERSEC_LSM
>> +	string
>> +	default "smack" if PEERSEC_SECURITY_SMACK
>> +	default "selinux" if PEERSEC_SECURITY_SELINUX
>> +	default "(all)" if PEERSEC_SECURITY_ALL
>> +	default "(first)"
>> +	help
>> +	  The name of the LSM to use with Netlabel
>>
>>  config SECURITY_PATH
>>  	bool "Security hooks for pathname based access control"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
