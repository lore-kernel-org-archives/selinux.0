Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IJ075Q015020
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 15:00:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IJ0629027418
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 19:00:07 GMT
Message-ID: <4880E818.50201@redhat.com>
Date: Fri, 18 Jul 2008 14:59:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Mike Edenfield <kutulu@kutulu.org>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org>  <4880D5FC.5030400@redhat.com> <1216404899.21191.175.camel@gorn>
In-Reply-To: <1216404899.21191.175.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
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
> 
I have more of a problem with pam_mkhomedir from login programs since
samba can currently read/write homedirs with a boolean.  It is not as
big a deal.  oddjob just breaks things out the way SELinux likes it.
Pam modure requests a service create a homedir.  Service execs a job to
create the homedir.  Each process gets a different context.


gentoo should look into it.

But I am fine with adding the patch.  pam_mkhomedir does not work well
currently with ssh, locallogin, gdm on Fedora platform.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
