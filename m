Subject: Re: Genfscon 'dash' issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: k.tymur@samsung.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <18500085.31951223615264682.JavaMail.weblogic@epml14>
References: <18500085.31951223615264682.JavaMail.weblogic@epml14>
Content-Type: text/plain; charset=utf-8
Date: Fri, 10 Oct 2008 08:45:21 -0400
Message-Id: <1223642721.25569.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-10 at 05:07 +0000, korkishko Tymur wrote:
> Hello! 
> 
> I have Linux kernel 2.6.26 with a patch from NSA that allows genfscon support of security contexts for directories/files (others than / ). 
> I use genfscon to label files/directories on cramfs filesystem(read-only filesystem) that does not support xattr. 
> 
> It seems that current genfscon implementation does not support “–“(dash) in path names. If I try to compile policy containing this line: 
> genfscon          cramfs /usr/sbin/an-app           user_u:system_r:my_app_t 
> 
> I will get an syntax error from checkpolicy aboutusing “– “ (dash) in the path:
> ERROR ‘invalid type app’ at token ‘genfscon’ on line... 
> 
> So, could you please suggest a way to fix theissue with “– “ (dash) and genfscon? 
> 
> Unfortunately, it is not possible to change “–“(dash) to “_” (underbar) in path names.  

You'd have to change policy_parse.y in checkpolicy; at present, it
treats a "-" followed by an identifier as a file type flag (e.g. -d to
only match directories, -b to only match block device files, ...)
similar to the file_contexts specification.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
