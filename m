Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
 <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
 <1484256222.16361.23.camel@tycho.nsa.gov>
 <6cd88833-0af5-c935-3c8f-04afc000ceff@gmail.com>
 <1484318901.32375.32.camel@tycho.nsa.gov>
 <1484321279.32375.44.camel@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <6e56f621-188f-16e8-96f1-35cbbde1a0bc@redhat.com>
Date: Fri, 13 Jan 2017 13:29:51 -0500
MIME-Version: 1.0
In-Reply-To: <1484321279.32375.44.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 01/13/2017 10:27 AM, Stephen Smalley wrote:
> On Fri, 2017-01-13 at 09:48 -0500, Stephen Smalley wrote:
>> On Thu, 2017-01-12 at 23:42 +0000, Alan Jenkins wrote:
>>> My main puzzle here[*] is why `fixfiles` handles sysfs (/sys/)
>>> fine,
>>> but 
>>> then there's floods of warnings about debugfs
>>> (/sys/kernel/debug/).  The 
>>> same seems to happen with /dev/ being fine, but not the other
>>> virtual 
>>> fs's with seclabel which are mounted in subdirectories of /dev/.
>> This is a bug/regression.  Thanks for reporting it.  In commit
>> 36f1ccbb5743749c404ad8f960867923544b90d9, Dan added this warning but
>> only if the user explicitly does a restorecon /path/to/foo and
>> /path/to/foo does not have any matching label in file_contexts; in
>> the
>> case of a restorecon -R or setfiles, it isn't supposed to happen.
>>  The
>> check on the recursive flag got dropped when this logic was taken
>> into
>> selinux_restorecon(3) in libselinux
>> (commit f2e77865e144ab2e1313aa78d99b969f8f48695e).  Will fix.
> Actually, I am wrong about this being a regression (and I should have
> known that, since the buggy version is 2.5 and that precedes the latter
> commit). Looking at the first commit, the original logic was to display
> a warning if not recursive OR verbose, so it would unconditionally log
> a warning if you did restorecon /path/to/foo or restorecon -v
> /path/to/foo or restorecon -Rv /path/to/foo, just not if you did
> restorecon -R /path/to/foo.  When it was moved to libselinux
> selinux_restorecon(3), it was changed to log a warning if verbose, so
> it logs a warning if you pass -v (with or without -R) but not if you
> just do restorecon /path/to/foo. The patch I sent makes it only log the
> warning if verbose and not recursive, so it will only log if you pass
> -v without -R.
>
> To be honest, I'm not sure what the point of this warning is; it is
> perfectly valid for an entry to have <<none>> to indicate that it
> should not be relabeled at all by restorecon/setfiles.  Maybe we should
> just remove the warning altogether.
>
The problem is people don't understand this.  If a user sees a
user_home_t on /tmp and runs
restorecon on it he expects it to have a label with tmp_t in the name,
and if the tool finishes
silently he thinks he is done.  This reveals to him that their is no
default label, so perhaps he
will do a chcon.  Or `rm -f`.
