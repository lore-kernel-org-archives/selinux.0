Message-ID: <43E0AEEF.3060602@redhat.com>
Date: Wed, 01 Feb 2006 07:51:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
Subject: Re: labeling of compilers etc
References: <200601291156.13076.russell@coker.com.au> <200601311847.56015.russell@coker.com.au> <43E01E31.2060400@redhat.com> <200602011922.23667.russell@coker.com.au>
In-Reply-To: <200602011922.23667.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Wednesday 01 February 2006 13:34, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>>> I executed code on a block device.  Incidentally the device I used for
>>> testing was a USB flash device.  It seems to me that we want such devices
>>> to be removable_device_t not fixed_disk_device_t (as is currently the
>>> case).  Using removable_device_t will fix some usability cases but also
>>> make it more of an issue to control executing code from it.
>>>       
>> Most of the applications that were named in this discussion would be
>> blocked by a properly locked down domain anyways, by the name_connect
>> check.
>>     
>
> What do you mean?  How does name_connect relate to executing code on a USB 
> device?
>
>   
YOu mentioned confined domains calling out to tools like wget, ftp ... 
which would be blocked by name_connect.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
