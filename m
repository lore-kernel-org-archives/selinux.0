Message-ID: <4852C128.30700@tycho.nsa.gov>
Date: Fri, 13 Jun 2008 14:49:12 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Xavier Toth <txtoth@gmail.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH] libselinux: new and updated man pages for AVC,	mapping,
 label
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>	 <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>	 <1213298430.17842.297.camel@moss-spartans.epoch.ncsc.mil>	 <1213300336.17842.309.camel@moss-spartans.epoch.ncsc.mil>	 <48518F23.6080406@tycho.nsa.gov>	 <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil> <1213367226.17842.346.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213367226.17842.346.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

[snip]

> One other question I have is what we should do about the flask.h
> definitions and string tables in libselinux.  We obviously need to
> retain the legacy definitions for old userspace object managers, but we
> also have the old X definitions there and the db definitions.  make
> LIBSELINUX_D=/path/to/libselinux tolib from refpolicy/policy/flask will
> install updated headers and string tables with the latest definitions
> but do we want them all now or just the legacy ones?
>   

I think we need to start removing the userspace classes, starting with 
the DB and X ones.  Even for the legacy object managers, removing the 
definitions won't break any binaries, just the source code compiling.


> I suppose partly that depends on whether we want to use newer object
> managers on older kernels that don't support the dynamic class/perm
> discovery mechanism.  
>   

I would argue no, given that X at least depends a lot on new kernel 
features.


>   
>> As a separate matter, we may want to discuss whether we are getting the
>> flexibility we hoped from this dynamic mapping.  The other day I was
>> adding a new kernel class for experimentation purposes and inserted it
>> before the new X classes, thinking that this would be ok since they can
>> be dynamically looked up and thus don't require fixed indices.  However,
>> when booting the resulting kernel with a stock policy, I found that the
>> kernel refused to load the policy because it saw a conflict between its
>> kernel definition for that class value (the new kernel class) and the
>> policy definition for that class value (the X class).  Which would mean
>> that new kernels on legacy distros would break.
>>     

Well I think the kernel needs to grow its own mapping support then.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
