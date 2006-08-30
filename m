Message-ID: <44F5BA37.2050705@trustedcs.com>
Date: Wed, 30 Aug 2006 11:17:59 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [PATCH 3/3] semantic MLS representation for users
References: <44F31951.1070706@trustedcs.com> <1156881177.8075.18.camel@twoface.columbia.tresys.com>
In-Reply-To: <1156881177.8075.18.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Mon, 2006-08-28 at 11:26 -0500, Darrel Goeddel wrote:
> 
>>Use the semantic representation for user_datums in modular policy formats.
>>
>>All user_datums in a modular format use the semantic representation of the MLS
>>range and dfltlevel.  There is also the possibility of having an expanded
>>version of that data also present in the user_datum.  This is used much like
>>the role cache in the user_datum.  When the user are indexed, the MLS info is
>>expanded.  This info may be used to check the validity of context.  This
>>expansion is not used when writing out a kernel format policy - the expansion
>>is performed again to ensure that the data it is present and in sync with the
>>rest of the policy.
>>
>>Like the range_trans structs, user_datums from older modular formats will have
>>their MLS data converted to the new semantic structs.
>>
>>
>>Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>
>>
> <snip> 
> 
>>diff --exclude=.svn -ruNp selinux-rangetrans/libsepol/src/expand.c selinux-mls-users/libsepol/src/expand.c
>>--- selinux-rangetrans/libsepol/src/expand.c	2006-08-25 07:37:42.000000000 -0500
>>+++ selinux-mls-users/libsepol/src/expand.c	2006-08-25 07:50:48.000000000 -0500
>>@@ -688,13 +688,57 @@ static int user_copy_callback(hashtab_ke
>> 			return -1;
>> 		}
>> 
>>-		/* clone MLS stuff */
>>-		if (mls_range_cpy(&new_user->range, &user->range) == -1
>>-		    || mls_level_cpy(&new_user->dfltlevel,
>>-				     &user->dfltlevel) == -1) {
>>+		/* copy semantic MLS info */
>>+		if (mls_semantic_range_cpy(&new_user->range, &user->range)) {
>> 			ERR(state->handle, "Out of memory!");
>> 			return -1;
>> 		}
>>+		if (mls_semantic_level_cpy(&new_user->dfltlevel,
>>+					   &user->dfltlevel)) {
>>+			ERR(state->handle, "Out of memory!");
>>+			return -1;
>>+		}
>>+
>>+		/* expand the semantic MLS info */
>>+		if (mls_semantic_range_expand(&new_user->range,
>>+					      &new_user->exp_range,
>>+					      state->out, state->handle)) {
>>+			return -1;
>>+		}
>>+		if (mls_semantic_level_expand(&new_user->dfltlevel,
>>+					      &new_user->exp_dfltlevel,
>>+					      state->out, state->handle)) {
>>+			return -1;
>>+		}
>>+		if (!mls_level_between(&new_user->exp_dfltlevel,
>>+				       &new_user->exp_range.level[0],
>>+				       &new_user->exp_range.level[1])) {
>>+			ERR(state->handle, "default level not within user "
>>+			    "range");
>>+			return -1;
> 
> 
> not sure here, we normally outright expand into the new datum in the
> copy_callbacks. Is there a reason you need to keep the semantic copy
> around?

I was trying to keep both representation in sync while I was developing
this code.  Removing the copies of the semantic representation seems
feasible - I'll test.

Is there a problem moving user copying to after level copying if
> that is the issue. 

There should be no problems.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
