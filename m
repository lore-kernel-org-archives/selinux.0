Message-ID: <4550E14E.2030703@us.ibm.com>
Date: Tue, 07 Nov 2006 13:41:02 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 2/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com> <454A9566.1000304@us.ibm.com> <20061107045404.GA11273@sergelap.austin.ibm.com>
In-Reply-To: <20061107045404.GA11273@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Michael C Thompson (thompsmc@us.ibm.com):
>> +	setpwent();
>> +	pw = getpwuid(uid);
>> +	endpwent();
> 
> Why the set/endpwent() calls?  The original code didn't have them,
> and you aren't useing getpwent() so they don't seem to do anything.

Good point, I'm sure I had some (flawed) reason for doing it, but it 
doesn't seem to have made sense. I'll remove these extra calls.

>> +	if (!(pw && pw->pw_name && pw->pw_name[0] && pw->pw_shell
>> +	      && pw->pw_shell[0] && pw->pw_dir && pw->pw_dir[0])) {
>> +		fprintf(stderr,
>> +			_("cannot find valid entry in the passwd file.\n"));
>> +		return -1;
>> +	}
>> +
>> +	*pw_copy = *pw;
>> +	pw = pw_copy;
>> +	pw->pw_name = strdup(pw->pw_name);
> 
> You switched from xstrdup to strdup - don't know whether that means
> anything...

Yes, I did this because of a misunderstanding I had with the naming 
scheme of xstrdup, which is supposed to suceeded or exit. However, since 
I've changed the code to do better cleanup on errors, I've changed the 
calls to strdup and then do checks to ensure it succeeded.

>> +	pw->pw_dir = strdup(pw->pw_dir);
>> +	pw->pw_shell = strdup(pw->pw_shell);
> 
> -serge



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
