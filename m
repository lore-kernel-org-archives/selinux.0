Message-ID: <4B4CD2C5.1040008@redhat.com>
Date: Tue, 12 Jan 2010 14:51:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: SELinux questions...
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com> <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil> <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com> <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D07F0AA3D@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07F0AA3D@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/12/2010 02:37 PM, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I have a few questions that I had asked in the past, so I apologize in
> advance for the repetition. I had a hard-drive crash recently and lost
> all my old emails  :-(
> 
> 1. What was the SEMANAGE syntax to add selinux user mappings for a GROUP
> as opposed to creating selinux mappings to a specific Linux user ?
> 
%name same as sudoers

man semanage
...
       semanage login -{a|d|m} [-sr] login_name | %groupname


> 2. What was the link to the "SELinux User Guide" document that a few
> people have been putting together ?
> 
http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/

> 3. Other than the document above, is there any other useful documents
> out there that describe the design details and framework for the latest
> Refpolicy?
> 
Well this document exists also.

http://docs.fedoraproject.org/selinux-managing-confined-services-guide/en-US/F11/html/

Not quite what you want.

http://oss.tresys.com/projects/refpolicy

> Thanks as always for your help...
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
