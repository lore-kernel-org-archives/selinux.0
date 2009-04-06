MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux packages version (svn2950)...
Date: Mon, 6 Apr 2009 15:48:45 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D06788ACE@de01exm68.ds.mot.com>
In-Reply-To: <49DA559C.7040400@manicmethod.com>
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	<1238684951.32379.311.camel@gorn.columbia.tresys.com> <49D563A9.1000607@ak.jp.nec.com> <49D965CA.4030908@ak.jp.nec.com> <D06FE0A2807BC145B0D38744789D4F5D06788A81@de01exm68.ds.mot.com> <49DA559C.7040400@manicmethod.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Joshua Brindle" <method@manicmethod.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        "Cheng Heilung-HCHENG1" <Heilung.Cheng@motorola.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We get our Linux OS and filesystem packaged from a third-party company.
These are the versions of the SELinux packages included in the bundle.
The version number looked a bit strange to me, so I wanted to check with
the selinux community...

So are you saying this  "svn2950" version doesn't officially exist
anymore, and its *NOT* a stable and tested version ?

Thanks,

- Rezaul.


-----Original Message-----
From: Joshua Brindle [mailto:method@manicmethod.com] 
Sent: Monday, April 06, 2009 2:19 PM
To: Hasan Rezaul-CHR010
Cc: Stephen Smalley; selinux@tycho.nsa.gov
Subject: Re: SELinux packages version (svn2950)...

Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I work on a product that uses Linux Kernel 2.6.21.  As such, I am 
> currently using the following SELinux libs and related package
versions:
> 
> audit            1.5.3
> checkpolicy      1.33.1
> libselinux       2.0.13
> libsemanage      2.0.1
> libsepol         2.0.3
> libsetrans       0.1.18
> policycoreutils  2.0.16
> 
> 
> 
> We are considering moving upto Linux Kernel 2.6.27, and as such we 
> would automatically get upgraded to the following package versions:
> 
> audit            1.7.2
> checkpolicy      svn2950
> libselinux       svn2950
> libsemanage      svn2950
> libsepol         svn2950
> libsetrans       N/A
> policycoreutils  svn2950
> 
> 
> ** My questions are:
> 
> 1. Do all the packages of version (svn2950) play nicely together ?
> 2. What are the major advantages of upgrading to svn2950 ?
> 3. Are there any disadvantages, or any changes that I should be aware 
> or cencerned about ?
> 4. Why is the version number so drastically different ? Is this a 
> result of a totally new effort ?
> 5. Please feel free to share any thoughts / suggestions / advice as 
> far as upgrading to this newer version...
> 
> Thanks in advance for all your help.
> 

There is no subversion repository anymore, all the subversion repos
should be down at this point, where did you find that revision?

The packages are now in git at http://userspace.selinuxproject.org/ and
a release was just made at
http://userspace.selinuxproject.org/trac/wiki/Releases .


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
