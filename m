Message-ID: <48F68A5A.1070108@redhat.com>
Date: Thu, 16 Oct 2008 10:27:06 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        dwalsh@redhat.com
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223644300.25569.41.camel@moss-spartans.epoch.ncsc.mil> <1223646314.8664.34.camel@localhost.localdomain>
In-Reply-To: <1223646314.8664.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Fri, 2008-10-10 at 09:11 -0400, Stephen Smalley wrote:
>> On Fri, 2008-10-10 at 17:26 +1000, Murray McAllister wrote:

>>> * Context changes are written to disk, and are not lost if the file 
>>> system is unmounted. Newly-created files and files copied to such a file 
>>> system inherit the SELinux context specified with the -o defcontext 
>>> option. For example, if a file system is mounted with the -o 
>>> defcontext="system_u:object_r:httpd_sys_content_t:s0" option, and a new 
>>> file is created on the mounted file system, that file is labeled with 
>>> the httpd_sys_content_t type. If the file system is unmounted and then 
>>> mounted without a context option, that file is still labeled with the 
>>> httpd_sys_content_t type.
> 
> I didn't know this 
You're not supposed to. It is wrong. Don't believe what I say :)

(am I supposed to admit that?)  I always thought
> normal label inheritance still took place even with defcontext=.
> Anyway, if you can double check that would be great...
> 
> mount -o httpd_sys_context_t
> mkdir testdir/
> chcon tmp_t testdir/
> touch testdir/file
> ls -lZ testdir/
> 
> if file is httpd_sys_context_t you are right.  if file is tmp_t normal
> inheritance took place....
Inheritance took place. I don't remember what I did last time to think 
otherwise.
> 
> Its not relevant to 99% of people at this time (same for defcontext and
> rootcontext), but that might change if we start making better policies
> to protect against accidental information leakage. All three should get
> a short blurb, context= needs the most description.  The most
> interesting use of fscontext is the 'associate' permission check.  It
> allows you to say that things labeled company_confidential_t are not
> allowed to be saved on a filesystem with fscontext=removable_media_t.
> We don't make much (any?) use of this feature, but fscontext is a very
> general label controlling the entire fs, can it be mounted, can certain
> data be written to it, etc, etc...
I have examples (will post soon) for mounting fat so that it can be 
shared via http, and a single nfs export mounted multiple times with 
different contexts. Please let me know if you want anything else.

Cheers.
> 
>>> # Is there any common use cases that should have examples here, such as 
>>> mounting a cd and sharing it via http or nfs?
> 
> exporting a FAT fs using http is common enough and uses context=
> 
> a discussion of multiple nfs mounts using context= could be useful.  If
> you don't know why it would be usefull context me off list and I'll
> explain all the nfs mount magic   :)
> 
> -Eric
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
