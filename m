Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8826wpT010252
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2011 22:06:59 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8826vJw022645
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 02:06:57 GMT
Message-ID: <4E682307.8090004@windriver.com>
Date: Thu, 8 Sep 2011 10:05:59 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [v2 PATCH 6/8] Skip tunable identifier and cond_node_t in expansion.
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>	<1314847787-4055-7-git-send-email-qingtao.cao@windriver.com> <CACLa4pvaMt+ty-A4KRq=neYQOeH5J2P9U_GLVLUzjcSrJ_i4yg@mail.gmail.com>
In-Reply-To: <CACLa4pvaMt+ty-A4KRq=neYQOeH5J2P9U_GLVLUzjcSrJ_i4yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Eric for pointing this out!　I would certainly fix the whitespace
errors in v3 patchset if that is desirable.

Thanks,
Harry

Eric Paris 写道:
> This patch contained a whitespace error.  I have fixed it when
> applying to my queue branch.  Please fix before resending if there is
> a need for a v3.
>
> -Eric
>
> On Wed, Aug 31, 2011 at 11:29 PM, Harry Ciao <qingtao.cao@windriver.com> wrote:
>   
>> The effective branch of a tunable has been appended to its home
>> decl->avrules list during link, in expansion we should just skip tunables
>> from expanding their rules into te_cond_avtab hashtab and adding to the
>> out->cond_list queue.
>>
>> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
>> ---
>>  libsepol/src/expand.c |   13 +++++++++++++
>>  1 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index be41243..d5f10a6 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -1014,6 +1014,11 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>>                return 0;
>>        }
>>
>> +       if (bool->flags & COND_BOOL_FLAGS_TUNABLE) {
>> +               /* Skip tunables */
>> +               return 0;
>> +       }
>> +
>>        if (state->verbose)
>>                INFO(state->handle, "copying boolean %s", id);
>>
>> @@ -1046,6 +1051,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>>        state->boolmap[bool->s.value - 1] = new_bool->s.value;
>>
>>        new_bool->state = bool->state;
>> +       new_bool->flags = bool->flags;
>>
>>        return 0;
>>  }
>> @@ -1940,6 +1946,13 @@ static int cond_node_copy(expand_state_t * state, cond_node_t * cn)
>>        if (cond_node_copy(state, cn->next)) {
>>                return -1;
>>        }
>> +
>> +       /* If current cond_node_t is of tunable, its effective branch
>> +        * has been appended to its home decl->avrules list during link
>> +        * and now we should just skip it. */
>> +       if (cn->flags & COND_NODE_FLAGS_TUNABLE)
>> +               return 0;
>> +
>>        if (cond_normalize_expr(state->base, cn)) {
>>                ERR(state->handle, "Error while normalizing conditional");
>>                return -1;
>> --
>> 1.7.0.4
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>>     
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
