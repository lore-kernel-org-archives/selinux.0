Message-ID: <49DA559C.7040400@manicmethod.com>
Date: Mon, 06 Apr 2009 15:18:52 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: SELinux packages version (svn2950)...
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	<1238684951.32379.311.camel@gorn.columbia.tresys.com> <49D563A9.1000607@ak.jp.nec.com> <49D965CA.4030908@ak.jp.nec.com> <D06FE0A2807BC145B0D38744789D4F5D06788A81@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D06788A81@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I work on a product that uses Linux Kernel 2.6.21.  As such, I am
> currently using the following SELinux libs and related package versions:
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
> We are considering moving upto Linux Kernel 2.6.27, and as such we would
> automatically get upgraded to the following package versions:
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
> 3. Are there any disadvantages, or any changes that I should be aware or
> cencerned about ?
> 4. Why is the version number so drastically different ? Is this a result
> of a totally new effort ?
> 5. Please feel free to share any thoughts / suggestions / advice as far
> as upgrading to this newer version...
> 
> Thanks in advance for all your help.
> 

There is no subversion repository anymore, all the subversion repos should be 
down at this point, where did you find that revision?

The packages are now in git at http://userspace.selinuxproject.org/ and a 
release was just made at http://userspace.selinuxproject.org/trac/wiki/Releases .

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
