Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
To: Paul Moore <paul@paul-moore.com>, Jan Stancek <jstancek@redhat.com>
References: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
 <563A5AAB.5000802@tycho.nsa.gov>
 <CAHC9VhTihxGX=7MPRxP+CQiOeXTqd7BGnhf+XJ10Fx4OwOiLZg@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <563A6F51.8090109@tycho.nsa.gov>
Date: Wed, 4 Nov 2015 15:49:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTihxGX=7MPRxP+CQiOeXTqd7BGnhf+XJ10Fx4OwOiLZg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/04/2015 03:32 PM, Paul Moore wrote:
> On Wed, Nov 4, 2015 at 2:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> selinux-testsuite exercises the individual kernel permission checks using
>> its own privately defined test domains and types, so a failure indicates a
>> kernel bug or a bug in the test policy or test code, not a bug in the
>> distribution policy package.  It could be that a change in the distribution
>> policy has a side effect (e.g. allowing some permission to all domains that
>> we are trying to test such that we cannot trigger a failure, as in this
>> case), but the testsuite tries to work around such cases by setting any
>> necessary global booleans for the test duration and/or custom defining the
>> test domain in such a way that it does not inherit anything from the
>> distribution policy.
>>
>> The exec* checks can be disabled on certain architectures if they default to
>> executable data but that would affect more than just execmod (and s390 does
>> not default to executable data).
>>
>> Can you check that execmod permission is NOT granted to test_no_execmod_t:
>> $ sesearch -AC -s test_no_execmod_t -p execmod
>>
>> Can you confirm that the test program is not marked with executable stack
>> flag:
>> $ execstack -q tests/mmap/mprotect_file_private_execmod
>>
>> Otherwise, I think you need some kernel instrumentation / tracing to see
>> what is happening, particularly the selinux_file_mprotect() function.
>
> I have been working with Jan on this and it appears that the issue is
> due to the READ_IMPLIES_EXEC personality being set on the affected
> s390x kernels.

Hmmm...doesn't explain why only execmod failed - that should create 
failures for multiple tests.
