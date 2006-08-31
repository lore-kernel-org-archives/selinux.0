Subject: Re: [PATCH 3/3] semantic MLS representation for users
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <44F5F81B.8060301@trustedcs.com>
References: <44F31951.1070706@trustedcs.com>
	 <1156881177.8075.18.camel@twoface.columbia.tresys.com>
	 <44F5BA37.2050705@trustedcs.com>  <44F5F81B.8060301@trustedcs.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 15:22:29 -0400
Message-Id: <1157052149.24429.128.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-30 at 15:42 -0500, Darrel Goeddel wrote:
> Darrel Goeddel wrote:
> > Joshua Brindle wrote:
> > 
> >> On Mon, 2006-08-28 at 11:26 -0500, Darrel Goeddel wrote:
> >>
> >>> Use the semantic representation for user_datums in modular policy 
> >>> formats.
> >>>
> >>> All user_datums in a modular format use the semantic representation 
> >>> of the MLS
> >>> range and dfltlevel.  There is also the possibility of having an 
> >>> expanded
> >>> version of that data also present in the user_datum.  This is used 
> >>> much like
> >>> the role cache in the user_datum.  When the user are indexed, the MLS 
> >>> info is
> >>> expanded.  This info may be used to check the validity of context.  This
> >>> expansion is not used when writing out a kernel format policy - the 
> >>> expansion
> >>> is performed again to ensure that the data it is present and in sync 
> >>> with the
> >>> rest of the policy.
> >>>
> >>> Like the range_trans structs, user_datums from older modular formats 
> >>> will have
> >>> their MLS data converted to the new semantic structs.
> >>>
> >>>
> >>> Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>
> >>>
> >> <snip>
> >>
> >>> diff --exclude=.svn -ruNp selinux-rangetrans/libsepol/src/expand.c 
> >>> selinux-mls-users/libsepol/src/expand.c
> >>> --- selinux-rangetrans/libsepol/src/expand.c    2006-08-25 
> >>> 07:37:42.000000000 -0500
> >>> +++ selinux-mls-users/libsepol/src/expand.c    2006-08-25 
> >>> 07:50:48.000000000 -0500
> >>> @@ -688,13 +688,57 @@ static int user_copy_callback(hashtab_ke
> >>>             return -1;
> >>>         }
> >>>
> >>> -        /* clone MLS stuff */
> >>> -        if (mls_range_cpy(&new_user->range, &user->range) == -1
> >>> -            || mls_level_cpy(&new_user->dfltlevel,
> >>> -                     &user->dfltlevel) == -1) {
> >>> +        /* copy semantic MLS info */
> >>> +        if (mls_semantic_range_cpy(&new_user->range, &user->range)) {
> >>>             ERR(state->handle, "Out of memory!");
> >>>             return -1;
> >>>         }
> >>> +        if (mls_semantic_level_cpy(&new_user->dfltlevel,
> >>> +                       &user->dfltlevel)) {
> >>> +            ERR(state->handle, "Out of memory!");
> >>> +            return -1;
> >>> +        }
> >>> +
> >>> +        /* expand the semantic MLS info */
> >>> +        if (mls_semantic_range_expand(&new_user->range,
> >>> +                          &new_user->exp_range,
> >>> +                          state->out, state->handle)) {
> >>> +            return -1;
> >>> +        }
> >>> +        if (mls_semantic_level_expand(&new_user->dfltlevel,
> >>> +                          &new_user->exp_dfltlevel,
> >>> +                          state->out, state->handle)) {
> >>> +            return -1;
> >>> +        }
> >>> +        if (!mls_level_between(&new_user->exp_dfltlevel,
> >>> +                       &new_user->exp_range.level[0],
> >>> +                       &new_user->exp_range.level[1])) {
> >>> +            ERR(state->handle, "default level not within user "
> >>> +                "range");
> >>> +            return -1;
> >>
> >>
> >>
> >> not sure here, we normally outright expand into the new datum in the
> >> copy_callbacks. Is there a reason you need to keep the semantic copy
> >> around?
> > 
> > 
> > I was trying to keep both representation in sync while I was developing
> > this code.  Removing the copies of the semantic representation seems
> > feasible - I'll test.
> > 
> > Is there a problem moving user copying to after level copying if
> > 
> >> that is the issue. 
> > 
> > 
> > There should be no problems.
> 
> So... there can be problems.  Re-indexing will cause a re-expansion of the
> user's MLS fields.  This is similar to the caching of roles using the currently
> available information.  If we do not copy the semantic versions over, a
> re-indexing of a kernel policy will wipe out all MLS info for users - not good.
> 
> We could:
> - just leave it in there and allow re-indexing to work as-is
> - get fancy and put in a flag to keep track of which representation is valid
> - only expand the MLS info during a policydb_user_cache call if we are not
>   dealing with a kernel policy
> 
> The first option is easiest ;)  The third option also seems reasonable to me.
> That would basically say that kernel policies rely on the expanded MLS, while
> other policies rely on the semantic MLS.

I agree, the third option should be how we handle everything else .
> 
> In a related note, what type of policies can be used with functions like
> sepol_user_*() and sepol_context_isvalid().  With the current patch, those
> functions assume that the expanded MLS is there, so they expect a kernel
> policy or modular policy that has been expanded (or at least has the user
> MLS fields expanded through indexing).
> 

the _isvalid function should only work after users and roles have their
cache filled up which should be the same for mls.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
