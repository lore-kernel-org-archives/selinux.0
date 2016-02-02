Subject: Re: genhomedircon uid template
To: Jason Zaman <jason@perfinion.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <56AFB25D.1070505@tycho.nsa.gov> <20160202062635.GA12699@meriadoc>
CC: SELinux List <selinux@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <56B0B5E3.5000007@tresys.com>
Date: Tue, 2 Feb 2016 08:57:55 -0500
MIME-Version: 1.0
In-Reply-To: <20160202062635.GA12699@meriadoc>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2/2/2016 1:26 AM, Jason Zaman wrote:
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

Neglecting any %, {}, etc. I suggest being explicit: UNAME or USERNAME
rather than USER.  That would make a clearer intent, similar to UID or
USERID.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
