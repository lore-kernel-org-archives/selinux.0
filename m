Subject: Re: Wrong alignment when listing user/login with semanage in French
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
References: <2b54cfbd-56fb-a074-eeb7-11ebe02b9ecd@debian.org>
 <1484689529.20454.23.camel@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <ce8cac01-27b0-9bde-ac5b-a19f82e76d0d@debian.org>
Date: Wed, 18 Jan 2017 22:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <1484689529.20454.23.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 17/01/17 à 22:45, Stephen Smalley a écrit :
> On Sat, 2017-01-14 at 13:48 +0100, Laurent Bigonville wrote:
>> Hi,
>>
>> Not sure I already posted this on the ML.
>>
>> When listing the user/login with semanage (login/user -l) in French
>> (and
>> probably in other languages as well), the columns headers are not
>> properly aligned.
>>
>> This makes it sometimes difficult to read the output(and it's ugly),
>> see: https://i.imgur.com/zhZkebc.png
>>
>> Some of the translations should maybe be fixed in this case to make
>> them
>> shorter, but the alignment should probably be dynamic.
>>
>> RHEL/Fedora[1] contains the python binding for libsmartcols, maybe
>> this
>> could be used to do the formating?
> Not sure.  Is it readily available in other distributions and in
> OpenEmbedded?

It's not in Debian (or Ubuntu) yet but I could package it for the next 
cycle. libsmartcols itself is part of util-linux.

For OpenEmbedded I don't know.
