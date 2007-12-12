Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCKihs1025511
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 15:44:43 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBCKige8002040
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 20:44:42 GMT
Received: by nz-out-0506.google.com with SMTP id i1so222774nzh.39
        for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 12:44:42 -0800 (PST)
Message-ID: <476047A9.90000@gmail.com>
Date: Wed, 12 Dec 2007 14:42:17 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole in the background
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net>
In-Reply-To: <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Reed, Tim (US SSA) wrote:
> I have made my modifications to newrole.  Is there any testcases or
> documentation on what needs to be tested before submitting a patch?
> With the minimal testing that I have done everything appears to be
> working correctly.
>
> Attached is the patch file.  Please review and comment.
>
> Thanks!
> Tim
>
>
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Tuesday, December 11, 2007 1:18 PM
> To: Xavier Toth
> Cc: Reed, Tim (US SSA); selinux@tycho.nsa.gov
> Subject: Re: newrole in the background
>
> On Tue, 2007-12-11 at 10:06 -0600, Xavier Toth wrote:
>   
>> We ended up creating a variant of newrole which doesn't require tty
>> access. We did this to run some of our applications in the background
>> but still get newroles ability to set the context/level of the child
>> and to create a pam session for polyinstantiation. For this to work we
>> had to configure our apps into our variants equivalent of
>> /etc/selinux/newrole_pam.conf and provide corresponding /etc/pam.d
>> files which typically look like :
>> #%PAM-1.0
>> auth       required     pam_permit.so
>> account    required     pam_permit.so
>> password   required     pam_permit.so
>> session    required     pam_mkpolydir.so debug
>> session    required     pam_namespace.so unmnt_remnt
>> no_unmount_on_close gen_hash ignore_instance_parent_mode debug
>>
>> This variant was based on a Fedora policysoreutils source rpm because
>> the RHEL5 version doesn't contain the code to map applications to
>> /etc/pam.d files using /etc/selinux/newrole_pam.conf.
>>     
>
> As a workaround, you could certainly create a pty in your application
> and use that for newrole - that woudl let you use newrole unmodified.
>
> As a longer term solution, I'd suggest making a patch for newrole that
> allows it to gracefully function even in the absence of a tty, and get
> that upstreamed, so that you can use newrole as is.
>
>   
What happens if a command passed as an argument has a pam configuration 
that requires a password to be entered?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
