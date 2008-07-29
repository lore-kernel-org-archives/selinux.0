Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6THcVCR013340
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 13:38:31 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6THcUuH007895
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 17:38:30 GMT
Message-ID: <488F5590.6060908@kutulu.org>
Date: Tue, 29 Jul 2008 13:38:24 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy patch, second try] samba policy updates
References: <488DED3A.1030005@kutulu.org> <1217342823.4934.42.camel@defiant.pebenito.net>
In-Reply-To: <1217342823.4934.42.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito wrote:
> On Mon, 2008-07-28 at 12:00 -0400, Mike Edenfield wrote:
>> +tunable_policy(`samba_create_home_dirs',`
>> +	ifdef(`distro_redhat', `
>> +		refpolicywarn(`Use of samba_create_home_dirs is discouraged.  Please use pam_oddjob_mkhomedir instead.')
>> +	', `
>> +		unprivuser_create_home_dirs(smbd_t)
>> +		allow smbd_t self:capability chown;
>> +	')
>> +')
> 
> I don't think this has the effect that you're trying to get.  The ifdef
> is resolved during build time, and the tunable is resolved at runtime.
> So the warning message won't do any good for most redhat users (and it
> leaves them with a noop samba_create_home_dirs tunable).

I wasn't sure if that would work; I know Dan has expressed a preference 
for RH users to use oddjob for this, but I didn't know if there was any 
way to enforce that.  I certainly didn't want it to silently do nothing. 
  Is there a correct place to document this preference?

>> +interface(`unprivuser_create_home_dirs',`
>> +       unprivuser_home_filetrans_home_dir($1)
>> +       unprivuser_manage_home_dirs($1)
>> +')
> 
> "Create" just means directory create, but you have the full manage
> permission set, in addition to a filetrans.

I think I did go a bit overboard with the manage permissions.  I'd 
copied these from the oddjob's policy, but I notice that oddjobs also 
permits deleting home directories, which probably isn't needed here.

The filetrans is needed, though, because without it, the created home 
directories were getting labeled home_root_t instead of user_home_dir_t. 
  It also needs to copy the template files in and label them correctly, 
like the user_home_ssh_t on .ssh, etc.  I'll narrow this down.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
