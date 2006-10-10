Message-ID: <452C1449.3040207@us.ibm.com>
Date: Tue, 10 Oct 2006 16:44:41 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/4] make newrole suid
References: <4526D531.1090409@us.ibm.com>	 <1160512048.3322.54.camel@moss-spartans.epoch.ncsc.mil> <1160512579.3322.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160512579.3322.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-10-10 at 16:27 -0400, Stephen Smalley wrote:
>> On Fri, 2006-10-06 at 17:14 -0500, Michael C Thompson wrote:
>> +		fprintf(stderr,
>> +			_("cannot find valid entry in the passwd file.\n"));
>> +		return -1;
>> +	}
>> +
>> +	*pw_copy = *pw;
>> +	pw = pw_copy;
>> +	pw->pw_name = xstrdup(pw->pw_name);
>> +	pw->pw_dir = xstrdup(pw->pw_dir);
>> +	pw->pw_shell = xstrdup(pw->pw_shell);
>> +
>> +	if (! (pw->pw_name && pw->pw_dir && pw->pw_shell))
>> +		goto out_free;
>>
>> xstrdup by definition exits on OOM errors, so you don't have to re-test
>> here, or alternatively you don't need to use xstrdup in the first place
>> (vs. just plain strdup).
> 
> Ok, I see that in patch 3, you drop the exit call from xstrdup.  Which I
> think is a mistake - xmalloc/xstrdup-style functions typically mean
> "succeed or exit".

Right, I can see that now. I'll admit ignorance: I wasn't aware that was 
what the x prefix meant - I've never used that naming style before. I 
would rather not exit mid-code, so I'll change the use to be strdup and 
perform the checks.

Thanks,
Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
