Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA1G2Lah019868
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 12:02:21 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oA1G2Kqf022664
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2010 16:02:20 GMT
Message-ID: <4CCEE48B.2080306@tresys.com>
Date: Mon, 01 Nov 2010 12:02:19 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Format of  file_contexts file
References: <20100312205537.GA1091@us.ibm.com> <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com> <20100314053521.GA12410@us.ibm.com> <D06FE0A2807BC145B0D38744789D4F5D09C2E5F8@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D09C2E5F8@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/10 01:27, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> My Linux system has a few product-specific directories like  /data,
> /inactive,  /repl
> 
> The default selinux policy would obviously not know how to label these
> directories the way I want, because these are not standard linux
> directories. If I want to label these directories a certain way... For
> example, suppose I want to label all the above directories as var_t,
> can I simply add a few lines to the below two files, and then perform
> relabel ? 
> 
> /etc/selinux/strict/contexts/files/file_contexts
> /etc/selinux/strict/modules/active/file_contexts
> 
> - Is it okay to directly edit those files, or are the above two files
> auto-generated ?
> - If editing the files is okay, then is it okay to stick lines in
> anywhere, or must I follow some kind of convention ?
> - or is there a more recommended way to control how those
> product-specific directories get labeled ?
> 
> - I have actually stuck some lines manually in the middle of the above
> two files, and for the most part it seems to work. But every once in a
> while, I see other directories not getting labeled correctly. Is it
> because the contents of these files have to be in a certain order ? 

These files are generated from the file contexts in the modules and the
local file contexts.  You should add your file contexts to a custom
policy module or use 'semanage fcontext' to add file contexts to the
local configuration.  Then when these files are regenerated, your file
contexts will be included.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
