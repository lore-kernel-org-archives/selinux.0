Date: Tue, 14 Oct 2008 02:00:55 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Re: Re: Genfscon 'dash' issue
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: korkishko Tymur <k.tymur@samsung.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Reply-to: k.tymur@samsung.com
Message-id: <18936577.156001223949655112.JavaMail.weblogic@epml17>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have checked policy_parse.y. It has following rule for genfscon:
 
genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
	{if (define_genfs_context(1)) return -1;}
	| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
	{if (define_genfs_context(1)) return -1;}
	 | GENFSCON identifier path security_context_def
	{if (define_genfs_context(0)) return -1;} 

The rule for path definition (in policy_scan.l) has already included '-' (dash):

"/"({alnum}|[_.-/])*	        { return(PATH); } 

In my understanding (maybe wrong), path is parsed first (and path might include '-') and only then separate '-' is parsed. 
But it still produces an error if path definition is correct and includes '-'.

Any ideas/patches how to fix grammar rules are welcomed.

Tymur Korkishko

P.S.
Also if '--' or '-d' are available in genfscon with '-' in path name, policy compiler fails: 
genfscon          cramfs /usr/sbin/an-app    --       user_u:system_r:my_app_t
genfscon          cramfs /usr/sbin/an-app    -d       user_u:system_r:my_app_t



------- Original Message -------
Sender : Stephen Smalley<sds@tycho.nsa.gov>
Date   : Oct 10, 2008 21:45 (GMT+09:00)
Title  : Re: Genfscon &#39;dash&#39; issue

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

You&#39;d have to change policy_parse.y in checkpolicy; at present, it
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

 
 
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
