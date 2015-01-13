Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0DMjCRw017790
 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2015 17:45:13 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so19609498igd.2
 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2015 14:45:11 -0800 (PST)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com.
 [209.85.223.173])
 by mx.google.com with ESMTPSA id l42sm4270535iod.6.2015.01.13.14.45.09
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 13 Jan 2015 14:45:09 -0800 (PST)
Received: by mail-ie0-f173.google.com with SMTP id y20so5690186ier.4
 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2015 14:45:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1737170.75ul4v7eON@sifl>
References: <1421016270-25547-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1737170.75ul4v7eON@sifl>
Date: Tue, 13 Jan 2015 23:45:09 +0100
Message-ID: <CAKXHbyP5nay1XBCk7tkH_o2==Vu16aWQOG949T-xoffXse7Fsw@mail.gmail.com>
Subject: Re: [PATCH] selinux: ss: mls: Remove unused function
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: James Morris <james.l.morris@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Dave Jones <davej@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2015-01-12 21:29 GMT+01:00 Paul Moore <paul@paul-moore.com>:
> On Sunday, January 11, 2015 11:44:30 PM Rickard Strandqvist wrote:
>> Remove the function mls_import_netlbl_cat() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called
>> cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  security/selinux/ss/mls.c |   38 --------------------------------------
>>  security/selinux/ss/mls.h |    7 -------
>>  2 files changed, 45 deletions(-)
>
> Thanks for bringing this up and sending a patch.
>
> However, what we should probably do is take the existing MLS category code in
> security_netlbl_secattr_to_sid() and reconcile it with the code in
> mls_import_netlbl_cat() and convert security_netlbl_secattr_to_sid() to using
> the mls_import_netlbl_cat() function.
>
> Is that something you want to try?  If not, let me know and we'll work on it.
>
>> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
>> index d307b37..c01c755 100644
>> --- a/security/selinux/ss/mls.c
>> +++ b/security/selinux/ss/mls.c
>> @@ -631,42 +631,4 @@ int mls_export_netlbl_cat(struct context *context,
>>
>>       return rc;
>>  }
>> -
>> -/**
>> - * mls_import_netlbl_cat - Import the MLS categories from NetLabel
>> - * @context: the security context
>> - * @secattr: the NetLabel security attributes
>> - *
>> - * Description:
>> - * Copy the NetLabel security attributes into the SELinux context; since
>> the - * NetLabel security attribute only contains a single MLS category use
>> it for - * both the low and high categories of the context.  Returns zero
>> on success, - * negative values on failure.
>> - *
>> - */
>> -int mls_import_netlbl_cat(struct context *context,
>> -                       struct netlbl_lsm_secattr *secattr)
>> -{
>> -     int rc;
>> -
>> -     if (!policydb.mls_enabled)
>> -             return 0;
>> -
>> -     rc = ebitmap_netlbl_import(&context->range.level[0].cat,
>> -                                secattr->attr.mls.cat);
>> -     if (rc != 0)
>> -             goto import_netlbl_cat_failure;
>> -
>> -     rc = ebitmap_cpy(&context->range.level[1].cat,
>> -                      &context->range.level[0].cat);
>> -     if (rc != 0)
>> -             goto import_netlbl_cat_failure;
>> -
>> -     return 0;
>> -
>> -import_netlbl_cat_failure:
>> -     ebitmap_destroy(&context->range.level[0].cat);
>> -     ebitmap_destroy(&context->range.level[1].cat);
>> -     return rc;
>> -}
>>  #endif /* CONFIG_NETLABEL */
>> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
>> index e4369e3..11d3c8f 100644
>> --- a/security/selinux/ss/mls.h
>> +++ b/security/selinux/ss/mls.h
>> @@ -62,8 +62,6 @@ void mls_import_netlbl_lvl(struct context *context,
>>                          struct netlbl_lsm_secattr *secattr);
>>  int mls_export_netlbl_cat(struct context *context,
>>                         struct netlbl_lsm_secattr *secattr);
>> -int mls_import_netlbl_cat(struct context *context,
>> -                       struct netlbl_lsm_secattr *secattr);
>>  #else
>>  static inline void mls_export_netlbl_lvl(struct context *context,
>>                                        struct netlbl_lsm_secattr *secattr)
>> @@ -80,11 +78,6 @@ static inline int mls_export_netlbl_cat(struct context
>> *context, {
>>       return -ENOMEM;
>>  }
>> -static inline int mls_import_netlbl_cat(struct context *context,
>> -                                     struct netlbl_lsm_secattr *secattr)
>> -{
>> -     return -ENOMEM;
>> -}
>>  #endif
>>
>>  #endif       /* _SS_MLS_H */
>
> --
> paul moore
> www.paul-moore.com
>

Hi Paul

Thank you, yes it would be nice to do something for real :)
But will probably need a little more time than tonight for it, if it's
OK to wait until the weekend.


Kind regards
Rickard Strandqvist
