MIME-Version: 1.0
In-Reply-To: <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	<1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 23 Aug 2012 19:28:18 -0700
Message-ID: <CAFftDdqs9=nt9m4kCd0wva4FtE=wvC2hyUFbcb4gj02GrCo=vQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over system_data_file
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Haiqing Jiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to locate those patches for auditing, can someone please
point us in the right direction?

Are these them?
https://www.redhat.com/archives/linux-audit/2011-October/msg00030.html


On Fri, Jul 27, 2012 at 11:37 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-07-27 at 11:34 -0700, Haiqing Jiang wrote:
>> ---
>>  app.te |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/app.te b/app.te
>> index 85de816..dca2e0c 100644
>> --- a/app.te
>> +++ b/app.te
>> @@ -83,6 +83,8 @@ allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_
>>  # App sdcard file accesses
>>  allow platformappdomain sdcard:dir create_dir_perms;
>>  allow platformappdomain sdcard:file create_file_perms;
>> +# System data file accesses XXX????
>> +allow platformappdomain system_data_file:file open;
>>
>>  #
>>  # Untrusted apps.
>
> Need to know more about the denial to diagnose.
> Also, enabling syscall audit may help with getting full pathnames,
> although you likely need the ARM audit patches for that.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
