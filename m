Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6U1mqvc002995
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2013 21:48:52 -0400
Message-ID: <51F71B65.5060205@schaufler-ca.com>
Date: Mon, 29 Jul 2013 18:48:21 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v14 3/6] LSM: Explicit individual LSM associations
References: <51F16CFB.6040603@schaufler-ca.com> <51F16F2B.5020606@schaufler-ca.com> <CAGXu5jLEd8vt0d7aEecP7BMCduTyeFs56wv07TCCXbRr001B+Q@mail.gmail.com>
In-Reply-To: <CAGXu5jLEd8vt0d7aEecP7BMCduTyeFs56wv07TCCXbRr001B+Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/29/2013 1:51 PM, Kees Cook wrote:
> On Thu, Jul 25, 2013 at 11:32 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> Subject: [PATCH v14 3/6] LSM: Explicit individual LSM associations
>> [...]
>> Introduce feature specific security operation vectors
>> for NetLabel, XFRM, secmark and presentation in the
>> traditional /proc/.../attr interfaces. This allows
>> proper handling of secids.
>> [...]
>> --- a/include/linux/lsm.h
>> +++ b/include/linux/lsm.h
>> @@ -164,9 +164,18 @@ static inline void lsm_init_secid(struct secids *secid, u32 lsecid, int order)
>>  {
>>         memset(secid, 0, sizeof(*secid));
>>
>> -       if (lsecid != 0)
>> +       if (lsecid == 0)
>> +               return;
>> +       /*
>> +        * An order of -1 means set it for all LSMs.
>> +        */
>> +       if (order < 0) {
>> +               secid->si_lsm[0] = lsecid;
>> +               secid->si_count++;
>> +       } else {
>> +               secid->si_lsm[order] = lsecid;
>>                 secid->si_count = 1;
>> -       secid->si_lsm[order] = lsecid;
>> +       }
>>  }
>>
>>  static inline int lsm_zero_secid(struct secids *secid)
>> @@ -178,39 +187,64 @@ static inline int lsm_zero_secid(struct secids *secid)
>>
>>  #ifdef CONFIG_SECURITY
>>
>> +extern struct security_operations *present_ops;
>>  static inline struct security_operations *lsm_present_ops(void)
>>  {
>> -       return security_ops;
>> +       return present_ops;
>>  }
>>
>>  static inline int lsm_present_order(void)
>>  {
>> -       return 0;
>> +       return present_ops->order;
>>  }
>>
>> +#ifdef CONFIG_NETLABEL
>> +extern struct security_operations *netlbl_ops;
>> +
>>  static inline struct security_operations *lsm_netlbl_ops(void)
>>  {
>> -       return security_ops;
>> +       return netlbl_ops;
>>  }
>>
>>  static inline int lsm_netlbl_order(void)
>>  {
>> -       return 0;
>> +       return netlbl_ops->order;
>>  }
>> +#endif /* CONFIG_NETLABEL */
>> +
>> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
>> +extern struct security_operations *xfrm_ops;
>>
>>  static inline struct security_operations *lsm_xfrm_ops(void)
>>  {
>> -       return security_ops;
>> +       return xfrm_ops;
>>  }
>>
>>  static inline int lsm_xfrm_order(void)
>>  {
>> -       return 0;
>> +       return xfrm_ops->order;
>>  }
>> +#endif /* CONFIG_SECURITY_NETWORK_XFRM */
>> +
>> +#ifdef CONFIG_NETWORK_SECMARK
>> +extern struct security_operations *secmark_ops;
>>
>>  static inline struct security_operations *lsm_secmark_ops(void)
>>  {
>> -       return security_ops;
>> +       return secmark_ops;
>> +}
>> +
>> +static inline int lsm_secmark_order(void)
>> +{
>> +       return secmark_ops->order;
>> +}
>> +#endif /* CONFIG_NETWORK_SECMARK */
>> +
>> +#else /* CONFIG_SECURITY */
>> +
>> +static inline int lsm_xfrm_order(void)
>> +{
>> +       return 0;
>>  }
>>
>>  static inline int lsm_secmark_order(void)
>> @@ -218,6 +252,11 @@ static inline int lsm_secmark_order(void)
>>         return 0;
>>  }
>>
>> +static inline struct security_operations *lsm_secmark_ops(void)
>> +{
>> +       return NULL;
>> +}
>> +
>>  #endif /* CONFIG_SECURITY */
>>
>>  #endif /* ! _LINUX_LSM_H */
> Something went wrong here with the #ifdef/#else stuff here. I built
> without CONFIG_SECURITY_NETWORK_XFRM and it fails, missing
> lsm_xfrm_order().
>
> If I added an #else to the CONFIG_SECURITY_NETWORK_XFRM check and made
> lsm_xfrm_order() return 0 there too, it built fine.

Yup, I missed that configuration iteration at the end.
I've incorporated a fix.

>
> -Kees
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
