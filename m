Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGp0L9008849
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:51:00 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FGlXw2023629
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 16:47:35 GMT
Message-ID: <4212280E.2080002@redhat.com>
Date: Tue, 15 Feb 2005 11:49:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SE-Linux <selinux@tycho.nsa.gov>, Frank Mayer <mayerf@tresys.com>
Subject: Re: Adding libseuser functionality to libselinux?
References: <20050215155323.GC23765@lkcl.net>  <421221C0.20907@redhat.com> <1108484448.17854.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1108484448.17854.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-02-15 at 11:22, Daniel J Walsh wrote:
>  
>
>>Thoughts on moving some of the functions available in setools into 
>>libselinux.
>>
>>Basically I want to add the ability to addroles via the adduser command  
>>(shadow-utils) and thus
>>make dealing with roles easier in OS.  The problem is that I don't want 
>>to require setools  in
>>order to get this functionality (libseuser).   
>>
>>I need the ability to get the roles that are available via the currently 
>>running policy and to manipulate
>>the users defined in the local.users file.  I then need to have 
>>genpolusers type functions to allow me
>>to change the running policy.  We don't need the functionality that 
>>deals with policy-sources.
>>
>>What do you think of moving these functions into libselinux?
>>    
>>
>
>I think you want them in libsepol, not libselinux.  The former is for
>binary policy manipulation (which can still deal with the "active"
>policy file that happesn to be presently loaded, as long as said file
>still exists on the filesystem and you can reliably find it) and can be
>used even on non-SELinux systems (an important property for building and
>analyzing policies).  The latter is only for security-aware applications
>running on a SELinux kernel.
>
>I do plan to look into migrating genpolusers functionality into
>libsepol, as I formerly did for genpolbools, to allow load_policy and
>init to generate the users database based on local customizations at
>load time, just as they currently set the booleans based on local
>customizations at load time.  I'm not sure what you want from libseuser;
>you can certainly implement functions in libsepol that extract the set
>of roles for a user and manipulate it.
>
>  
>
Yes that makes more sense. 
I need the ability to read/add/modify/delete a user record in the 
local.users file.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
