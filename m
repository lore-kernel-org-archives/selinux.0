Subject: Re: [PATCH] Add version option to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <200602081445.14747.glommer@br.ibm.com>
References: <200602081445.14747.glommer@br.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 11:54:53 -0500
Message-Id: <1139417693.2872.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-08 at 14:45 -0200, Glauber de Oliveira Costa wrote:
> Here's a new version that incorporates your suggestions. I moved the constant 
> definition to the makefile, and also, I'm gathering the data from the version 
> file. Also, Steve, I would like to hear from you why do you think the -v 
> option is not that descriptive.
> 
> If you guys accept this patch, my obvious next step would be adding it to the 
> manpage. 

I think his complaint was with our existing usage message (the args
part), not your change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
