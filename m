Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FIQGL9009898
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 13:26:16 -0500 (EST)
Message-ID: <42123E61.9020300@redhat.com>
Date: Tue, 15 Feb 2005 13:24:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Scott Cain <cain@cshl.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Determining if SELinux is installed
References: <1108484321.3297.45.camel@localhost.localdomain>	 <1108485238.17854.110.camel@moss-spartans.epoch.ncsc.mil>	 <1108486127.3297.55.camel@localhost.localdomain>	 <42122D9E.40806@redhat.com> <1108490656.3297.64.camel@localhost.localdomain>
In-Reply-To: <1108490656.3297.64.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Scott Cain wrote:

>On Tue, 2005-02-15 at 12:13 -0500, Daniel J Walsh wrote:
>  
>
>>Why can't you fully path it?  Just checking if the /proc/filesystem 
>>exists is not sufficient, if the user has disabled
>>SELinux via /etc/selinux/config instead of selinux=0, I think.  
>>selinuxenabled also checks to see if a policy has been
>>loaded.
>>
>>I would do the equivalent of
>>
>>[ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled
>>
>>in perl.
>>
>>
>>Dan
>>    
>>
>Hi Dan,
>
>I don't particularly like giving the full path to something for exactly
>a reason that Stephen gave: it used to be in /usr/bin, now it's
>in /usr/sbin, next, some genius will move it to /usr/libexec (or similar
>foolishness).  If I can't count on it being in the users path, I don't
>want it.  Otherwise, I'll always have a potential failure point if
>selinuxenabled is moved in some other distro.
>
>Also, at the moment, the installer isn't going to do anything tricky.
>If it detects that SELinux is installed (or might be), it will die with
>a warning message telling the user what to do.  To get past that point,
>the user will have to pass in a flag on the command line telling the
>installer that all is well.
>
>The "what to do" at this point is: make sure the policies are up to
>date, and then disable everything for httpd, or run in permissive mode,
>or disable it altogether.
>
>Scott
>
>  
>
Another option would be to execute something like
id -Z
I don't have a non SELinux machine right now to know if that exits 
non-zero.  But it reports that SELinux is not enabled.
selinuxenabled was not considered a userspace tool that is why it was 
moved along with a lot of other helper tools.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
