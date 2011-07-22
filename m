MIME-Version: 1.0
In-Reply-To: <1311342293.20800.15.camel@moss-pluto>
References: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
	<1311342293.20800.15.camel@moss-pluto>
Date: Fri, 22 Jul 2011 10:00:45 -0400
Message-ID: <CACLa4psnpaMGaRt7=pOF2hz7ue0v7KssJ7F6VhXiQ=JqtaDVxw@mail.gmail.com>
Subject: Re: PythonSELinux binding problem
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: rarob@travelinglightfarm.net, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 22, 2011 at 9:44 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2011-07-21 at 17:33 -0400, rarob@travelinglightfarm.net wrote:
>> Hi,
>>   I'm using the python selinux bindings to determine if SELinux is
>> disable/permissive/enforcing.  The following snippet of code works just
>> fine on RH5 and F10 regardless of the SELinux mode, but fails with an
>> error on F11/12/13 and RH6 if SELinux is disabled.
>>
>> $ python -c 'import selinux ; print selinux.security_getenforce()'
>>
>> Under RH5 and F10 I correctly get the -1/0/1 returns for
>> disabled/permissive/enforcing, as specified in the man pages for
>> 'security_getenforce'.  Under F11/12/13 and RH6 for permissive and
>> enforcing I get the correct return values, but if the system is in
>> disabled mode instead an OSError is thrown for 'No such file or
>> directory'.  I haven't look at the source for the underlying
>> security_getenforce() system call, but I suspect is is assuming that the
>> /selinux pseudo filesystem is populated (as in permissive/enforcing mode),
>> and is not handling the case where that pseudo filesystem is empty.
>>
>> For now I've got my python calls wrapped in try/except blocks treating any
>> exception as SELinux in disabled mode.
>>
>> I wasn't sure where the best place to log this as a bug is, either for the
>> libselinux-python package or libselinux itself.
>
> I don't know why this would have ever worked, as security_getenforce()
> has always returned -1 with errno ENOENT if there is no selinuxfs mount.
> Maybe the older python bindings handled this error condition?  The
> correct test for enabled/disabled is selinux.is_selinux_enabled(), and
> that should be checked prior to calling security_getenforce().

Looks like the change is in my tree (but not upstream)  [not the title
is slightly wrong]

http://git.infradead.org/users/eparis/selinux-userspace.git/commitdiff/958217e94829487815ea3b62b264aa18b466ce4a


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
