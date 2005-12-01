Message-ID: <438EFDB3.3040004@redhat.com>
Date: Thu, 01 Dec 2005 08:42:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Tom London <selinux@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: matchpathcon_init overhead
References: <1133385496.26593.405.camel@moss-spartans.epoch.ncsc.mil>	 <438E23C6.6040509@redhat.com> <1133439793.26593.410.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133439793.26593.410.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-11-30 at 17:12 -0500, Daniel J Walsh wrote:
>   
>> Why can't we confirm after the match.
>>
>> IE Match /dev/mydevice, now verify you have a good context.
>>
>> Then allow restorcon/fixfiles ... to do it the old way.
>>     
>
> That would avoid the overhead of context canonicalization/validation,
> but wouldn't avoid the overhead of the regex compilation on all of
> file_contexts.  We can try that first if you want, but allowing
> applications to select a subset of file_contexts entries for matching
> seems useful.
>
>   
I was just thinking of the case of install.  If you using install for 
installing /usr/share/mypackage/myfile,
I guess you could submit /usr as the device, but you are still going to 
get a hell of a lot of matches.  Then
there is the case of you installing into /mydir/mypackage, and /mydir 
would be submitted and probably match nothing, so
what happens then.  May be we want both options.  One for udev and one 
for apps apps that use matchpathcon like install.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
