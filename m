Subject: Re: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
To: Nick Kralevich <nnk@google.com>
References: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
 <CAFJ0LnHpFV2rLZB-145vgTYve4z3hDVBz383=xEDELjJceG7hw@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <09e4d73f-3074-9685-b729-fb9aac72832d@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 10:07:33 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHpFV2rLZB-145vgTYve4z3hDVBz383=xEDELjJceG7hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2016 06:58 PM, Nick Kralevich wrote:
> On Mon, Nov 14, 2016 at 9:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> The combining logic for dontaudit rules was wrong, causing
>> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
>> rule.
>>
>> Reported-by: Nick Kralevich <nnk@google.com>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  libsepol/src/expand.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index 004a029..d7adbf8 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
>>  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>>                                    avtab_t * avtab, avtab_key_t * key,
>>                                    cond_av_list_t ** cond,
>> -                                  av_extended_perms_t *xperms)
>> +                                  av_extended_perms_t *xperms,
>> +                                  char *alloced)
>>  {
>>         avtab_ptr_t node;
> 
> For robustness, it would be safer to ensure that alloced was always
> assigned to. This variable may end up unassigned on certain error
> conditions. It's not a bug today, since the caller always performs a
> check on the return value prior to using this variable, but it could
> be a use of an unassigned variable in a future version of this code.
> 
> Also, "bool" would be a better type for alloced, rather than using a "char"....

Originally did that but it broke - requires a separate patch to rename
the field named "bool" in include/sepol/policydb/conditional.h and all
users.  There was no bool type in C when we first wrote the security
server code (for Flask).
