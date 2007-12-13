Subject: RE: newrole in the background
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 13 Dec 2007 04:30:32 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F517AD3@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net> <476047A9.90000@gmail.com>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: "Ted X Toth" <txtoth@gmail.com>, <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good point.  That is why I was looking for test cases or something.  

I am going to explore Stephen suggestion more of making the lack of a
tty non-fatal.  But won't we want newrole to have a tty so that it can
send/receive input from the user?  That is the reason why I was having
it creating a pseudo tty.

Suggestions.....


-----Original Message-----
From: Ted X Toth [mailto:txtoth@gmail.com] 
Sent: Wednesday, December 12, 2007 3:42 PM
To: Reed, Tim (US SSA)
Cc: SE Linux
Subject: Re: newrole in the background

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
>> and to create a pam session for polyinstantiation. For this to work
we
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
