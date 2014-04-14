Message-ID: <534BD26A.4060505@tycho.nsa.gov>
Date: Mon, 14 Apr 2014 08:19:54 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: ge <geshifei@126.com>, selinux@tycho.nsa.gov
Subject: Re: /data used as two filesystem =?UTF-8?B?bW91bnRwb2ludO+8jHRoZQ==?=
 =?UTF-8?B?biBzZWFuZHJvaWQgaG93IHRvIGxhYmxlIGZpbGUgc2Vjb250ZXh0Pw==?=
References: <39915653.12e6.14558fbb04d.Coremail.geshifei@126.com>
In-Reply-To: <39915653.12e6.14558fbb04d.Coremail.geshifei@126.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2014 10:47 PM, ge wrote:
> ﻿hi，everyone.
> I meet with a problem(seandroid 4.4)：As we know,/data was mounted 
> as ext4 partition in original version. Additional I mount /data as a 
> psuedo filesystme. 
> 
> the sepolicy of  external/sepolicy/fs_use is changed as follow:
> ...
> *fs_use_xattr ext4 u:object_r:labeledfs:s0;*
> ...
> *fs_use_trans psuedosystem u:object_r:* *psuedosystem* *:s0*
> *
> *
> I found that after power on mobile phone,every app is running ok,and  
> secontext of files in /data(psuedo filesystem layer) is 
> "*u:object_r:* *psuedosystem* *:s0*" , and  secontext of files
>  in /data(ext4 layer) is correct with sepolicy,such as
>  "u:object_r:app_data_file:s0".
> 
> but when I install a new app,the secontext of app's dirs and files in ext4 
> partition is inherited from app installed dir /data/data,sosecontext is
>  "u:object_r:system_data_file:s0",the right should
> be "u:object_r:app_data_file:s0".
> 
> I think this problem maybe caused by :when mount /data on psuedo
> filesystem,the
> /data represent ext4 filesystem is hide.So set selinux xattr,kernel only
> can operate 
> psuedo filesystem file.
> 
> could someone tell me when install a new package ,how seandroid label
> package dir 
> and files with external/sepolicy/fs_use above? If seandroid call
> systemcall "setxattr" to set
> selinux context, i will modify the psuedo file system not operate psuedo
> filesystem file 
> but lower ext4 file in /data.
> 
> thanks for your help.

seandroid-list would be a better place to ask this question.  However, I
think we need more information - it sounds like you are using some kind
of unionfs / union mount mechanism to overlay two mounts on /data, but
you didn't identify what you are using or what kernel you are using, so
it is difficult to answer any questions about how your specific union
mechanism may operate wrt xattrs.  If the pseudo filesystem is the top
layer, then yes, you will likely encounter problems with files in the
lower layer not being labeled properly.
