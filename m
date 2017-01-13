Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 selinux@tycho.nsa.gov
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
 <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
 <1484256222.16361.23.camel@tycho.nsa.gov>
 <6cd88833-0af5-c935-3c8f-04afc000ceff@gmail.com>
 <1484318901.32375.32.camel@tycho.nsa.gov>
 <1484321279.32375.44.camel@tycho.nsa.gov>
 <6e56f621-188f-16e8-96f1-35cbbde1a0bc@redhat.com>
 <1484336327.32375.69.camel@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <e64eca90-c108-b950-375e-e69942ecd399@gmail.com>
Date: Fri, 13 Jan 2017 19:56:04 +0000
MIME-Version: 1.0
In-Reply-To: <1484336327.32375.69.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 13/01/17 19:38, Stephen Smalley wrote:
> On Fri, 2017-01-13 at 13:29 -0500, Daniel J Walsh wrote:
>> On 01/13/2017 10:27 AM, Stephen Smalley wrote:
>>> On Fri, 2017-01-13 at 09:48 -0500, Stephen Smalley wrote:
>>>> On Thu, 2017-01-12 at 23:42 +0000, Alan Jenkins wrote:
>>>>> My main puzzle here[*] is why `fixfiles` handles sysfs (/sys/)
>>>>> fine,
>>>>> but
>>>>> then there's floods of warnings about debugfs
>>>>> (/sys/kernel/debug/).  The
>>>>> same seems to happen with /dev/ being fine, but not the other
>>>>> virtual
>>>>> fs's with seclabel which are mounted in subdirectories of
>>>>> /dev/.
>>>> This is a bug/regression.  Thanks for reporting it.  In commit
>>>> 36f1ccbb5743749c404ad8f960867923544b90d9, Dan added this warning
>>>> but
>>>> only if the user explicitly does a restorecon /path/to/foo and
>>>> /path/to/foo does not have any matching label in file_contexts;
>>>> in
>>>> the
>>>> case of a restorecon -R or setfiles, it isn't supposed to happen.
>>>>   The
>>>> check on the recursive flag got dropped when this logic was taken
>>>> into
>>>> selinux_restorecon(3) in libselinux
>>>> (commit f2e77865e144ab2e1313aa78d99b969f8f48695e).  Will fix.
>>> Actually, I am wrong about this being a regression (and I should
>>> have
>>> known that, since the buggy version is 2.5 and that precedes the
>>> latter
>>> commit). Looking at the first commit, the original logic was to
>>> display
>>> a warning if not recursive OR verbose, so it would unconditionally
>>> log
>>> a warning if you did restorecon /path/to/foo or restorecon -v
>>> /path/to/foo or restorecon -Rv /path/to/foo, just not if you did
>>> restorecon -R /path/to/foo.  When it was moved to libselinux
>>> selinux_restorecon(3), it was changed to log a warning if verbose,
>>> so
>>> it logs a warning if you pass -v (with or without -R) but not if
>>> you
>>> just do restorecon /path/to/foo. The patch I sent makes it only log
>>> the
>>> warning if verbose and not recursive, so it will only log if you
>>> pass
>>> -v without -R.
>>>
>>> To be honest, I'm not sure what the point of this warning is; it is
>>> perfectly valid for an entry to have <<none>> to indicate that it
>>> should not be relabeled at all by restorecon/setfiles.  Maybe we
>>> should
>>> just remove the warning altogether.
>>>
>> The problem is people don't understand this.  If a user sees a
>> user_home_t on /tmp and runs
>> restorecon on it he expects it to have a label with tmp_t in the
>> name,
>> and if the tool finishes
>> silently he thinks he is done.  This reveals to him that their is no
>> default label, so perhaps he
>> will do a chcon.  Or `rm -f`.
> Old behavior (before moving to selinux_restorecon(3), <= 2.5):
> $ touch /tmp/foo
> $ chcon -t etc_t /tmp/foo
> $ restorecon /tmp/foo
> restorecon:  Warning no default label for /tmp/foo
> $ restorecon -v /tmp/foo
> restorecon:  Warning no default label for /tmp/foo
> $ restorecon -R /tmp/foo
> $ restorecon -Rv /tmp/foo
> restorecon:  Warning no default label for /tmp/foo
>
> So we get the warning without -R or with -v.  Seems kind of surprising
> that -R suppresses it but -Rv does not.
>
> New behavior (after moving to selinux_restorecon(3), 2.6, before my
> patch):
> $ restorecon /tmp/foo
> $ restorecon -v /tmp/foo
> Warning no default label
> for /tmp/foo
> $ restorecon -R /tmp/foo
> $ restorecon -Rv /tmp/foo
> Warning no
> default label for /tmp/foo
>
> Here we get the warning only with -v, independent of -R.
> Seems more consistent from a UI point of view.
> This however doesn't help Alan with his goal of enabling fixfiles check or fixfiles restore -v to show no extraneous output if everything is labeled correctly.
>
> New behavior after my patch:
> $ restorecon /tmp/foo
> $ restorecon -v /tmp/foo
> Warning no default label for /tmp/foo
> $ restorecon -R /tmp/foo
> $ restorecon -Rv /tmp/foo
>
> Here we only get the warning with -v without -R.
> This avoids the problem for fixfiles check but doesn't help your situation and is confusing usage as well.
>
> Also, I think you only want this warning if the user-supplied pathname
> has no default label.  Which would mean we need to do this check and
> warning early, not down where we are checking or applying the labels to individual files within a tree walk.

Thank you for considering my report so seriously.

Your suggestion sounds very promising!

It sounds like a pretty nice compromise, if e.g. processing /var could 
omit the warnings caused by processing files under /var/tmp.

The corner case I wasn't 100% sure about, is if the path you pass is 
e.g. `/tmp`.  Looking at `file_contexts` it seems very sensible though.  
/tmp itself is ignored, so passing `/tmp` would still provide our 
friendly warning.  (I guess the label on /tmp comes from the package, 
e.g. the `filesystem` rpm on Fedora).

Alan
