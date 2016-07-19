Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6JEoASl004927
 for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2016 10:50:10 -0400
Received: by mail-oi0-f45.google.com with SMTP id l65so28721335oib.1
 for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2016 07:50:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5601258B6E@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC56012586EE@ORSMSX103.amr.corp.intel.com>
 <2d10b437-22a0-15f8-d53f-b7c7adbcd4a5@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5601258B6E@ORSMSX103.amr.corp.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jul 2016 10:50:07 -0400
Message-ID: <CAHC9VhR9ismubvEV1jfqVHKrsBDwDSmedyONRGmox5D0dp805g@mail.gmail.com>
Subject: Re: RFC Fuzzing SE Linux interfaces
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Mon, Jul 18, 2016 at 1:07 PM, Roberts, William C
<william.c.roberts@intel.com> wrote:
>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Monday, July 18, 2016 6:21 AM
>> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov
>> Subject: Re: RFC Fuzzing SE Linux interfaces
>>
>> On 07/15/2016 04:18 PM, Roberts, William C wrote:
>> >
>> >
>> > A quick google search didn’t yield much, neither did a grep of the
>> > selinux-testsuite, but is their currently any fuzzing work being done
>> > on the selinux interfaces?
>>
>> Not AFAIK.  There are general system call fuzzers for Linux such trinity and
>> syzkaller; if you want to do full fledged fuzzing, you probably want to use one of
>> those frameworks rather than rolling your own in selinux-testsuite.  On the other
>
> I planned on using one of the frameworks, not sure which yet. I didn't plan on adding
> Any fuzzing tests into selinux-testsuite. However, if I find issues, I'll likely take the malformed
> Input and create a test case on that one, that way we can at least detect regressions on
> Known bad inputs.

Yes, fuzzing doesn't belong in selinux-testsuite; I want to keep that
as a relatively simple testsuite that is reasonably self-contained and
can be run easily and quickly.  Think regression testing.

>> hand, if you just want to write some specific tests of the selinuxfs and
>> /proc/pid/attr interfaces and add them to selinux-testsuite, that's fine too.
>>
>> > Also, I noticed that the test suite has some ToDo’s and I didn’t see
>> > tests surrounding ioctlcmd there, are their some implemented?
>>
>> Not implemented yet, but they are mentioned in the ToDo list:
>> $ grep ioctl ToDo
>> ioctl: Test new ioctl whitelisting feature.
>
> IMHO we should probably not take new features without a tests.

Yes, that is something I'm getting stricter about.

-- 
paul moore
www.paul-moore.com
