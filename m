Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5NNg9IT024251
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 19:42:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5NNdESo111874
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 19:42:02 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b99f8p6hu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 19:42:02 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <stefanb@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 19:42:01 -0400
Subject: Re: [PATCH 3/3] Enable security.selinux in user namespaces
To: Stephen Smalley <sds@tycho.nsa.gov>, ebiederm@xmission.com,
 containers@lists.linux-foundation.org
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1498157989-11814-4-git-send-email-stefanb@linux.vnet.ibm.com>
 <1498249800.2063.9.camel@tycho.nsa.gov>
Cc: lkp@01.org, xiaolong.ye@intel.com, linux-kernel@vger.kernel.org,
 zohar@linux.vnet.ibm.com, serge@hallyn.com, tycho@docker.com,
 James.Bottomley@HansenPartnership.com, christian.brauner@mailbox.org,
 vgoyal@redhat.com, amir73il@gmail.com,
 linux-security-module@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 19:41:52 -0400
MIME-Version: 1.0
In-Reply-To: <1498249800.2063.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f477e588-a557-65ae-13db-8e8a87955b7f@linux.vnet.ibm.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/23/2017 04:30 PM, Stephen Smalley wrote:
> On Thu, 2017-06-22 at 14:59 -0400, Stefan Berger wrote:
>> Before the current modifications, SELinux extended attributes were
>> visible inside the user namespace but changes in patch 1 hid them.
>> This patch enables security.selinux in user namespaces and allows
>> them to be written to in the same way as security.capability.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   fs/xattr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/xattr.c b/fs/xattr.c
>> index 045be85..37686ee 100644
>> --- a/fs/xattr.c
>> +++ b/fs/xattr.c
>> @@ -138,6 +138,7 @@ xattr_permission(struct inode *inode, const char
>> *name, int mask)
>>    */
>>   static const char *const userns_xattrs[] = {
>>   	XATTR_NAME_CAPS,
>> +	XATTR_NAME_SELINUX,
>>   	NULL
>>   };
>>   
> (cc SELinux maintainers, curiously omitted from these patches)
>
> I don't think this works for SELinux. You don't deal with actually
> supporting multiple security.selinux attributes within SELinux itself
> (and I'm not asking you to do so), and without such support, this can't
> operate as intended. With these patches applied, IIUC, a setxattr() of
> security.selinux within a userns will end up setting only security.seli
> nux@uid=1000 on disk, but will then tell SELinux to update its in-core
> security label to the new value (via security_inode_post_setxattr).
> Meanwhile, on a subsequent getxattr(), you'll call
> security_inode_getsecurity() with the security.selinux@uid=1000 name,
> which will always fail because SELinux doesn't know anything about your
> new scheme, and then you'll call the filesystem handler and returns its
> value, which is no longer connected in any way to the actual label
> being used by SELinux.  Also, SELinux itself makes calls to
> __vfs_getxattr() and __vfs_setxattr_noperm(), and I don't think your
> name remapping is correct in those cases.
>
> You also can't hide security.selinux within user namespaces.  Today
> userspace can get and set security.selinux attributes within user
> namespaces (if allowed by policy), and further can specify the label to
> use for new files via /proc/self/attr/fscreate, which unsurprisingly
> isn't addressed by your changes.  Changing that would be a userspace
> break.

I modified the 1st patch now in such a way that only security.capability 
is rewritten, security.selinux and all other ones remain untouched.

https://github.com/stefanberger/linux/commits/xattr_for_userns.v2

    Stefan
