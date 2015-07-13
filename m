Message-ID: <55A3E53E.9010507@tycho.nsa.gov>
Date: Mon, 13 Jul 2015 12:20:14 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux: do not remap unknown SIDs to the unlabeled
 context
References: <1433855392-17188-1-git-send-email-sds@tycho.nsa.gov>
 <2812439.sEMCQPxe3C@sifl>
In-Reply-To: <2812439.sEMCQPxe3C@sifl>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/11/2015 10:24 AM, Paul Moore wrote:
> On Tuesday, June 09, 2015 09:09:52 AM Stephen Smalley wrote:
>> SELinux remaps invalid SIDs to the unlabeled SID/context in order
>> to provide sane handling of objects whose SIDs become invalid upon
>> a policy reload (e.g. removal of a type from policy).  However,
>> this can also hide bugs and yield unexpected behavior, e.g. as described
>> in https://bugzilla.redhat.com/show_bug.cgi?id=1224211, if a program
>> sets SO_PASSSEC on a Unix stream socket, it will receive a SCM_SECURITY
>> control message with the unlabeled context because the secid is not
>> properly set/propagated for Unix stream sends, only for Unix datagram
>> sends, but the automatic remapping of any invalid SID to the unlabeled
>> context still produces a context to be returned when SO_PASSSEC is
>> set on the socket.  Since commit 12b29f34558b9b45a2c6eabd4f3c6be939a3980f
>> ("selinux: support deferred mapping of contexts") changed SELinux to not
>> remove invalid SIDs from the SID table but rather to retain them with a
>> copy of the unmapped context string so that the SID could be made valid
>> again if a subsequent policy reload made the context valid again, we no
>> longer need to map unknown SIDs to the unlabeled context, only SIDs that
>> have unmapped context strings.
>>
>> With this change applied, we get saner behavior for SCM_SECURITY on
>> Unix stream sockets:  the kernel will not put any SCM_SECURITY control
>> message at all rather than putting one with an unlabeled context.  If
>> we want to support SCM_SECURITY on Unix stream sockets, that can be
>> taken up as a separate change.  Regardless, this change will help catch
>> cases where a secid/SID is never set (0) or contain a value beyond the
>> set of allocated SIDs (e.g. never initialized and contains garbage).  The
>> change does not break the support for deferred mapping of contexts; one
>> can still insert a policy module that defines a type, label a file with
>> that type, remove the policy module (i.e. load a policy that does not
>> contain the type), check that the file's label is remapped to the
>> unlabeled context, re-insert the policy module that defined the type,
>> and see that the file's label is properly restored and valid.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  security/selinux/ss/sidtab.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This looks good to me thank for sending this patch.
> 
> Since SO_PASSSEC isn't widely used and/or documented I don't think there is 
> any rush to push this for v4.2 since we've already done two pull requests for 
> v4.2.  I'm also a little leery of changing such core behavior with little to 
> no time in linux-next (although I will admit to being skeptical of the testing 
> value of linux-next).  Unless someone can provide a very compelling reason why 
> this needs to go into v4.2 I'm going to queue this up in my next-queue branch 
> and apply it after the merge window is closed.

Please revert or drop this patch from your next branch.
When running the selinux-testsuite inet_socket tests, we get a number of
errors from SELinux as a result of this change and network packets are
dropped as a result.  Apparently the SELinux networking hooks are
relying on SID 0 being treated the same as the unlabeled context.

> 
>> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
>> index 5840a35..3bd992c 100644
>> --- a/security/selinux/ss/sidtab.c
>> +++ b/security/selinux/ss/sidtab.c
>> @@ -98,7 +98,10 @@ static struct context *sidtab_search_core(struct sidtab
>> *s, u32 sid, int force) if (force && cur && sid == cur->sid &&
>> cur->context.len)
>>  		return &cur->context;
>>
>> -	if (cur == NULL || sid != cur->sid || cur->context.len) {
>> +	if (cur == NULL || sid != cur->sid)
>> +		return NULL;
>> +
>> +	if (cur->context.len) {
>>  		/* Remap invalid SIDs to the unlabeled SID. */
>>  		sid = SECINITSID_UNLABELED;
>>  		hvalue = SIDTAB_HASH(sid);
> 
