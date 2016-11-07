Subject: Re: [PATCH 1/2] Sandbox: Use next() over the sepolicy.info() result
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20161107080117.24030-1-bigon@debian.org>
 <977fa45d-74cd-6a16-e353-7db25edd4b2b@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <e42ee705-7a5f-6ee6-187a-0d2131a85fd0@debian.org>
Date: Tue, 8 Nov 2016 00:09:41 +0100
MIME-Version: 1.0
In-Reply-To: <977fa45d-74cd-6a16-e353-7db25edd4b2b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 07/11/16 à 22:13, Stephen Smalley a écrit :
> On 11/07/2016 03:01 AM, Laurent Bigonville wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> sepolicy.info() now returns a generator, use next() to get the results.
> This breaks sandbox for me,
> $ /usr/bin/sandbox -X firefox
> Traceback (most recent call last):
>    File "/usr/bin/sandbox", line 529, in <module>
>      rc = sandbox.main()
>    File "/usr/bin/sandbox", line 513, in main
>      self.__parse_options()
>    File "/usr/bin/sandbox", line 308, in __parse_options
>      """) % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE,
> "sandbox_type"))['types'])
> TypeError: list object is not an iterator

Which version of python and setools are you using?

>
>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>> ---
>>   policycoreutils/sandbox/sandbox | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
>> index 4010e83..c07a1d8 100644
>> --- a/policycoreutils/sandbox/sandbox
>> +++ b/policycoreutils/sandbox/sandbox
>> @@ -305,8 +305,8 @@ kill -TERM $WM_PID  2> /dev/null
>>               types = _("""
>>   Policy defines the following types for use with the -t:
>>   \t%s
>> -""") % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))[0]['types'])
>> -        except RuntimeError:
>> +""") % "\n\t".join(next(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))['types'])
>> +        except StopIteration:
>>               pass
>>   
>>           usage = _("""
>> @@ -380,8 +380,8 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>>               self.setype = DEFAULT_X_TYPE
>>           else:
>>               try:
>> -                sepolicy.info(sepolicy.TYPE, "sandbox_t")
>> -            except RuntimeError:
>> +                next(sepolicy.info(sepolicy.TYPE, "sandbox_t"))
>> +            except StopIteration:
>>                   raise ValueError(_("Sandbox Policy is not currently installed.\nYou need to install the selinux-policy-sandbox package in order to run this command"))
>>   
>>           if self.__options.setype:
>>
