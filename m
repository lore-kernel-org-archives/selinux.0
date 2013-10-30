Message-ID: <5271327F.5080901@tycho.nsa.gov>
Date: Wed, 30 Oct 2013 12:23:27 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Properly build the swig exception file even if the headers
 are missing
References: <1369073925-4446-1-git-send-email-bigon@debian.org> <20131030171007.15a26535@soldur.bigon.be>
In-Reply-To: <20131030171007.15a26535@soldur.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 12:10 PM, Laurent Bigonville wrote:
> Hi,
> 
> Since you are busy merging stuffs, could somebody have a look at this
> patch please (aka ping message)?

Thanks, I had missed it.  Merged.

> 
> Cheers
> 
> Laurent Bigonville
> 
> Le Mon, 20 May 2013 20:18:45 +0200,
> Laurent Bigonville <bigon@debian.org> a écrit :
> 
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> During build if the headers are not installed in the system path, the
>> generated swig exception (.i) file might be empty.
>> ---
>>  libselinux/src/exception.sh  | 2 +-
>>  libsemanage/src/exception.sh | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
>> index c3e61a5..b7cff7e09 100755
>> --- a/libselinux/src/exception.sh
>> +++ b/libselinux/src/exception.sh
>> @@ -15,6 +15,6 @@ echo "
>>  ;;
>>  esac
>>  }
>> -gcc -x c -c - -aux-info temp.aux < ../include/selinux/selinux.h
>> +gcc -x c -c -I../include - -aux-info temp.aux
>> < ../include/selinux/selinux.h for i in `awk '/<stdin>.*extern int/
>> { print $6 }' temp.aux`; do except $i ; done rm -f -- temp.aux -.o
>> diff --git a/libsemanage/src/exception.sh
>> b/libsemanage/src/exception.sh index 8693fb7..94619d2 100644
>> --- a/libsemanage/src/exception.sh
>> +++ b/libsemanage/src/exception.sh
>> @@ -9,6 +9,6 @@ echo "
>>  }
>>  "
>>  }
>> -gcc -x c -c - -aux-info temp.aux < ../include/semanage/semanage.h
>> +gcc -x c -c -I../include - -aux-info temp.aux
>> < ../include/semanage/semanage.h for i in `awk '/extern int/ { print
>> $6 }' temp.aux`; do except $i ; done rm -f -- temp.aux -.o
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
