Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u04GZkfh005638
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 11:35:46 -0500
Received: by mail-qg0-f42.google.com with SMTP id 6so179586245qgy.1
 for <selinux@tycho.nsa.gov>; Mon, 04 Jan 2016 08:35:41 -0800 (PST)
Message-ID: <568A9F54.6010706@quarksecurity.com>
Date: Mon, 04 Jan 2016 11:35:32 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Dominick Grift <dac.override@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] update deps and change yum to dnf
References: <1451917434-40069-1-git-send-email-brindle@quarksecurity.com>
 <20160104163031.GA8382@x250>
In-Reply-To: <20160104163031.GA8382@x250>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dominick Grift wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Mon, Jan 04, 2016 at 09:23:54AM -0500, Joshua Brindle wrote:
>> ---
>>   README | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/README b/README
>> index dae1eb9..2497485 100644
>> --- a/README
>> +++ b/README
>> @@ -2,7 +2,7 @@ Please submit all bug reports and patches to selinux@tycho.nsa.gov.
>>   Subscribe via selinux-join@tycho.nsa.gov.
>>
>>   Build dependencies on Fedora:
>> -yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel
>> +dnf install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel gcc redhat-rpm-config xmlto
>
> What are xmlto, and redhat-rpm-config for?

secilc/Makefile:	$(XMLTO) man $(MANPAGE).xml


and redhat-rpm-config is required for 
/usr/lib/rpm/redhat/redhat-hardened-cc1

>
> Building secilc html and pdf docs requires pandoc as per: https://github.com/SELinuxProject/selinux/blob/master/secilc/README#L59
>

Hrm, are these optional?

>>
>>   To build and install everything under a private directory, run:
>>   make DESTDIR=~/obj install install-pywrap
>> --
>> 2.5.0
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJWip4jAAoJENAR6kfG5xmcVa4MALk6x3voVGy0ECchEu0vfHnN
> FgyZGt9zUaXsEkAXH3867LuBTamn3DT8grt8hqIFZcwfxRBYfq9mrZvw5qLhB5uM
> xtaYYihcbCx5iVqEP9BMH5MQXZJEnfRrQOh+uvMYkpKTZ50g2hqbp+f5i4rHm9JM
> dOgnalC8ZpMar1mfnabNH4Lp3X+zxTIfO8wigQuvN5i2VIO/aMWxsbhSm1NzSjJE
> Ww2ZCE+D2mhGsD2HQe/J714wdC3c1MYVqwUSpHnkz2xsq6rUfq0XehjOu0ao/GTd
> 8TH1fXlSaqskRBPZdH0TqjA4zGwbQS3OnuWwc4Wn3jIOpirQa91/gBeDaoH/oPvD
> SCfvzTPGGrywSK95ZlOH/EI5Iu5TCmg0c3rrGtgSaX1Pss1KCsG8mViXSHued6EY
> Xh4GQfwa3XlNzy2V/cVGCcRPKMVR1Ruhrjt45oIKK2hMOyEEnJVs2dDZOHAlwd9K
> a9KUrigmrRjYRfja1hxu5K76w5GViKby64Jjb7S8aA==
> =XAEE
> -----END PGP SIGNATURE-----
