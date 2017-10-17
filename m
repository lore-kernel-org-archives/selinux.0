Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9HH5J4k008946
 for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2017 13:05:21 -0400
Received: by mail-io0-f174.google.com with SMTP id m16so2964778iod.1
 for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2017 09:38:34 -0700 (PDT)
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Dan Cashman <dcashman@google.com>
References: <1505939283.31597.11.camel@tycho.nsa.gov>
 <20171010211257.18474-1-dcashman@android.com>
 <1507922626.15007.10.camel@tycho.nsa.gov>
From: Dan Cashman <dcashman@android.com>
Message-ID: <067977d4-8c8e-f9bc-c19d-b887ed30cdc5@android.com>
Date: Tue, 17 Oct 2017 09:38:15 -0700
MIME-Version: 1.0
In-Reply-To: <1507922626.15007.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] selinux: libselinux: Enable multiple input
 files to selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/13/2017 12:23 PM, Stephen Smalley wrote:
> On Tue, 2017-10-10 at 14:12 -0700, Daniel Cashman wrote:
>> From: Dan Cashman <dcashman@google.com>
>>
>> The file_contexts labeling backend, specified in label_file.c,
>> currently assumes
>> that only one path will be specified as an option to
>> selabel_open().  The split
>> of platform and non-platform policy on device, however, will
>> necessitate the
>> loading of two disparate policy files.  Rather than combining the
>> files and then
>> calling the existing API on a newly-formed file, just add the ability
>> to specify
>> multiple files to use.  Order of opt specification to selabel_open
>> matters.
>>
>> This corresponds to AOSP commit
>> 50400d38203e4db08314168e60c281cc61a717a8, which
>> lead to a fork with upstream, which we'd like to correct.
>>
>> Signed-off-by: Dan Cashman <dcashman@android.com>
>> ---
>>   libselinux/src/label.c          |  21 +++++---
>>   libselinux/src/label_db.c       |   4 +-
>>   libselinux/src/label_file.c     | 104 +++++++++++++++++++++++++++++-
>> ----------
>>   libselinux/src/label_internal.h |   5 +-
>>   libselinux/src/label_media.c    |   4 +-
>>   libselinux/src/label_x.c        |   4 +-
>>   6 files changed, 103 insertions(+), 39 deletions(-)
>>
> 
>> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
>> index c46d0a1d..205ff5f4 100644
>> --- a/libselinux/src/label_db.c
>> +++ b/libselinux/src/label_db.c
>> @@ -290,7 +290,9 @@ db_init(const struct selinux_opt *opts, unsigned
>> nopts,
>>   		errno = EINVAL;
>>   		return NULL;
>>   	}
>> -	rec->spec_file = strdup(path);
>> +	rec->spec_files_len = 1;
>> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
> 
> Missing semicolon, and a check for NULL.  Also should likely be
> sizeof(rec->spec_files[0]) or sizeof(char *); path isn't really
> relevant here.
> 
>> +	rec->spec_files[0] = strdup(path);
> 
> Ditto, although I see you didn't introduce that per se; we ought to fix
> it anyway.
> 
>> diff --git a/libselinux/src/label_media.c
>> b/libselinux/src/label_media.c
>> index d202e5d5..f4a46ffe 100644
>> --- a/libselinux/src/label_media.c
>> +++ b/libselinux/src/label_media.c
>> @@ -100,7 +100,9 @@ static int init(struct selabel_handle *rec, const
>> struct selinux_opt *opts,
>>   		errno = EINVAL;
>>   		return -1;
>>   	}
>> -	rec->spec_file = strdup(path);
>> +	rec->spec_files_len = 1;
>> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
>> +	rec->spec_files[0] = strdup(path);
> 
> Same as for label_db.c.
> 
>>   
>>   	/*
>>   	 * Perform two passes over the specification file.
>> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
>> index 96745299..54ebd2eb 100644
>> --- a/libselinux/src/label_x.c
>> +++ b/libselinux/src/label_x.c
>> @@ -127,7 +127,9 @@ static int init(struct selabel_handle *rec, const
>> struct selinux_opt *opts,
>>   		errno = EINVAL;
>>   		return -1;
>>   	}
>> -	rec->spec_file = strdup(path);
>> +	rec->spec_files_len = 1;
>> +	rec->spec_files = calloc(rec->spec_files_len, sizeof(path))
>> +	rec->spec_files[0] = strdup(path);
> 
> And again.
> 
>>   
>>   	/*
>>   	 * Perform two passes over the specification file.

Well that was embarrassing.  Twice bitten, thrice shy?  I've now setup a 
fedora vm to at least test whether or not patches will build, so that's 
a good outcome of this.  Submitted v3 to the list (rather than 
continuing this thread).  Thanks for the review!

-Dan
