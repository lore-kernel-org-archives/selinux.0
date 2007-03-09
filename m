Message-ID: <45F159AC.5050803@redhat.com>
Date: Fri, 09 Mar 2007 07:57:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mmap_file_perms needs ioctl also
References: <45F02B61.7040008@redhat.com>	 <200703091838.26634.russell@coker.com.au> <1173444689.3241.82.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173444689.3241.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-03-09 at 18:38 +1100, Russell Coker wrote:
>   
>> Why?
>>
>> Many programs that mmap files will also make ioctl() calls on them.  But AFAIK 
>> there is nothing forcing the application programmer to do so.  Expanding the 
>> permissions in this regard seems unnecessary.
>>     
>
> ioctl permission is effectively useless as it doesn't distinguish
> read-flow vs. write-flow vs. control-op, so it ends up being allowed
> pervasively whenever you allow read or write.  We really need to just
> replace it (ala the attempts by Lorenzo in the past), but doing so
> compatibly won't be easy.
>
>   
I just want the AVC go away...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
