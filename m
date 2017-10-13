Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9DMedMO032338
 for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2017 18:40:39 -0400
Received: by mail-lf0-f67.google.com with SMTP id b190so11142374lfg.9
 for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2017 15:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9b5f9458-ac5f-621b-ff0c-677de365c216@schaufler-ca.com>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
 <1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
 <9b5f9458-ac5f-621b-ff0c-677de365c216@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Oct 2017 18:40:21 -0400
Message-ID: <CAHC9VhREW0Ez7g302J43qdxZwTxk87N-GmT59aUtEUjJu_ynJA@mail.gmail.com>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Fix bool initialization/comparison
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 10, 2017 at 7:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/7/2017 7:02 AM, Thomas Meyer wrote:
>> Bool initializations should use true and false. Bool tests don't need
>> comparisons.
>>
>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>> ---

Hi Thomas,

Thank you for submitting this patch, but it really doesn't add any
value to the SELinux code so I'm not going to merge it at this time.
If you would like to contribute to SELinux there are a number of
issues open on our GitHub page that you could look into resolving,
those patches would be very welcome.

* https://github.com/SELinuxProject

-Paul

>> diff -u -p a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
>> --- a/security/selinux/ss/mls.c
>> +++ b/security/selinux/ss/mls.c
>> @@ -550,7 +550,7 @@ int mls_compute_sid(struct context *scon
>>
>>               /* Fallthrough */
>>       case AVTAB_CHANGE:
>> -             if ((tclass == policydb.process_class) || (sock == true))
>> +             if ((tclass == policydb.process_class) || (sock))
>
> How about
>
>         +       if ((tclass == policydb.process_class) || sock)
>
>>                       /* Use the process MLS attributes. */
>>                       return mls_context_cpy(newcontext, scontext);
>>               else
>> diff -u -p a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -1656,7 +1656,7 @@ static int security_compute_sid(u32 ssid
>>       } else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
>>               newcontext.role = tcontext->role;
>>       } else {
>> -             if ((tclass == policydb.process_class) || (sock == true))
>> +             if ((tclass == policydb.process_class) || (sock))
>
> Excessive ()
>
>>                       newcontext.role = scontext->role;
>>               else
>>                       newcontext.role = OBJECT_R_VAL;
>> @@ -1668,7 +1668,7 @@ static int security_compute_sid(u32 ssid
>>       } else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
>>               newcontext.type = tcontext->type;
>>       } else {
>> -             if ((tclass == policydb.process_class) || (sock == true)) {
>> +             if ((tclass == policydb.process_class) || (sock)) {
>
> Excessive ()
>
>>                       /* Use the type of process. */
>>                       newcontext.type = scontext->type;
>>               } else {
>>
>

-- 
paul moore
www.paul-moore.com
