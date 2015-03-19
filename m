Message-ID: <550AE460.1040004@tresys.com>
Date: Thu, 19 Mar 2015 10:59:44 -0400
From: Thomas Hurd <thurd@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Steve Lawrence
 <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Change bunzip to use heap instead of stack
 for buffer.
References: <1424959400-22134-1-git-send-email-thurd@tresys.com>
 <54EF493B.9020003@tresys.com> <5509C3BE.6010705@tycho.nsa.gov>
 <5509C4EF.9040701@tycho.nsa.gov>
In-Reply-To: <5509C4EF.9040701@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/18/2015 02:33 PM, Stephen Smalley wrote:
> On 03/18/2015 02:28 PM, Stephen Smalley wrote:
>> On 02/26/2015 11:26 AM, Steve Lawrence wrote:
>>> On 02/26/2015 09:03 AM, Thomas Hurd wrote:
>>>> Fixes segfault on systems with less than 256K stack size.
>>>> After change, I was able to run semodule -l with a 32K stack size.
>>>> Additionally, fix potential memory leak on realloc failure.
>>>>
>>>> Signed-off-by: Thomas Hurd <thurd@tresys.com>
>>> Acked-by: Steve Lawrence <slawrence@tresys.com>
>>>
>>> Thanks!
>> This broke installing .pp files that are not bzip2'd.
>> Previously, one could transparently installed compressed or uncompressed
>> .pp files without difficulty.
> Before:
> /usr/sbin/semodule -i test_policy/test_policy.pp
>
> After:
> /usr/sbin/semodule -i test_policy/test_policy.pp
> libsemanage.bunzip: Failure reading bz2 archive. (No such file or
> directory).
>

Thanks.  It turns out it's only the error message being printed is 
incorrect. Uncompressed pp files will still be installed.

In the case of an uncompressed pp it will fail magic number checking in 
BZ2_bzRead(). I think the fix is to unconditionally
check the magic number before BZ2_bzReadOpen() instead of only when 
bzip_blocksize=0, since it falls through there anyway.
That way if the file is not compressed it will return immediately and 
map_file can mmap it. If the file is compressed then it will
go through the BZ2 functions and any errors will be reported correctly.

Sending a patch with that fix.

>>>> ---
>>>>   libsemanage/src/direct_api.c | 61 ++++++++++++++++++++++++++++++++------------
>>>>   1 file changed, 44 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>>>> index b0ed338..be6bd3c 100644
>>>> --- a/libsemanage/src/direct_api.c
>>>> +++ b/libsemanage/src/direct_api.c
>>>> @@ -428,49 +428,76 @@ static ssize_t bzip(semanage_handle_t *sh, const char *filename, char *data,
>>>>    * in the file.  Returns -1 if file could not be decompressed. */
>>>>   ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
>>>>   {
>>>> -	BZFILE* b;
>>>> +	BZFILE* b = NULL;
>>>>   	size_t  nBuf;
>>>> -	char    buf[1<<18];
>>>> -	size_t  size = sizeof(buf);
>>>> +	char*   buf = NULL;
>>>> +	size_t  size = 1<<18;
>>>> +	size_t  bufsize = size;
>>>>   	int     bzerror;
>>>>   	size_t  total=0;
>>>> +	char*   uncompress = NULL;
>>>> +	char*   tmpalloc = NULL;
>>>> +	int     ret = -1;
>>>> +
>>>> +	buf = malloc(bufsize);
>>>> +	if (buf == NULL) {
>>>> +		ERR(sh, "Failure allocating memory.");
>>>> +		goto exit;
>>>> +	}
>>>>   
>>>>   	if (!sh->conf->bzip_blocksize) {
>>>>   		bzerror = fread(buf, 1, BZ2_MAGICLEN, f);
>>>>   		rewind(f);
>>>> -		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN))
>>>> -			return -1;
>>>> +		if ((bzerror != BZ2_MAGICLEN) || memcmp(buf, BZ2_MAGICSTR, BZ2_MAGICLEN)) {
>>>> +			ERR(sh, "bz2 magic number not found.");
>>>> +			goto exit;
>>>> +		}
>>>>   		/* fall through */
>>>>   	}
>>>>   	
>>>>   	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
>>>>   	if ( bzerror != BZ_OK ) {
>>>> -		BZ2_bzReadClose ( &bzerror, b );
>>>> -		return -1;
>>>> +		ERR(sh, "Failure opening bz2 archive.");
>>>> +		goto exit;
>>>>   	}
>>>> -	
>>>> -	char *uncompress = realloc(NULL, size);
>>>> -	
>>>> +
>>>> +	uncompress = malloc(size);
>>>> +	if (uncompress == NULL) {
>>>> +		ERR(sh, "Failure allocating memory.");
>>>> +		goto exit;
>>>> +	}
>>>> +
>>>>   	while ( bzerror == BZ_OK) {
>>>> -		nBuf = BZ2_bzRead ( &bzerror, b, buf, sizeof(buf));
>>>> +		nBuf = BZ2_bzRead ( &bzerror, b, buf, bufsize);
>>>>   		if (( bzerror == BZ_OK ) || ( bzerror == BZ_STREAM_END )) {
>>>>   			if (total + nBuf > size) {
>>>>   				size *= 2;
>>>> -				uncompress = realloc(uncompress, size);
>>>> +				tmpalloc = realloc(uncompress, size);
>>>> +				if (tmpalloc == NULL) {
>>>> +					ERR(sh, "Failure allocating memory.");
>>>> +					goto exit;
>>>> +				}
>>>> +				uncompress = tmpalloc;
>>>>   			}
>>>>   			memcpy(&uncompress[total], buf, nBuf);
>>>>   			total += nBuf;
>>>>   		}
>>>>   	}
>>>>   	if ( bzerror != BZ_STREAM_END ) {
>>>> -		BZ2_bzReadClose ( &bzerror, b );
>>>> -		free(uncompress);
>>>> -		return -1;
>>>> +		ERR(sh, "Failure reading bz2 archive.");
>>>> +		goto exit;
>>>>   	}
>>>> -	BZ2_bzReadClose ( &bzerror, b );
>>>>   
>>>> +	ret = total;
>>>>   	*data = uncompress;
>>>> -	return  total;
>>>> +
>>>> +exit:
>>>> +	BZ2_bzReadClose ( &bzerror, b );
>>>> +	free(buf);
>>>> +	if ( ret < 0 ) {
>>>> +		free(uncompress);
>>>> +	}
>>>> +	return ret;
>>>>   }
>>>>   
>>>>   /* mmap() a file to '*data',
>>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>>
