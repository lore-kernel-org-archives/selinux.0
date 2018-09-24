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
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
Date: Mon, 24 Sep 2018 10:53:50 +0900
MIME-Version: 1.0
In-Reply-To: <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2018/09/24 2:09, Casey Schaufler wrote:
>>   Since all free hooks are called when one of init hooks failed, each
>>   free hook needs to check whether init hook was called. An example is
>>   inode_free_security() in security/selinux/hooks.c (but not addressed in
>>   this patch).
> 
> I *think* that selinux_inode_free_security() is safe in this
> case because the blob will be zeroed, hence isec->list will
> be NULL.
> 

OK.

>>   This patchset might fatally prevent LKM-based LSM modules, for LKM-based
>>   LSMs cannot count on lsm_*_alloc() because size for lsm_*_alloc() cannot
>>   be updated upon loading LKM-based LSMs.
> 
> LKM based security modules will require dynamically sized blobs.
> These can be added to the scheme used here. Each blob would get a
> header identifying the modules for which it contains data. When an
> LKM is registered if has to declare it's blob space requirements
> and gets back the offsets. All alloc operations have to put their
> marks in the header. All LKM blob users have to check that the blob
> they are looking at has the required data.
> 
> module_cred(struct cred *cred) {
> 	return cred->security + module_blob_sizes.lbs_cred;
> }
> 
> becomes
> 
> module_cred(struct cred *cred) {
> 	if (blob_includes(module_id))
> 		return cred->security + module_blob_sizes.lbs_cred;
> 	return NULL;
> }
> 
> and the calling code needs to accept a NULL return.

Not all of LKM-based LSMs use security blobs. And some of LKM-based LSMs
might use security blobs for only a few objects. For example, AKARI uses
inode security blob for remembering whether source address/port of an
accept()ed socket was already checked, only during accept() operation and
first socket operation on the accept()ed socket. Thus, there is no need
to waste memory by assigning blobs for all inode objects.

> Blobs can never get smaller because readjusting the offsets
> isn't going to work, so unloading an LKM security module isn't
> going to be as complete as you might like. There may be a way
> around this if you unload all the LKM modules, but that's a
> special case and there may be dragon lurking in the mist.

If LKM-based LSMs who want to use security blobs have to check for
NULL return, they might choose "not using infrastructure managed
security blobs" and "using locally hashed blobs associated with
object's address" (like AKARI does).

> 
>>  If security_file_free() is called
>>   regardless of whether lsm_file_cache is defined, LKM-based LSMs can be
>>   loaded using current behavior (apart from the fact that legitimate
>>   interface for appending to security_hook_heads is currently missing).
>>   How do you plan to handle LKM-based LSMs?
> 
> My position all along has been that I don't plan to handle LKM
> based LSMs, but that I won't do anything to prevent someone else
> from adding them later. I believe that I've done that. Several
> designs, including a separate list for dynamically loaded modules
> have been proposed. I think some of those would work.

Though AKARI is not using security_file_free(), some of LKM-based LSMs
might want to use it. If file_free_security hook is called unconditionally,
such LKM-based LSMs can be registered/unregistered, without worrying about
inability to shrink sizes for blobs.

>> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>>  {
>>  	void *blob;
>>  
>> +	call_void_hook(file_free_security, file);
>> +
>>  	if (!lsm_file_cache)
>>  		return;
>>  
>> -	call_void_hook(file_free_security, file);
>> -
> 
> Why does this make sense? If the lsm_file_cache isn't
> initialized you can't have allocated any file blobs,
> no module can have initialized a file blob, hence there
> can be nothing for the module to do.
> 

For modules (not limited to LKM-based LSMs) which want to use
file blobs for only a few objects and avoid wasting memory by
allocating file blobs to all file objects.

Infrastructure based blob management fits well for LSM modules
which want to assign blobs to all objects (like SELinux). But
forcing infrastructure based blob management can become a huge
waste of memory for LSM modules which want to assign blobs to
only a few objects. Unconditionally calling file_free_security
hook (as with other hooks) preserves a room for allowing the
latter type of LSM modules without using infrastructure based
blob management.
