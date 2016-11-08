Subject: Re: [PATCH 1/2] Sandbox: Use next() over the sepolicy.info() result
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161107080117.24030-1-bigon@debian.org>
 <977fa45d-74cd-6a16-e353-7db25edd4b2b@tycho.nsa.gov>
 <e42ee705-7a5f-6ee6-187a-0d2131a85fd0@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <61ea3329-cf49-bd27-f649-e21fb14a5abb@tycho.nsa.gov>
Date: Tue, 8 Nov 2016 08:34:51 -0500
MIME-Version: 1.0
In-Reply-To: <e42ee705-7a5f-6ee6-187a-0d2131a85fd0@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2016 06:09 PM, Laurent Bigonville wrote:
> Le 07/11/16 à 22:13, Stephen Smalley a écrit :
>> On 11/07/2016 03:01 AM, Laurent Bigonville wrote:
>>> From: Laurent Bigonville <bigon@bigon.be>
>>>
>>> sepolicy.info() now returns a generator, use next() to get the results.
>> This breaks sandbox for me,
>> $ /usr/bin/sandbox -X firefox
>> Traceback (most recent call last):
>>    File "/usr/bin/sandbox", line 529, in <module>
>>      rc = sandbox.main()
>>    File "/usr/bin/sandbox", line 513, in main
>>      self.__parse_options()
>>    File "/usr/bin/sandbox", line 308, in __parse_options
>>      """) % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE,
>> "sandbox_type"))['types'])
>> TypeError: list object is not an iterator
> 
> Which version of python and setools are you using?

I have installed setools4 from source, both running setup.py via python
and via python3 to install it for python 2.7 and python 3.5 (both are
installed on Fedora, with python referencing 2.7 by default).  I have
likewise built and installed the selinux userspace with PYTHON=python
and with PYTHON=python3. I have tried running sandbox via python and via
python3, and it yields the same exception in both cases with your patch,
and works fine without your patch.

>>
>>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>>> ---
>>>   policycoreutils/sandbox/sandbox | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/policycoreutils/sandbox/sandbox
>>> b/policycoreutils/sandbox/sandbox
>>> index 4010e83..c07a1d8 100644
>>> --- a/policycoreutils/sandbox/sandbox
>>> +++ b/policycoreutils/sandbox/sandbox
>>> @@ -305,8 +305,8 @@ kill -TERM $WM_PID  2> /dev/null
>>>               types = _("""
>>>   Policy defines the following types for use with the -t:
>>>   \t%s
>>> -""") % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE,
>>> "sandbox_type"))[0]['types'])
>>> -        except RuntimeError:
>>> +""") % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE,
>>> "sandbox_type"))['types'])
>>> +        except StopIteration:
>>>               pass
>>>             usage = _("""
>>> @@ -380,8 +380,8 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T
>>> tempdir]] [-I includefile ] [-
>>>               self.setype = DEFAULT_X_TYPE
>>>           else:
>>>               try:
>>> -                sepolicy.info(sepolicy.TYPE, "sandbox_t")
>>> -            except RuntimeError:
>>> +                next(sepolicy.info(sepolicy.TYPE, "sandbox_t"))
>>> +            except StopIteration:
>>>                   raise ValueError(_("Sandbox Policy is not currently
>>> installed.\nYou need to install the selinux-policy-sandbox package in
>>> order to run this command"))
>>>             if self.__options.setype:
>>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> 
