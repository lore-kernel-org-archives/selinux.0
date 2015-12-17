Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBHEMqfL020367
 for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2015 09:23:09 -0500
Received: by mail-qk0-f175.google.com with SMTP id u65so79675035qkh.2
 for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2015 06:22:57 -0800 (PST)
Message-ID: <5672C53E.30700@quarksecurity.com>
Date: Thu, 17 Dec 2015 09:22:54 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Verify context input to funtions to make
 sure the context field is not null.
References: <1449694065-26728-1-git-send-email-plautrba@redhat.com>
 <5672BED4.6000802@tresys.com>
In-Reply-To: <5672BED4.6000802@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Steve Lawrence wrote:
> I believe this patch, or something similar, was sent to the list in the
> past and was rejected. Passing in a NULL context is considered invalid
> use, similar to strdup/strcmp/etc. and is a bug in the calling process.
>

It isn't unreasonable for an API to indicate invalid usage (which is 
what EINVAL does). The argument that strdup lets you shoot yourself in 
the foot so we should to isn't very compelling...

> On 12/09/2015 03:47 PM, Petr Lautrbach wrote:
>> From: Dan Walsh<dwalsh@redhat.com>
>>
>> Return errno EINVAL, to prevent segfault.
>>
>> Signed-off-by: Petr Lautrbach<plautrba@redhat.com>
>> ---
>>   libselinux/src/avc_sidtab.c           | 5 +++++
>>   libselinux/src/canonicalize_context.c | 5 +++++
>>   libselinux/src/check_context.c        | 5 +++++
>>   libselinux/src/compute_av.c           | 5 +++++
>>   libselinux/src/compute_create.c       | 5 +++++
>>   libselinux/src/compute_member.c       | 5 +++++
>>   libselinux/src/compute_relabel.c      | 5 +++++
>>   libselinux/src/compute_user.c         | 5 +++++
>>   libselinux/src/fsetfilecon.c          | 8 ++++++--
>>   libselinux/src/lsetfilecon.c          | 9 +++++++--
>>   libselinux/src/setfilecon.c           | 8 ++++++--
>>   11 files changed, 59 insertions(+), 6 deletions(-)
>>
>> diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
>> index 9669264..a46cfa7 100644
>> --- a/libselinux/src/avc_sidtab.c
>> +++ b/libselinux/src/avc_sidtab.c
>> @@ -81,6 +81,11 @@ sidtab_context_to_sid(struct sidtab *s,
>>   	int hvalue, rc = 0;
>>   	struct sidtab_node *cur;
>>
>> +	if (! ctx) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	*sid = NULL;
>>   	hvalue = sidtab_hash(ctx);
>>
>> diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
>> index 7cf3139..9d8dc86 100644
>> --- a/libselinux/src/canonicalize_context.c
>> +++ b/libselinux/src/canonicalize_context.c
>> @@ -17,6 +17,11 @@ int security_canonicalize_context_raw(const char * con,
>>   	size_t size;
>>   	int fd, ret;
>>
>> +	if (! con) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	if (!selinux_mnt) {
>>   		errno = ENOENT;
>>   		return -1;
>> diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
>> index 52063fa..9637dd7 100644
>> --- a/libselinux/src/check_context.c
>> +++ b/libselinux/src/check_context.c
>> @@ -14,6 +14,11 @@ int security_check_context_raw(const char * con)
>>   	char path[PATH_MAX];
>>   	int fd, ret;
>>
>> +	if (! con) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	if (!selinux_mnt) {
>>   		errno = ENOENT;
>>   		return -1;
>> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
>> index 937e5c3..e67b3d3 100644
>> --- a/libselinux/src/compute_av.c
>> +++ b/libselinux/src/compute_av.c
>> @@ -26,6 +26,11 @@ int security_compute_av_flags_raw(const char * scon,
>>   		return -1;
>>   	}
>>
>> +	if ((! scon) || (! tcon)) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	snprintf(path, sizeof path, "%s/access", selinux_mnt);
>>   	fd = open(path, O_RDWR);
>>   	if (fd<  0)
>> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
>> index 9559d42..7de721a 100644
>> --- a/libselinux/src/compute_create.c
>> +++ b/libselinux/src/compute_create.c
>> @@ -64,6 +64,11 @@ int security_compute_create_name_raw(const char * scon,
>>   		return -1;
>>   	}
>>
>> +	if ((! scon) || (! tcon)) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	snprintf(path, sizeof path, "%s/create", selinux_mnt);
>>   	fd = open(path, O_RDWR);
>>   	if (fd<  0)
>> diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
>> index 1fc7e41..4ff2173 100644
>> --- a/libselinux/src/compute_member.c
>> +++ b/libselinux/src/compute_member.c
>> @@ -25,6 +25,11 @@ int security_compute_member_raw(const char * scon,
>>   		return -1;
>>   	}
>>
>> +	if ((! scon) || (! tcon)) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	snprintf(path, sizeof path, "%s/member", selinux_mnt);
>>   	fd = open(path, O_RDWR);
>>   	if (fd<  0)
>> diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
>> index 4615aee..6a37acf 100644
>> --- a/libselinux/src/compute_relabel.c
>> +++ b/libselinux/src/compute_relabel.c
>> @@ -25,6 +25,11 @@ int security_compute_relabel_raw(const char * scon,
>>   		return -1;
>>   	}
>>
>> +	if ((! scon) || (! tcon)) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
>>   	fd = open(path, O_RDWR);
>>   	if (fd<  0)
>> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
>> index b37c5d3..3737c28 100644
>> --- a/libselinux/src/compute_user.c
>> +++ b/libselinux/src/compute_user.c
>> @@ -24,6 +24,11 @@ int security_compute_user_raw(const char * scon,
>>   		return -1;
>>   	}
>>
>> +	if (! scon) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>>   	snprintf(path, sizeof path, "%s/user", selinux_mnt);
>>   	fd = open(path, O_RDWR);
>>   	if (fd<  0)
>> diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
>> index 52707d0..83c138e 100644
>> --- a/libselinux/src/fsetfilecon.c
>> +++ b/libselinux/src/fsetfilecon.c
>> @@ -9,8 +9,12 @@
>>
>>   int fsetfilecon_raw(int fd, const char * context)
>>   {
>> -	int rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
>> -			 0);
>> +	int rc;
>> +	if (! context) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +	rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
>>   	if (rc<  0&&  errno == ENOTSUP) {
>>   		char * ccontext = NULL;
>>   		int err = errno;
>> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
>> index 1d3b28a..278e42a 100644
>> --- a/libselinux/src/lsetfilecon.c
>> +++ b/libselinux/src/lsetfilecon.c
>> @@ -9,8 +9,13 @@
>>
>>   int lsetfilecon_raw(const char *path, const char * context)
>>   {
>> -	int rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
>> -			 0);
>> +	int rc;
>> +	if (! context) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +
>> +	rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
>>   	if (rc<  0&&  errno == ENOTSUP) {
>>   		char * ccontext = NULL;
>>   		int err = errno;
>> diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c
>> index d05969c..dddce3c 100644
>> --- a/libselinux/src/setfilecon.c
>> +++ b/libselinux/src/setfilecon.c
>> @@ -9,8 +9,12 @@
>>
>>   int setfilecon_raw(const char *path, const char * context)
>>   {
>> -	int rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
>> -			0);
>> +	int rc;
>> +	if (! context) {
>> +		errno = EINVAL;
>> +		return -1;
>> +	}
>> +	rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
>>   	if (rc<  0&&  errno == ENOTSUP) {
>>   		char * ccontext = NULL;
>>   		int err = errno;
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
