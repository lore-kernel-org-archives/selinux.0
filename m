Message-ID: <3F7A2810.1060907@diyab.net>
Date: Tue, 30 Sep 2003 21:04:16 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Kratzer, James R." <JamesK@xetron.com>,
   "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: glibc check errors
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A41@s3cin> <1064945244.6364.39.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1064945244.6364.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2003-09-30 at 13:30, Kratzer, James R. wrote:
> 
>>I am running the new 2.4 based SELinux kernel and userland archive on Red
>>Hat 9.  If I understand you correctly, since the glibc changes have been
>>upstreamed and were not SELinux specific, you will be releasing soon a new
>>userland archive which will require an updated version of the glibc package.  
>>If this is correct, how soon do you anticipate the release of the new
>>userland archive and the release of the new glibc package ( glibc-2.3.3
>>maybe? )?  Can I use the current userland archive utilities without the
>>patched glibc?
> 
> 
> You don't need the modified glibc to use the userland archive
> utilities.  The glibc patch was to make glibc recognize security
> transitions other than just setuid/setgid, so that it will enable its
> secure mode for programs that cause a change in other security
> attributes (e.g. role/domain) as well as for setuid/setgid programs. 
> That is important for security, but not a functional requirement for
> using the system.  The modification to glibc has made its way upstream
> and I believe that it is available in the RedHat beta (severn / fedora
> core).
> 
> We'll be making an updated release of the kernel and userland archives
> soon, likely later this week.
> 

So is this new glibc version available as the mainstream glibc package 
or will non redhat users still have to apply the patch.  And if is or 
will be soon available as mainstream glibc do you know what version?

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
