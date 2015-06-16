Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5GDTSsA027185
 for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2015 09:29:28 -0400
Date: Tue, 16 Jun 2015 13:25:48 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <2044202195.3317950.1434461148791.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <557F28FA.9050608@tycho.nsa.gov>
References: <557F28FA.9050608@tycho.nsa.gov>
Subject: Re: [PATCH V2] libselinux: Enhance file context support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>




>>  +int compat_validate(struct selabel_handle __attribute__((unused)) *rec,
>>  +        struct selabel_lookup_rec  __attribute__((unused)) *contexts,
>>  +        const char  __attribute__((unused)) *path,
>>  +        unsigned  __attribute__((unused)) lineno)
>>  +{
>>  +    return 0;
>>  +}
> 
> Looked into why you couldn't just use the original approach here, and
> realized that we are linking sefcontext_compile with static libselinux
> in Android, shared libselinux upstream.  Also realized that your
> read_spec_entries function was being accidentally exported to shared
> library users, and that also is relied upon by sefcontext_compile.
> Given that sefcontext_compile depends on libselinux internal structures,
> I can't see a reason to not have it link with the static libselinux, so
> I just switched it upstream to do so (and hid read_spec_entries).  So
> now you ought to be able to go back to the prior approach, which seemed
> cleaner.

Thanks for this fix as I just could not get around it. I'm just testing
with the original callback. Once you are happy I'll apply all the
updates you've highlighted to the Android version.
