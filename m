Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IIR2QZ008677
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:27:02 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IIR1oF025788
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 18:27:01 GMT
Message-ID: <4880E11F.7000108@kutulu.org>
Date: Fri, 18 Jul 2008 14:29:51 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org>  <4880D5FC.5030400@redhat.com> <1216404899.21191.175.camel@gorn>
In-Reply-To: <1216404899.21191.175.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2008-07-18 at 13:42 -0400, Daniel J Walsh wrote:
>> Mike Edenfield wrote:
>>> I apologize if I'm not doing this right, I'm kinda new at this...
>>>
>>> I have made some changes to the SELinux policy for our intranet servers
>>> that I thought might be useful to a broader audience.  Included below is
>>> a patch to the latest refpolicy.  This has been tested on the Gentoo
>>> systems we have here; I don't have easy access to other SELinux systems
>>> at the moment.  It does the following:
> [...]
>>> * Adds a tunable that lets samba create home directories via pam_mkhomedir
> 
>> Could you do this with pam_oddjob_mkhomedir without having to add the
>> privs.  I think this is a better solution.
> 
> What if you don't have oddjob?  It doesn't hurt to have the perms in a
> tunable.  It could be put in a ifndef distro_redhat, if samba in
> fedora/rh requires pam_oddjob_mkhomedir.

If this is the preferable way for RH users to set up samba, would this 
be an appropriate solution?

tunable_policy(`samba_create_home_dirs',`
     ifdef(`distro_redhat', `
         refpolicywarn(`Use of samba_create_home_dirs is discouraged. 
Please use pam_oddjob_mkhomedir instead.')
     ', `
         unprivuser_create_home_dirs(smbd_t)
         allow smbd_t self:capability chown;
     ')
')


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
