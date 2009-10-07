From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: CoreutilsBugs <bug-coreutils@gnu.org>,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?=
 <ovasik@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, yaneti@declera.com
Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
In-Reply-To: <1254919072.2251.186.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 07 Oct 2009 08:37:52 -0400")
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	<87zl85bs0e.fsf@meyering.net>
	<1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil>
	<87d451boea.fsf@meyering.net> <87r5th7xd0.fsf@meyering.net>
	<1254919072.2251.186.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 07 Oct 2009 14:48:40 +0200
Message-ID: <871vlfz7x3.fsf@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
...
> FWIW, there is a subtle difference here:
> - chcon can in fact work on a SELinux-disabled kernel, as you can still
> set the security.* extended attributes as long as the filesystem
> provides handlers for the security.* namespace.
> - runcon cannot work without a SELinux-enabled kernel, as only a
> SELinux-enabled kernel allows you to set the security context of a
> running process.
>
> So by preventing chcon from running in the SELinux-disabled case, you
> are imposing a restriction above and beyond what is strictly required.
> The user can of course still use setfattr -n security.selinux -v
> <context> <path> to set a SELinux security context on a file when
> SELinux is disabled, or can run the setfiles program to set SELinux
> security contexts on an entire file tree even when SELinux is disabled.
...
>> diff --git a/src/chcon.c b/src/chcon.c
>> index fbfdb4d..c0da694 100644
>> --- a/src/chcon.c
>> +++ b/src/chcon.c
>> @@ -519,6 +519,10 @@ main (int argc, char **argv)
>>        usage (EXIT_FAILURE);
>>      }
>>
>> +  if (is_selinux_enabled () != 1)
>> +    error (EXIT_FAILURE, 0,
>> +           _("%s may be used only on a SELinux kernel"), program_name);
>> +

Thanks for the tip.
I'll revert that part of the patch.

I'll address the original problem by adding
getfilecon and lgetfilecon wrappers that
map those unusual cases (10,"unlabeled" and 0,NULL)
to a return value of -1 with errno == ENOTSUPP.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
