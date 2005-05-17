Message-ID: <4289E683.1030702@redhat.com>
Date: Tue, 17 May 2005 08:41:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Busted by constraints.
References: <428368FF.2080603@redhat.com>	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>	 <42836C4C.6010301@redhat.com>	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>	 <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>	 <428917F4.6030203@redhat.com> <1116329977.917.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1116329977.917.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-05-16 at 18:00 -0400, Daniel J Walsh wrote:
>  
>
>>I think, this patch is needed to export symbols of newly added libsepol 
>>functions. 
>>    
>>
>
>No.  These particular functions are _only_ for the static library and
>programs that link with it, as they expose too much of the internals of
>libsepol.  Note that audit2why is linked with libsepol.a, not the shared
>library (prior to your policycoreutils patch).  We will not _export_
>these symbols via the shared library.
>
>  
>
Ok libdir needs to be passed in via spec file.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
