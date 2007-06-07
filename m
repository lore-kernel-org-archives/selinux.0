Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57IuFvL001694
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 14:56:15 -0400
Message-ID: <466854CD.1030308@tycho.nsa.gov>
Date: Thu, 07 Jun 2007 14:56:13 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/5] libselinux: add object class discovery
References: <1181223423.6578.78.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181223423.6578.78.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> This patch set adds basic support to libselinux to leverage the kernel
> portion of the object class discovery, exported in selinuxfs, to handle
> the four string<->value functions for classes and permissions.  When a
> class is looked up, all of the names and values of the permissions for
> the class are looked up and cached.
> 
> Rebased for the errno change.
> 

I have merged this patchset, thanks.

Note: the "hidden_def" magic incantations should be probably be updated 
at some point.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
