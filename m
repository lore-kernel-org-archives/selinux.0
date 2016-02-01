Subject: Re: genhomedircon uid template
To: Jason Zaman <jason@perfinion.com>, SELinux List <selinux@tycho.nsa.gov>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56AFB25D.1070505@tycho.nsa.gov>
Date: Mon, 1 Feb 2016 14:30:37 -0500
MIME-Version: 1.0
In-Reply-To: <20160201093633.GB21978@meriadoc.perfinion.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/01/2016 04:36 AM, Jason Zaman wrote:
> Hi all,
>
> XDG_RUNTIME_DIR is usually /run/user/$UID but there is no way to label
> that in an fcontext file. It used to be /run/user/USER which is easy but
> not UID.
>
> What template keyword should be used for such an entry? UID? USERID?
>
> USERID is perhaps more obvious but has to be replaced before USER but
> that should be doable.
> https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L76
>
> UID does not conflict with USER but this line exists in refpol which
> is problematic:
> contrib/fetchmail.fc:13:/var/mail/\.fetchmail-UIDL-cache -- gen_context(system_u:object_r:fetchmail_uidl_cache_t,s0)
>
> This could also be used for several fcontexts in kerberos. It stores the
> tickets in /tmp/krbcc_UID for example.
>
> If we choose a template name I can put together a patch to add it.

No strong preferences from me on the particular name, e.g. USERID is 
fine.  I think it highlights however the problems with the current 
approach; maybe we ought to be using ${USER} and ${UID} in .fc files 
instead?
