Subject: Re: genhomedircon uid template
To: Jason Zaman <jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <56AFB25D.1070505@tycho.nsa.gov> <20160202062635.GA12699@meriadoc>
Cc: SELinux List <selinux@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56B0C54B.2080407@tycho.nsa.gov>
Date: Tue, 2 Feb 2016 10:03:39 -0500
MIME-Version: 1.0
In-Reply-To: <20160202062635.GA12699@meriadoc>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/02/2016 01:26 AM, Jason Zaman wrote:
> On Mon, Feb 01, 2016 at 02:30:37PM -0500, Stephen Smalley wrote:
>> On 02/01/2016 04:36 AM, Jason Zaman wrote:
>>> Hi all,
>>>
>>> XDG_RUNTIME_DIR is usually /run/user/$UID but there is no way to label
>>> that in an fcontext file. It used to be /run/user/USER which is easy but
>>> not UID.
>>>
>>> What template keyword should be used for such an entry? UID? USERID?
>>>
>>> USERID is perhaps more obvious but has to be replaced before USER but
>>> that should be doable.
>>> https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L76
>>>
>>> UID does not conflict with USER but this line exists in refpol which
>>> is problematic:
>>> contrib/fetchmail.fc:13:/var/mail/\.fetchmail-UIDL-cache -- gen_context(system_u:object_r:fetchmail_uidl_cache_t,s0)
>>>
>>> This could also be used for several fcontexts in kerberos. It stores the
>>> tickets in /tmp/krbcc_UID for example.
>>>
>>> If we choose a template name I can put together a patch to add it.
>>
>> No strong preferences from me on the particular name, e.g. USERID is
>> fine.  I think it highlights however the problems with the current
>> approach; maybe we ought to be using ${USER} and ${UID} in .fc files
>> instead?
>
> Yes there are definitely problems but fixing would mean refpol and
> probably a lot of other things would need to be updated at the same
> time.
>
> HOME_DIR and HOME_ROOT are not really problems since they are only
> allowed in the beginning of an fcontext line and other lines start with
> a /.
>
> USER, USERID, and possibly other things in future (GROUP, GROUPID?) can
> appear at any point in the the line so a more unique token might be
> better. %USERID might be better than $USERID since thats a thing in
> shells.
>
> If we do go down this path, what are the steps? and what tokens do we
> want?

I think we would provide backward compatibility for the existing tokens, 
at least for some time.  As far as I know, we only need to modify the 
refpolicy build process and libsemanage to support the new tokens.

You need a way to mark the end of the token, either %USERID% or %{USERID}.
