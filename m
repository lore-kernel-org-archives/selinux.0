Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GIolXf023925
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 13:50:47 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GInelk018344
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 18:49:40 GMT
Subject: Re: [PATCH] sereference: network macros and permissions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Spencer Shimko <sshimko@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200601121403.36679.sshimko@tresys.com>
References: <200601121403.36679.sshimko@tresys.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 13:52:09 -0500
Message-Id: <1137437529.29815.236.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 14:03 -0500, Spencer Shimko wrote:
> -It adds support for generating corenetwork interfaces based on attributes 
> in addition to types.  create_???_type_interfaces  
> create_???_attrib_interfaces have been added to corenetwork.if.m4.
> 
> -Removes an extraneous delcare_ports macro from corenetwork.if.m4.
> 
> -Adds declare_nodes to corenetwork.te.m4.  Permits the listing of multiple 
> nodes in a network_node() that will be given the same type.
> 
> The patch also adds two new permission sets to the object class permission 
> support macros.

Fixed comment for network_node(), and moved new permission sets to where
the other new sets are.  Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
