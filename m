Subject: Re: [PATCH] quick selinux support for tracefs
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "nnk@google.com" <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
 <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
 <53b7636e-5abe-0712-1954-b8c77c80c10d@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5622FF892E@ORSMSX103.amr.corp.intel.com>
Cc: Yongqin Liu <yongqin.liu@linaro.org>, Paul Moore <paul@paul-moore.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1720815e-90f4-1780-9aaa-1742b05a4efc@tycho.nsa.gov>
Date: Tue, 6 Dec 2016 13:00:56 -0500
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5622FF892E@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/06/2016 12:50 PM, Roberts, William C wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Tuesday, December 6, 2016 9:41 AM
>> To: Roberts, William C <william.c.roberts@intel.com>; nnk@google.com;
>> selinux@tycho.nsa.gov
>> Cc: Yongqin Liu <yongqin.liu@linaro.org>; Paul Moore <paul@paul-moore.com>
>> Subject: Re: [PATCH] quick selinux support for tracefs
>>
>> On 12/06/2016 12:24 PM, william.c.roberts@intel.com wrote:
>>> From: Yongqin Liu <yongqin.liu@linaro.org>
>>>
>>> Here is just the quick fix for tracefs with selinux.
>>> just add tracefs to the list of whitelisted filesystem types in
>>> selinux_is_sblabel_mnt(), but the right fix would be to generalize
>>> this logic as described in the last item on the todo list,
>>> https://bitbucket.org/seandroid/wiki/wiki/ToDo
>>>
>>> Change-Id: I2aa803ccffbcd2802a7287514da7648e6b364157
>>
>> Please rewrite the subject line and patch description per the kernel's submission
>> guidelines, drop the Change-Id and the link to the SEAndroid todo list, and don't
>> say that this is a quick fix but
> 
> Why would anyone do that for this patch when below you say it won’t be merged unless
> we fix issue #2?

I didn't say it couldn't be merged; I said it isn't a good idea to say
"this is a quick fix but the right fix is X" in an upstream patch
submission if you want it to be merged, unless it is for a serious
security or stability bug that needs to be fixed right away.

> 
> the right fix is something else if you want this to
>> actually be merged.  Because in that case, you ought to just implement the right
>> fix.  There is now an upstream kernel issue for the right fix:
>> https://github.com/SELinuxProject/selinux-kernel/issues/2
> 
> The other question here is tracefs safe to label in this fashion, I would assume yes.
> Looking through I didn't see any eviction code.

Yes, the inodes are pinned.
