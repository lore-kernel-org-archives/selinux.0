To: Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
 <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eb1525f6-a3f8-4386-778f-8758c42326e5@i-love.sakura.ne.jp>
Date: Tue, 25 Sep 2018 02:53:12 +0900
MIME-Version: 1.0
In-Reply-To: <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2018/09/25 2:16, Casey Schaufler wrote:
>> Not all of LKM-based LSMs use security blobs. And some of LKM-based LSMs
>> might use security blobs for only a few objects. For example, AKARI uses
>> inode security blob for remembering whether source address/port of an
>> accept()ed socket was already checked, only during accept() operation and
>> first socket operation on the accept()ed socket. Thus, there is no need
>> to waste memory by assigning blobs for all inode objects.
> 
> The first question is why use an inode blob? Shouldn't you
> be using a socket blob for this socket based information?

Indeed. AKARI can as well use security_sk_free() using address of
"struct sock" as a key.

> 
> If you only want information part of the time you can declare
> a pointer sized blob and manage what hangs off that as you will.
> I personally think that the added complexity of conditional
> blob management is more pain than it's worth, but if you want
> a really big blob, but only on occasion, I could see doing it.

LKM based LSMs are too late for updating blob_sizes.* fields.
Even if they could, they after all have to somehow check whether
corresponding init hook was called. That's checking for NULL.

>>
>>>> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>>>>  {
>>>>  	void *blob;
>>>>  
>>>> +	call_void_hook(file_free_security, file);
>>>> +
>>>>  	if (!lsm_file_cache)
>>>>  		return;
>>>>  
>>>> -	call_void_hook(file_free_security, file);
>>>> -
>>> Why does this make sense? If the lsm_file_cache isn't
>>> initialized you can't have allocated any file blobs,
>>> no module can have initialized a file blob, hence there
>>> can be nothing for the module to do.
>>>
>> For modules (not limited to LKM-based LSMs) which want to use
>> file blobs for only a few objects and avoid wasting memory by
>> allocating file blobs to all file objects.
>>
>> Infrastructure based blob management fits well for LSM modules
>> which want to assign blobs to all objects (like SELinux). But
>> forcing infrastructure based blob management can become a huge
>> waste of memory for LSM modules which want to assign blobs to
>> only a few objects. Unconditionally calling file_free_security
>> hook (as with other hooks) preserves a room for allowing the
>> latter type of LSM modules without using infrastructure based
>> blob management.
> 
> There is a hypothetical issue here, but that would require abuse
> of the infrastructure. Having a file_free_security hook that doesn't
> free a security blob allocated by file_alloc_security may coincidentaly
> be useful, but that's not the intent of the hook.
> 

The free hook might be used for freeing resources which were not allocated
by alloc hook. Yama is using task_free hook without task_alloc hook.
Someone might want to use file_free hook without file_alloc hook.
