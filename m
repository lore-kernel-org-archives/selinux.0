Subject: Re: [PATCH 1/2] Sandbox: Use next() over the sepolicy.info() result
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20161107080117.24030-1-bigon@debian.org>
 <977fa45d-74cd-6a16-e353-7db25edd4b2b@tycho.nsa.gov>
 <e42ee705-7a5f-6ee6-187a-0d2131a85fd0@debian.org>
 <61ea3329-cf49-bd27-f649-e21fb14a5abb@tycho.nsa.gov>
 <6af95926-d78f-7cba-40d9-d15c8e495f38@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <853a01d9-e746-f5f4-5509-77d0e1747aa0@debian.org>
Date: Tue, 8 Nov 2016 15:58:16 +0100
MIME-Version: 1.0
In-Reply-To: <6af95926-d78f-7cba-40d9-d15c8e495f38@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 08/11/16 à 15:57, Stephen Smalley a écrit :
> On 11/08/2016 08:34 AM, Stephen Smalley wrote:
>> On 11/07/2016 06:09 PM, Laurent Bigonville wrote:
>>> Le 07/11/16 à 22:13, Stephen Smalley a écrit :
>>>> On 11/07/2016 03:01 AM, Laurent Bigonville wrote:
>>>>> From: Laurent Bigonville <bigon@bigon.be>
>>>>>
>>>>> sepolicy.info() now returns a generator, use next() to get the results.
>>>> This breaks sandbox for me,
>>>> $ /usr/bin/sandbox -X firefox
>>>> Traceback (most recent call last):
>>>>     File "/usr/bin/sandbox", line 529, in <module>
>>>>       rc = sandbox.main()
>>>>     File "/usr/bin/sandbox", line 513, in main
>>>>       self.__parse_options()
>>>>     File "/usr/bin/sandbox", line 308, in __parse_options
>>>>       """) % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE,
>>>> "sandbox_type"))['types'])
>>>> TypeError: list object is not an iterator
>>> Which version of python and setools are you using?
>> I have installed setools4 from source, both running setup.py via python
>> and via python3 to install it for python 2.7 and python 3.5 (both are
>> installed on Fedora, with python referencing 2.7 by default).  I have
>> likewise built and installed the selinux userspace with PYTHON=python
>> and with PYTHON=python3. I have tried running sandbox via python and via
>> python3, and it yields the same exception in both cases with your patch,
>> and works fine without your patch.
> Ok, I forcibly removed the Fedora setools* packages (which also
> uninstalled policycoreutils) and built and installed setools4 and
> policycoreutils from upstream source again.  Now I do not get that
> exception with your patch, but it also works fine without your patch - I
> see no difference in behavior.  Not sure what I am missing.

If I don't have the sandbox policy installed I get a backtrace instead 
of a nice error:

Traceback (most recent call last):
   File "sandbox", line 529, in <module>
     rc = sandbox.main()
   File "sandbox", line 513, in main
     self.__parse_options()
   File "sandbox", line 308, in __parse_options
     """) % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))[0]['types'])
IndexError: list index out of range
