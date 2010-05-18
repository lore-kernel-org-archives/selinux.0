MIME-Version: 1.0
In-Reply-To: <1274212729.8879.171.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTinBSFB6IQCU2BEbYIu1NY_fGSVDwD0BNLZJXC7x@mail.gmail.com>
	 <1274212729.8879.171.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 19 May 2010 01:09:42 +0500
Message-ID: <AANLkTim5wboweoEZfwAIar73Jvskjh4riiAriRzYhA8U@mail.gmail.com>
Subject: Re: Need Help with security: ebitmap: map size 0 does not match my
	size 64 (high bit was 4)
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: waqar afridi <afridi.waqar@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2010 at 12:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2010-05-17 at 12:24 +0500, waqar afridi wrote:
>> Hello All
>>
>> I am trying to port trisys reference policy on my Openmoko Software
>> Stack, When ever I try to load it I get the Following error
>>
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> root@om-gta02 ~/refpolicy $ make load
>> Loading configured modules.
>> /usr/sbin/semodule -s refpolicy
>> -b /usr/share/selinux/refpolicy/base.pp
> <snip>
>> security: ebitmap: map size 0 does not match my size 64 (high bit was
>> 4)
>> libsepol.sepol_module_package_read: invalid module in module package
>> (at section 0)
>> libsemanage.semanage_load_module: Error while reading from module
>> file /etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.
>> /usr/sbin/semodule:  Failed!
>>
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> Reference Policy Version: 2008 04 02
>>
>> semodule from: policycoreutils-2.0.55
>>
>> Any Suggestion what could be the Problem???
>
> I haven't seen that error previously.  It implies that the unconfined.pp
> module was incorrectly compiled or somehow corrupted.
>
> Is it reproducible with a more modern selinux userspace and refpolicy?
> http://userspace.selinuxproject.org/trac/wiki/Releases
> http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease

We got it solved ... some variables were not set properly during
compilation. Tomorrow we start testing.


-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
