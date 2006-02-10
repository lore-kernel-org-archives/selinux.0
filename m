Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AKcYXf015271
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 15:38:35 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AKcUTR018021
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 20:38:30 GMT
Subject: Re: [PATCH] XML Documentaion Modification and Third Party Module
	support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: David Sugar <dsugar@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200602101427.48881.dsugar@tresys.com>
References: <200602101427.48881.dsugar@tresys.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 15:39:56 -0500
Message-Id: <1139603997.13925.100.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 14:27 -0500, David Sugar wrote:
> This is a patch for reference policy that achieved the following

Merged.

> 1) install a set of headers for each $NAME, instead of a single generic set, 
> and put the .if files into layer directories under 
> the /usr/share/selinux/$NAME/include directory.
> 2) install the layer, booleans and tunables xml files into the include 
> directory
> 3) install the xml generation tool (segenxml.py)
> 4) include the <desc> xml tag around parameter descriptions for 
> global_tunables and global_booleans
> 5) install build.conf into the include directory
> 6) install Makefile.example into the include directory
> 
> 7) modify segenxml.py to work for out of layer (third party) modules
> 8) modify segenxml.py to generate xml files for global_tunables and 
> global_booleans
> 
> Also a sed script is included to change the xml in the .if files to wrap the 
> parameter information in a <summary> tag.
> 
> #1-3 & 7-8 will allow policy.xml to be regenerated when someone is generating 
> a 3rd part module.  
> 
> #4 will make translations easily doable in the future
> 
> #5-6 will make the user module building work similar to building kernel 
> modules outside of /usr/src/linux
> 
> Dave Sugar
> Tresys Technology 
> dsugar@tresys.com
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
