To: Petr Lautrbach <plautrba@redhat.com>, Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
References: <152641822270.15123.8804483748550258349.stgit@chester>
 <20180516073101.GC17168@pl-rpi.tpb.lab.eng.brq.redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <78525914-8d00-38e3-d4d9-1fc8102a9edc@tycho.nsa.gov>
Date: Wed, 16 May 2018 08:48:41 -0400
MIME-Version: 1.0
In-Reply-To: <20180516073101.GC17168@pl-rpi.tpb.lab.eng.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re:  Re: [RFC PATCH] selinux-testsuite: check the
 "expand-check" setting in semanage.conf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/2018 03:31 AM, Petr Lautrbach wrote:
> On Tue, May 15, 2018 at 05:03:42PM -0400, Paul Moore wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> If expand-check is non-zero in semanage.conf the policy load will likely fail,
>> try to provide a more helpful error to users running the tests.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  policy/Makefile |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/policy/Makefile b/policy/Makefile
>> index 8ed5e46..cc022e3 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -87,6 +87,14 @@ build: $(BUILD_TARGET)
>>  load: $(LOAD_TARGET)
>>  unload: $(UNLOAD_TARGET)
>>  
>> +expand_check:
>> +	# Test for "expand-check = 0" in /etc/selinux/semanage.conf
>> +	@cat /etc/selinux/semanage.conf | \
>> +		sed -n 's/^[ \t]*expand-check[ \t]*=[ \t]*0/OK/p' | \
>> +		grep -q "OK" || \
>> +		(echo "ERROR: set 'expand-check = 0' in semanage.conf"; \
>> +		 /bin/false)
>> +
> 
> You can use grep directly:
> 
> + grep -q '^[ \t]*expand-check[ \t]*=[ \t]*0' /etc/selinux/semanage.conf || \
> +      (echo "ERROR: set 'expand-check = 0' in semanage.conf";
> +      /bin/false)

And you should probably put the full path for the file in the error message.

> 
>>  build_rhel: $(TARGETS)
>>  	# RHEL specific policy build
>>  	$(MAKE) -C redhat/$(RHEL_VERS) all
>> @@ -103,11 +111,11 @@ build_general: $(TARGETS)
>>  		echo "ERROR: You must have selinux-policy-devel installed."; \
>>  	fi
>>  
>> -load_rhel: all
>> +load_rhel: expand_check all
>>  	# RHEL specific policy load
>>  	$(MAKE) -C redhat/$(RHEL_VERS) load
>>  
>> -load_general: all
>> +load_general: expand_check all
>>  	# General policy load
>>  	@-/usr/sbin/setsebool allow_domain_fd_use=0
>>  	$(SEMODULE) -i test_policy/test_policy.pp
>>
>>
