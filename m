Message-ID: <55BB827C.5020204@tycho.nsa.gov>
Date: Fri, 31 Jul 2015 10:13:16 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan <dtdevore64@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: Does it matter where .cil modules are build.
References: <55BB0009.4030809@yahoo.com>
In-Reply-To: <55BB0009.4030809@yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/31/2015 12:56 AM, Dan wrote:
> Hello everyone,
>
>       I have been reading up on the cil documentation and am starting to get the
> hang of it and have successfully built my first module. I have a a module called
> test.cil. Now my only question on is where exactly would I put this module to
> build it or does it not matter where you stick them at? I know when you take the
> .pp packages and convert them to .cil  they get stored in
> /var/lib/selinux/targeted/active/modules/400, but I'm just using the secilc
> compiler and nothing else to build policy.
>

If you are using the CIL compiler to build the whole policy, then it doesn't 
matter where the files are located. Just specify all of the files that are part 
of the policy on the command line for secilc.

Do note that the CIL compiler does not build modules, it builds the complete 
policy, so if you are only building a module than it should go into the policy 
store. You should also use the policy store if you want to use the management 
functions of semanage.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
