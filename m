Subject: Re: [PATCH] sandbox: do not run xmodmap in a new X session
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
 <1474472393-2208-1-git-send-email-plautrba@redhat.com>
 <2ad227ec-827a-f1f1-eceb-2290effc3cdf@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <93b64c45-d155-1ff5-3956-bbf9cbd3d405@tycho.nsa.gov>
Date: Wed, 21 Sep 2016 12:35:43 -0400
MIME-Version: 1.0
In-Reply-To: <2ad227ec-827a-f1f1-eceb-2290effc3cdf@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 12:00 PM, Petr Lautrbach wrote:
> On 09/21/2016 05:39 PM, Petr Lautrbach wrote:
>> xmodmap causes Xephyr X server to reset itself when it's run before wm
>> and even right after wm. It causes termination of the server as we use
>> -terminate. The -terminate option seems be important enough in order not
>> to left running the server when the last client connection is closed.
>>
>> This patch drops the execution of xmodmap from .sandboxrc until there's
>> a better solution.
>>
> 
> Note that when I only removed -terminate from Xephyr command line,
> xmodmap didn't modify keymaps anyway.
> 
> And using the Fedora patch with "-terminate -reset" is the same as just
> drop "-terminate" as "-reset" overrides "-terminate" option and -reset
> is used by default.

Thanks for investigating it further.  Applied.

> 
> 
> 
> 
> 
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  policycoreutils/sandbox/sandbox | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
>> index 726ba9b..4ed57c1 100644
>> --- a/policycoreutils/sandbox/sandbox
>> +++ b/policycoreutils/sandbox/sandbox
>> @@ -282,7 +282,7 @@ class Sandbox:
>>                  command += "'%s' " % p
>>              fd.write("""#! /bin/sh
>>  #TITLE: %s
>> -/usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
>> +# /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
>>  %s &
>>  WM_PID=$!
>>  dbus-launch --exit-with-session %s
>>
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
