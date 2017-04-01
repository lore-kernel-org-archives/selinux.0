Subject: Re: selinux: Fix an uninitialized variable bug in range_read()
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20170331152118.GA8141@mwanda>
 <1490975541.31110.12.camel@tycho.nsa.gov>
 <CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <fb1cb81c-4b03-5b21-f933-ea3e58491a13@users.sourceforge.net>
Date: Sat, 1 Apr 2017 08:40:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>>> We removed this initialization as a cleanup but it is probably
>>> required.
>>>
>>> The concern is that "nel" can be zero.  I'm not an expert on SELinux
>>> code but I think it looks possible to write an SELinux policy which
>>> triggers this bug.  GCC doesn't catch this, but my static checker
>>> does.
>>>
>>> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
>>> initialisation in range_read()")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> Nice catch, thanks!
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> Yes, indeed.  Thanks Dan, I should have caught this when merging Markus' patch.

How do you think about the possibility to call the function “range_read” only with
a system configuration where the interface “le32_to_cpu” will be resolved to
a positive value so that statements in the corresponding for loop will be executed
at least once?

Regards,
Markus
