Message-ID: <454649ED.3000304@trustedcs.com>
Date: Mon, 30 Oct 2006 12:52:29 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol users in non-mls policy bugfix
References: <6FE441CD9F0C0C479F2D88F959B01588514786@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514786@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>>On Mon, 2006-10-30 at 08:59 -0500, Joshua Brindle wrote:
>>
>>>This patch fixes a bug where adding a user in a non-mls 
>>
>>module would 
>>
>>>cause a segfault at link time.
>>>
>>>
>>>diff -pruN trunk/libsepol/src/link.c 
>>
>>user_mls_fix/libsepol/src/link.c
>>
>>>--- trunk/libsepol/src/link.c	2006-10-28 
>>
>>15:35:26.000000000 -0400
>>
>>>+++ user_mls_fix/libsepol/src/link.c	2006-10-28 
>>
>>15:26:44.000000000 -0400
>>
>>>@@ -994,11 +994,15 @@ static int user_fix_callback(hashtab_key
>>> 		goto cleanup;
>>> 	}
>>> 
>>>-	if (mls_range_convert(&user->range, &new_user->range, mod))
>>>-		goto cleanup;
>>>+	if (mod->policy->mls) {
>>> 
>>>-	if (mls_level_convert(&user->dfltlevel, 
>>
>>&new_user->dfltlevel, mod))
>>
>>>-		goto cleanup;
>>>+		if (mls_range_convert(&user->range, 
>>
>>&new_user->range, mod))
>>
>>>+			goto cleanup;
>>>+
>>>+		if (mls_level_convert(&user->dfltlevel, 
>>
>>&new_user->dfltlevel, mod))
>>
>>>+			goto cleanup;
>>>+
>>>+	}
>>> 
>>> 	return 0;
>>> 
>>>
>>
>>This patch looks ok, but shouldn't we also stop the segfault 
>>in mls_level_convert? The use of assert there looks like it 
>>is catching what should be a runtime error that should cause 
>>an error message rather than bailing.
>>
>>Otherwise:
> 
> 
> Yea, I tried thinking of a more elegant way to do it and couldn't come
> up with anything, any suggestions?
> 
> Clearly those assertions only apply to the MLS case, and we caught a
> plain bug because of them, I think they are not user errors.

How about just putting the mls check in mls_level_convert (as it is in
mls_semantic_level_expand())?

diff -ruNp --exclude=.svn selinux-base/libsepol/src/link.c selinux/libsepol/src/link.c
--- selinux-base/libsepol/src/link.c	2006-10-30 12:48:21.000000000 -0600
+++ selinux/libsepol/src/link.c	2006-10-30 12:45:08.000000000 -0600
@@ -832,6 +832,9 @@ static int mls_level_convert(mls_semanti
 {
 	mls_semantic_cat_t *src_cat, *new_cat;
 
+	if (!mod->policy->mls)
+		return 0;
+
 	assert(mod->map[SYM_LEVELS][src->sens - 1]);
 	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
 

That will catch all callers of the mls conversion functions in the linker.  The
asserts will then only apply in the MLS case as they should be.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
