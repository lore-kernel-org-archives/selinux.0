Subject: Re: sandox -X not working with recent Xephyr
To: Stephen Smalley <sds@tycho.nsa.gov>, Petr Lautrbach <plautrba@redhat.com>
References: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
 <de735099-3871-b9b6-a4cc-8dc67b36e58e@tycho.nsa.gov>
 <20160919180219.tbmq7yx66wkbk3if@rhel-at-redhat.localdomain>
 <c8e7f2ad-72eb-2175-5916-e5054e431e48@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <60ea0154-5a8b-e3c2-3016-2c06a030cda5@debian.org>
Date: Mon, 19 Sep 2016 20:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <c8e7f2ad-72eb-2175-5916-e5054e431e48@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



Le 19/09/16 à 20:26, Stephen Smalley a écrit :
> On 09/19/2016 02:02 PM, Petr Lautrbach wrote:
>> On Mon, Sep 19, 2016 at 10:39:45AM -0400, Stephen Smalley wrote:
>>> On 09/18/2016 02:39 PM, Laurent Bigonville wrote:
>>>> Hi,
>>>>
>>>> It seems that sandbox -X is not working anymore on debian.
>>>>
>>>> Xephyr (1.18.4) is giving me the following error:
>>>>
>>>> _XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be
>>>> created.
>>>>
>>>> The X socket is not created inside the sandbox and then the application
>>>> can obviously not connect to it.
>>>>
>>>> I'm not sure how this could be fixed, maybe let's seunshare create that
>>>> directory?
>>> I don't see this error on Fedora, which also has Xephyr 1.18.4, so maybe
>>> they have a fix?
>>>
>>> That is using the Fedora policycoreutils-sandbox package, which yields a
>>> functioning sandbox -X, e.g. sandbox -X firefox works correctly.
>>>
>>> However, if I install sandbox from upstream, e.g.
>>>
>>> cd selinux
>>> sudo make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
>>>
>>> then sandbox -X firefox fails immediately, and I have the following in
>>> the audit log:
>>> type=SELINUX_ERR msg=audit(1474295659.424:2189):
>>> op=security_bounded_transition seresult=denied
>>> oldcontext=unconfined_u:unconfined_r:sandbox_x_t:s0:c658,c1002
>>> newcontext=unconfined_u:unconfined_r:sandbox_x_client_t:s0:c658,c1002
>> It's most likely not related. Same error can be seen in stock Fedora.
>>
>>> So I guess there are other patches in the Fedora package that are needed?
>> It's this patch
>> https://github.com/fedora-selinux/selinux/commit/2540625875ebdfe0ef48798437288e8a07aa853d
>>
>> But the patch bellow works too:
>>
>> --- a/policycoreutils/sandbox/sandboxX.sh
>> +++ b/policycoreutils/sandbox/sandboxX.sh
>> @@ -20,7 +20,7 @@ cat > ~/.config/openbox/rc.xml << EOF
>>   </openbox_config>
>>   EOF
>>   
>> -(/usr/bin/Xephyr -resizeable -title "$TITLE" -terminate -screen $SCREENSIZE -dpi $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null) | while read D; do
>> +(/usr/bin/Xephyr -resizeable -title "$TITLE" -screen $SCREENSIZE -dpi $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null) | while read D; do
>>       export DISPLAY=:$D
>>       cat > ~/seremote << __EOF
>>   #!/bin/sh
>>
>>
>>
>> I'm not sure which one is correct.
> I don't know either, but the one above does work and seems simpler, so
> let's go with that one.
>
I don't really understand why it's working outside of the sandbox and 
why it was working before.

But indeed removing -terminate or add -reset seems to fix it
