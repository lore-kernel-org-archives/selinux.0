Message-ID: <533AB9DC.9050300@tycho.nsa.gov>
Date: Tue, 01 Apr 2014 09:06:36 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, =?EUC-KR?B?v8C067y6?= <ds.oh@lge.com>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: Plz ask for help :)
References: <002301cf4cc0$4138b160$c3aa1420$@oh@lge.com>	<533967A3.70201@redhat.com>
 <002901cf4d4b$dfb10500$9f130f00$@oh@lge.com> <533AB41A.7000403@redhat.com>
In-Reply-To: <533AB41A.7000403@redhat.com>
Content-Type: text/plain; charset=EUC-KR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/01/2014 08:42 AM, Daniel J Walsh wrote:
>> But, selinux_complete_init function of security/selinux/hook.c is not
>> called.
>>
>> And if i run ¡°ls -Z¡° command, security context is not printed.
>>
>> $ ls -Z
>>
>> ? apparmor    ? capability.c
>>
>>  
>>
>> selinux_init function is called. but selinux_complete_init function is
>> not called and security context is not printed.
>>
>>  
>>
>> *what should i try ? please help me.*

You need to load a policy into the kernel.   Normally this is done by
the init program.

Was your init program built with SELinux support enabled?  And do you
have a policy file in the expected location?

Look for output from init as well to help debug.
