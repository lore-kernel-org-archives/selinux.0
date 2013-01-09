Message-ID: <50ED5C8E.4040202@redhat.com>
Date: Wed, 09 Jan 2013 13:03:26 +0100
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: setfscreatecon optimizations
References: <50EC1D32.3090607@redhat.com> <50EC31AE.5040807@tycho.nsa.gov>
In-Reply-To: <50EC31AE.5040807@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------010806020101070905030104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010806020101070905030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the pointers, it helped me out a lot. I tested the patched 
libselinux with
$cp -a dir1 dir2
and got an approx. 20% save in instruction count. The patch is attached.
Thanks,
Ondrej

On 01/08/2013 03:48 PM, Stephen Smalley wrote:
> On 01/08/2013 08:20 AM, Ondrej Oprala wrote:
>> Hi, there have been some attempts on the coreutils mailing list at
>> optimizing cp copying by caching the selinux security context ( please
>> see: 
>> http://lists.gnu.org/archive/html/coreutils/2013-01/msg00012.html ).
>> Would it be possible to perform some kind of caching inside
>> setfscreatecon? For example not going through the whole process of
>> setfscreatecon if the context to be set equals the current one?
>
> I think that should be possible.  The relevant code that would need to 
> be modified is in libselinux/src/procattr.c.  You would likely want to 
> modify the common helper for all of the set*con functions, 
> setprocattrcon_raw().  A conceptually similar cache exists in 
> libselinux/src/setrans_client.c; note the methods used to make it 
> thread-safe and to ensure that it is properly freed. You would need a 
> separate cache for each kind of attribute that can be set, i.e. 
> current, exec, fscreate, keycreate, sockcreate. You could likely also 
> cache the tid.


--------------010806020101070905030104
Content-Type: text/plain; charset=UTF-8;
 name="DIFF"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="DIFF"


--------------010806020101070905030104--
