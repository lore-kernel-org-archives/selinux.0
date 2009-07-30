Message-ID: <4A71ED69.8090306@redhat.com>
Date: Thu, 30 Jul 2009 14:58:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: [RFC][PATCH] setfiles:  only call realpath if the path is relative
References: <1248967075.11627.170.camel@moss-pluto.epoch.ncsc.mil>	 <4A71D2C2.5080102@redhat.com> <1248974915.11627.180.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1248974915.11627.180.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/30/2009 01:28 PM, Stephen Smalley wrote:
> On Thu, 2009-07-30 at 13:05 -0400, Daniel J Walsh wrote:
>> On 07/30/2009 11:17 AM, Stephen Smalley wrote:
>>> Since we can now safely use restorecon -R / on kernels >= 2.6.30 without
>>> concern about restorecon descending into filesystems that do not support
>>> labeling, I wanted to compare it against running setfiles on the list of
>>> filesystems that support labeling.  I noticed a significant difference
>>> in performance that I traced to the use of realpath() when setfiles is
>>> called as restorecon.
>>>
>>> When called as restorecon, setfiles calls realpath() so that sequences
>>> like:
>>> 	cd /etc
>>> 	restorecon shadow gshadow
>>> will work as expected.
>>>
>>> This patch changes the logic to only apply realpath() if the pathname is
>>> relative, which covers the above case.  However, if a user runs
>>> restorecon /a/b/c and any of the components is a symlink, restorecon
>>> won't apply realpath after this patch and thus may not match the correct
>>> file contexts entry.  Thoughts?
>>>
>>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>>> index 5e5d957..996d230 100644
>>> --- a/policycoreutils/setfiles/setfiles.c
>>> +++ b/policycoreutils/setfiles/setfiles.c
>>> @@ -311,7 +311,7 @@ int match(const char *name, struct stat *sb, char **con)
>>>  {
>>>  	char path[PATH_MAX + 1];
>>>  
>>> -	if (expand_realpath) {
>>> +	if (expand_realpath && name[0] != '/') {
>>>  		if (S_ISLNK(sb->st_mode)) {
>>>  			if (verbose > 1)
>>>  				fprintf(stderr,
>>>
>>>
>> The place where this is a problem is
>>
>> restorecon -Rv /etc/init.d
>> versus
>> restorecon -Rv /etc/rc.d/init.d
>>
>> What happens to the labeling?
> 
> Yes, that's a concern.  restorecon -Rv /etc/init.d appears to stop
> immediately since it doesn't follow symlinks, but restorecon
> -Rv /etc/init.d/ did descend and reset the labels incorrectly.
> 
> Possibly we could apply realpath() only to the user-supplied pathnames
> before calling fts_open(), so that we would rewrite any of the
> user-supplied pathname prefixes to eliminate symlinks and relative paths
> up front, and then fts will just do the right thing afterward.  That
> eliminates the overhead of calling realpath() on each file down inside
> of match().
> 

That sounds like a good compromise.  I just do not want the user to be surprised.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
